#include <Arduino.h>
#include <avr/io.h>  // TWSR, TWDR etc.

#define F_CPU 16000000UL
#define BAUD_RATE 9600UL
#define ADX345_I2C_ADDR 0x53

// ----------------- UART minimal, dacă ai nevoie de debug -----------------
void uart_init(unsigned long baud) {
  unsigned int ubrr_value = (F_CPU / 16 / baud) - 1;
  UBRR0H = (unsigned char)(ubrr_value >> 8);
  UBRR0L = (unsigned char)(ubrr_value & 0xFF);
  UCSR0B = (1 << RXEN0) | (1 << TXEN0);
  UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);
}

void uart_sendChar(char c) {
  while (!(UCSR0A & (1 << UDRE0))) { }
  UDR0 = c;
}

void uart_sendString(const char* str) {
  while (*str) {
    uart_sendChar(*str++);
  }
}
// ----------------- Sfârșit UART minimal -----------------------------------

class I2cMaster {
protected:
  void _writeByte(char data) {
    TWDR = data;
    TWCR = (1<<TWINT) | (1<<TWEN);
    while (!(TWCR & (1<<TWINT)));
  }

  void _readByte(char& data, bool ack) {
    if (ack) {
      TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWEA);
    } else {
      TWCR = (1<<TWINT) | (1<<TWEN);
    }
    while (!(TWCR & (1<<TWINT)));
    data = TWDR;
  }

public:
  void init() {
    TWBR = 12;
    TWSR = 0;
    DDRC &= ~((1 << PC4) | (1 << PC5));
    PORTC |= (1 << PC4) | (1 << PC5);
  }

  void sendStart() {
    TWCR = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN);
    while (!(TWCR & (1<<TWINT)));
  }

  // write addr and write mode
  bool writeAddrW(char addr7) {
    _writeByte((addr7 << 1) | 0);
    uint8_t status = (TWSR & 0xF8);
    if (status != 0x18) { // SLA+W + ACK
      return false; 
    }
    return true;
  }

  // write addr and read mode
  bool writeAddrR(char addr7) {
    _writeByte((addr7 << 1) | 1);
    uint8_t status = (TWSR & 0xF8);
    if (status != 0x40) { // SLA+R + ACK
      return false; 
    }
    return true;
  }

  bool writeByte(char d) {
    _writeByte(d);
    uint8_t status = (TWSR & 0xF8);
    if (status != 0x28) { // data + ACK
      return false;
    }
    return true;
  }

  bool readByte(char& d, bool ack) {
    _readByte(d, ack);
    uint8_t status = (TWSR & 0xF8);
    if (ack) {
      if (status != 0x50) { // data + ACK
        return false;
      }
    } else {
      if (status != 0x58) { // data + NACK
        return false;
      }
    }
    return true;
  }

  void sendStop() {
    TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWSTO);
  }
};

// Obiect global
I2cMaster wire;

// -----------------------------------------------------------
// Funcție care citește X, Y, Z din ADXL345 (în ±2g mode)
// -----------------------------------------------------------
void ADXL_readXYZ(int16_t& x, int16_t& y, int16_t& z) {
  // Mergem la registrul 0x32
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(0x32);
  wire.sendStart();
  wire.writeAddrR(ADX345_I2C_ADDR);

  char x0, x1, y0, y1, z0, z1;
  wire.readByte(x0, true);  
  wire.readByte(x1, true);
  wire.readByte(y0, true);
  wire.readByte(y1, true);
  wire.readByte(z0, true);
  wire.readByte(z1, false);

  wire.sendStop();

  x = (int16_t)((x1 << 8) | (uint8_t)x0);
  y = (int16_t)((y1 << 8) | (uint8_t)y0);
  z = (int16_t)((z1 << 8) | (uint8_t)z0);
}

// -----------------------------------------------------------
// Funcție care scrie un singur offset (8 biți) într-un registru ADXL345
// 0x1E -> X offset, 0x1F -> Y offset, 0x20 -> Z offset
// -----------------------------------------------------------
void ADXL_writeOffset(char regAddr, char offsetVal) {
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(regAddr);
  wire.writeByte(offsetVal); 
  wire.sendStop();
}

// -----------------------------------------------------------
// Calibrare:
// 1. Citește X, Y, Z
// 2. Calculează offset (astfel încât X, Y, Z să devină 0)
// 3. Scrie offsetul în registrele 0x1E, 0x1F, 0x20
// -----------------------------------------------------------
void calibrateADXL() {
  int16_t x, y, z;
  ADXL_readXYZ(x, y, z);

  // Având x, y, z, stabilim ce offset vrem.
  // Formula tipică de la ADXL345 e offset = - (raw / 4), pentru a anula
  // valorile citite. (Atenție la range, ±2g => 10 biți semnați.)
  // Dacă vrei să lași Z la 1g, ai schimba formula doar pt. Z.
  
  char offsetX = -(x >> 2);
  char offsetY = -(y >> 2);
  char offsetZ = -(z >> 2);
  
  // Scriem offset-urile
  ADXL_writeOffset(0x1E, offsetX); // offset X
  ADXL_writeOffset(0x1F, offsetY); // offset Y
  ADXL_writeOffset(0x20, offsetZ); // offset Z

  // (Opțional) Poți citi din nou și să vezi cât de apropiați
  // sunt X, Y, Z de zero după aplicarea offset-urilor.
}

// -----------------------------------------------------------
// Setup
// -----------------------------------------------------------
void setup() {
  // Inițiere UART la 9600 (dacă vrei debug) 
  uart_init(BAUD_RATE);

  // Inițiem magistrala I2C
  wire.init();
  _delay_ms(200);

  // Punem ADXL345 în modul "measure" (registrul 0x2D = 0x08)
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(0x2D);
  wire.writeByte(0x08);
  wire.sendStop();
  _delay_ms(200);

  // APELI CALIBRAREA O SINGURĂ DATĂ
  calibrateADXL();
}

// -----------------------------------------------------------
// Citim periodic valorile citite după calibrare (opțional)
// -----------------------------------------------------------
void loop() {
  int16_t x, y, z;
  ADXL_readXYZ(x, y, z);

  // Trimitem pe UART (dacă vrei să vezi)
  uart_sendString("X=");  
  // conversie int -> string manuală
  {
    char buf[8];
    itoa(x, buf, 10);
    uart_sendString(buf);
  }

  uart_sendString(" Y=");
  {
    char buf[8];
    itoa(y, buf, 10);
    uart_sendString(buf);
  }

  uart_sendString(" Z=");
  {
    char buf[8];
    itoa(z, buf, 10);
    uart_sendString(buf);
  }
  uart_sendString("\r\n");

  _delay_ms(500);
}
