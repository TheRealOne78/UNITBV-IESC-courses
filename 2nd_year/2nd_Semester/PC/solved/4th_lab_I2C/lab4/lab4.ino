// Obiective:
// 1. configurare interfata I2C
// 2. scrierea si citirea pe I2C
// 3. utilizarea accelerometru ADXL345

// Componente
// Senzor acelerometru ADXL345

// Documentatie
// ADXL345 Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl345.pdf

#define ADX345_I2C_ADDR 0x53
#include <avr/io.h>
#include <util/delay.h>
#include <string.h> // Include string.h pentru strlen

#ifndef F_CPU
#define F_CPU 16000000UL // Frecvența procesorului (16 MHz)
#endif
#define BAUD 9600
#define MYUBRR F_CPU / 16 / BAUD - 1

class UART {
public:
  void init() {
    DDRD |= (1 << PD1);
    DDRD &= ~(1 << PD0);
    UBRR0H = (unsigned char)(MYUBRR >> 8);
    UBRR0L = (unsigned char)MYUBRR;
    UCSR0B = (1 << RXEN0) | (1 << TXEN0);
    UCSR0C = (0 << USBS0) | (3 << UCSZ00);
  }

  void writeByte(const char& d) {
    while (!(UCSR0A & (1 << UDRE0)));
    UDR0 = d;
  }

  char readByte() {
    while (!(UCSR0A & (1 << RXC0)));
    return UDR0;
  }

  void writeString(const char* msg) {
    for (int i = 0; i < strlen(msg); i++)
      writeByte(msg[i]);
  }
};

UART uart; // Instanță a clasei UART

char ADXL_cmdBuilder(char addr, bool rw, bool mb = false) {
  return (addr & 0b00111111) | (mb << 6) | (rw << 7);
}

class I2cMaster {
protected:
  void _writeByte(char data) {
    // TODO: 2. send 1 byte on i2c
    // writa byte
    // send command to send byte
    // wait for ack or nack

    TWDR = data;                          // Load data into TWDR register
    TWCR = (1 << TWINT) | (1 << TWEN);    // Start transmission
    while (!(TWCR & (1 << TWINT)));       // Wait for transmission complete
  }

  void _readByte(char& data) {
    // TODO: 2. read 1 byte from i2c
    // send command to read byte
    // wait for ack or nack
    // read byte;

    TWDR = data;
    TWCR = (1<<TWINT) | (1<<TWEN);
    while (!(TWCR & (1 << TWINT)));       // Wait for data received
    data = TWDR;                          // Read received data
  }

public:
  void init() {
    // TODO: 1. configure SPI for master mode4
    // set frequency; read datasheet for SCLK frequency
    // set SCLK pin output
    // enable internal pull up rezistor for SCLK and SDA, set PORTxn = 1
    
    TWBR = 12; // Set I2C clock rate
    TWSR = 0x00;
    TWCR = (1 << TWEN); // Enable I2C
    PORTC |= (1 << PC4) | (1 << PC5); // Enable pull-up resistors
    DDRC &= ~((1<<PC4)|(1<<PC5));//Set PC4 and PC5 as input.
  }

  void sendStart() {
    // TODO: 2. send i2c start condition
    // send start condition
    // wait for start has been transmitted

    TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN); // 1. Send START condition
    while (!(TWCR & (1 << TWINT))); // 2. Wait for TWINT flag set
    if ((TWSR & 0xF8) != 0x08) { // 3. Check TWI status (START condition transmitted)
        // ERROR(); // Handle error if needed
    }
  }

  // write addr and write mode
  bool writeAddrW(char addr) {
    // TODO: 2. send slave addr for write
    // add write bit to addr {addr[6:0],r/w}
    return writeByte((addr << 1) | 0); // r/w bit = 0
  }

  // write addr and read mode
  bool writeAddrR(char addr) {
    // TODO: 2. send slave addr for read
    // add read bit to addr {addr[6:0],r/w}
    return writeByte((addr << 1) | 1); // r/w bit = 1
  }

  bool writeByte(char d) {
    // TODO: 2. send byte on i2c
    // send byte
    _writeByte(d);
    // return if ack received
    return (TWSR & 0xF8) == 0x28; // 0x28 = Data byte transmitted, ACK received
  }

  bool readByte(char& d) {
    // TODO: 2. read byte from i2c
    _readByte(d);
    // return if ack received
    return (TWSR & 0xF8) == 0x50; // 0x50 = Data received + ACK
  }

  void sendStop() {
    // TODO: 2. send i2c stop condition
    TWCR = (1 << TWINT) | (1 << TWSTO) | (1 << TWEN); // 7. Transmit STOP condition
  }
};


I2cMaster wire;

void setup() {
  wire.init();

  delay(100);

  // TODO: 2. read ADXL DEVICE ID
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(0x00);
  wire.sendStart();
  wire.writeAddrR(ADX345_I2C_ADDR);
  char id;
  wire.readByte(id);
  wire.sendStop();

  delay(100);

  // TODO: 3. enable ADXL read
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(0x2D);
  wire.writeByte(0x08);
  wire.sendStop();

  delay(100);
}


void ADXL_readData() {
  char x, y, z;

  // TODO: 3. read X, Y, Z from ADXL and send to PC
  wire.sendStart();
  wire.writeAddrW(ADX345_I2C_ADDR);
  wire.writeByte(0x32);  // X_LSB
  wire.sendStart();
  wire.writeAddrR(ADX345_I2C_ADDR);
  wire.readByte(x);  
  wire.readByte(y);  
  wire.readByte(z);  
  wire.sendStop();

}

void loop() {
  ADXL_readData();
  delay(500);  
}
