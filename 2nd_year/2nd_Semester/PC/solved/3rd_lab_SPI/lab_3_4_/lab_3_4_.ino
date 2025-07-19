#include <avr/io.h>
#include <util/delay.h>
#include <string.h> // Include string.h pentru strlen

#ifndef F_CPU
#define F_CPU 16000000UL // Frecvența procesorului (16 MHz)
#endif
#define BAUD 9600
#define MYUBRR F_CPU / 16 / BAUD - 1

//class UART {
//public:
//  void init() {
//    DDRD |= (1 << PD1);
//    DDRD &= ~(1 << PD0);
//    UBRR0H = (unsigned char)(MYUBRR >> 8);
//    UBRR0L = (unsigned char)MYUBRR;
//    UCSR0B = (1 << RXEN0) | (1 << TXEN0);
//    UCSR0C = (0 << USBS0) | (3 << UCSZ00);
//  }
//
//  void writeByte(const char& d) {
//    while (!(UCSR0A & (1 << UDRE0)));
//    UDR0 = d;
//  }
//
//  char readByte() {
//    while (!(UCSR0A & (1 << RXC0)));
//    return UDR0;
//  }
//
//  void writeString(const char* msg) {
//    for (int i = 0; i < strlen(msg); i++)
//      writeByte(msg[i]);
//  }
//};

class UART {
  public:
    void init() {
      int ubrr = MYUBRR;
      // TODO: 1. configure UART
      // set UART pin directions
      // set baud rate 9600
      // set frame format: 8 bits, 1 stop bit, no parity
      // DO NOT CHAMGE ALL THE BITS
      UBRR0H = (unsigned char)(ubrr >> 8);
      UBRR0L = (unsigned char)ubrr;
      UCSR0B = (1 << RXEN0) | (1 << TXEN0);
      DDRD |= 0b00000010; // iesire pt Tx 1
      DDRD &= 0b11111110; // intrare pt Rx 0
      // set frame format: 8 bits, 1 stop bit, no parity
      UCSR0C = (0 << USBS0) | (3 << UCSZ00);
    }

    bool available() {
      // TODO: 3. check if are data in UART buffer
      return (UCSR0A & (1 << RXC0));
    }

    void writeByte(const char& d) {
      // TODO: 2. implement write + test it and capture on osciloscope
      // wait to empty transmit buffer
      // write data
      while (!(UCSR0A & (1 << UDRE0)));
      UDR0 = d;
    }

    char readByte() {
      // TODO: 3. implement read
      // wait for data
      // read data and return it
      while (!(UCSR0A & (1 << RXC0)));
      /* Get and return received data from buffer */
      return UDR0;

    }

    void writeString(const char* msg) {
      for (int i = 0; i < strlen(msg); i++)
        writeByte(msg[i]);
    }
};

UART uart; // Instanță a clasei UART

void ADXL_enable() {
  // Select ADXL345 (CS LOW)
  PORTB &= ~(1 << PB0);
}

void ADXL_disable() {
  // Deselect ADXL345 (CS HIGH)
  PORTB |= (1 << PB0);
}

char ADXL_cmdBuilder(char addr, bool rw, bool mb = false) {
  return (addr & 0b00111111) | (mb << 6) | (rw << 7);
}

class SpiMaster {
public:
  void init() {
    // Set MOSI (PB3) și SCK (PB5) ca output
    DDRB |= (1 << PB3) | (1 << PB5);

    // Set MISO (PB4) ca input
    DDRB &= ~(1 << PB4);

    // Activează SPI ca Master, CPOL = 1, CPHA = 1, Clock div = fck/16
    SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0) | (1 << CPOL) | (1 << CPHA);
  }

  void transmit(char d) {
    // Așteaptă finalizarea transmisiei
    /* Start transmission */
    SPDR = d;

    /* Wait for transmission complete */
    while(!(SPSR & (1<<SPIF)));
  }

  char receive() {
    /* Wait for reception complete */
    while(!(SPSR & (1<<SPIF)));

    /* Return Data Register */
    return SPDR;
  }

};

SpiMaster spi;

void setup() {
  // Set CS (PB0) ca output
  DDRB |= (1 << PB0);

  // Inițializăm starea CS pe HIGH (deselectat)
  //ADXL_disable();
  ADXL_enable();


  // Inițializare SPI
  uart.init();
  spi.init();

  // Așteptăm puțin
  delay(500);

  // Citim ID-ul dispozitivului
  //ADXL_enable();
  spi.transmit(ADXL_cmdBuilder(0x00, true)); // Comanda de citire DEVICE_ID
  char device_id = spi.receive(); // Citim răspunsul
  //ADXL_disable();

  // Trimitem ID-ul citit prin UART (din laboratorul anterior)
  char buffer[10];
  itoa(device_id, buffer, 16); // Conversie în hex
  uart.writeString("ADXL345 ID: "); // Modificare aici
  uart.writeString(buffer); // Modificare aici
  uart.writeString("\n"); // Modificare aici

  delay(500);

  // Activăm modul de măsurare
  //ADXL_enable();
  spi.transmit(ADXL_cmdBuilder(0x2D, false)); // Adresa POWER_CTL
  spi.transmit(0x08); // Activăm modul de măsurare
  //ADXL_disable();

  delay(500);
}

void ADXL_readData() {
  char data[6];

  // Citim datele X, Y, Z din registrul 0x32 (multi-byte read)
  //ADXL_enable();
  spi.transmit(ADXL_cmdBuilder(0x32, true, true)); // MB = 1, Read = 1
  for (int i = 0; i < 6; i++) {
    data[i] = spi.receive();
  }
  //ADXL_disable();

  // Convertim datele brute în valori întregi
  int x = (data[1] << 8) | data[0];
  int y = (data[3] << 8) | data[2];
  int z = (data[5] << 8) | data[4];

  // Conversie în string și trimitere prin UART
  char buffer[10];
  itoa(x, buffer, 10);
  uart.writeString("X: "); uart.writeString(buffer); // Modificare aici
  itoa(y, buffer, 10);
  uart.writeString(" Y: "); uart.writeString(buffer); // Modificare aici
  itoa(z, buffer, 10);
  uart.writeString(" Z: "); uart.writeString(buffer); // Modificare aici
  uart.writeString("\n"); // Modificare aici
}

void loop() {
  ADXL_readData();
  delay(500);
}
