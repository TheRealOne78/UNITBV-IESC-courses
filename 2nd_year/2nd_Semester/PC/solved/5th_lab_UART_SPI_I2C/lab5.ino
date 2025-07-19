// Obiective:
// 1. folosirea avantajelor oferite de stiva OSI
// 2. realizarea unei clase independenta de protocol (I2C/SPI)


#define FOSC 16e6 // 16MHz
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1


// Componente
// Senzor acelerometru ADXL345

// TODO: 1. bring classes SpiMaster and I2cMaster from previous laboratories

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



class IAdxlTransport {
    // this interface provide basic transport function for ADXL
  public:
    // initialize the hardware peripheral
    virtual void init() = 0;
    // read *len* bytes start with *addr*
    virtual bool read(int addr, char* d, int len = 1);
    // write *len* bytes start with *addr*
    virtual bool write(int addr, const char* d, int len = 1);
};

//I2CMaster class
class I2cMaster {
  protected:
    void _writeByte(char data) {
      TWDR = data;
      TWCR = (1 << TWINT) | (1 << TWEN);
      while (!(TWCR & (1 << TWINT)));
    }

    void _readByte(char& data, bool ack = true) {
      if (ack)
        TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWEA); // cu ACK
      else
        TWCR = (1 << TWINT) | (1 << TWEN); // fără ACK

      while (!(TWCR & (1 << TWINT)));
      data = TWDR;
    }

  public:
    void init() {
      // Activăm pull-up pe SDA (PC4) și SCL (PC5)
      DDRC &= ~((1 << PC4) | (1 << PC5)); // intrare
      PORTC |= (1 << PC4) | (1 << PC5);   // pull-up

      TWSR = 0x00; // prescaler = 1
      TWBR = 72;   // pentru SCL ≈ 100kHz la 16MHz
      TWCR = (1 << TWEN); // Enable TWI
    }

    static void sendStart() {
      TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN);
      while (!(TWCR & (1 << TWINT)));
    }

    bool writeAddrW(char addr) {
      _writeByte((addr << 1) | 0); // bit R/W = 0
      return ((TWSR & 0xF8) == 0x18); // SLA+W, ACK
    }

    bool writeAddrR(char addr) {
      _writeByte((addr << 1) | 1); // bit R/W = 1
      return ((TWSR & 0xF8) == 0x40); // SLA+R, ACK
    }

    bool writeByte(char d) {
      _writeByte(d);
      return ((TWSR & 0xF8) == 0x28); // DATA, ACK
    }

    bool readByte(char& d) {
      _readByte(d, false); // fără ACK la ultimul byte
      return true;
    }

    void sendStop() {
      TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWSTO);
      while (TWCR & (1 << TWSTO)); // așteptăm STOP
    }
};


// SpiMaster class
class SpiMaster {
  public:
    void init() {
      // TODO: 1. configure SPI
      // set MOSI, SCK - output

      DDRB |= (1 << PB3) | (1 << PB5);
      // set MISO - input
      DDRB &= ~(1 << PB4);
      // enable SPI as master

      // check ADXL datasheet for clock frequncy
      // check ADXL datasheet for clock polarity
      // check ADXL datasheet for clock phase
      SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0) | (1 << CPOL) | (1 << CPHA);
    }

    char transmit(char d) {
      // TODO: 2. transmit 1 byte on SPI
      // start transmision
      SPDR = d;
      // wait for transmission complete
      // return response from slave
      while (!(SPSR & (1 << SPIF)));
      return SPDR;


      return 0x00;
    }
};


// TODO: 2. based on the following interface implement two other classes
// - one I2cTransport for I2C protocol
class I2cTransport : public IAdxlTransport {
    const char deviceAddr = 0x53; // adresa ADXL345
  private: I2cMaster i2c_master;
  public:
    void init() override {
      i2c_master.init();
    }

    bool read(int addr, char* d, int len = 1) override {
      i2c_master.sendStart();
      if (!i2c_master.writeAddrW(deviceAddr)) return false;
      if (!i2c_master.writeByte(addr)) return false;
      i2c_master.sendStart();
      if (!i2c_master.writeAddrR(deviceAddr)) return false;

      for (int i = 0; i < len; ++i) {
        if (!i2c_master.readByte(d[i])) return false;
      }

      i2c_master.sendStop();
      return true;
    }

    bool write(int addr, const char* d, int len = 1) override {
      i2c_master.sendStart();
      if (!i2c_master.writeAddrW(deviceAddr)) return false;
      if (!i2c_master.writeByte(addr)) return false;
      for (int i = 0; i < len; ++i) {
        if (!i2c_master.writeByte(d[i])) return false;
      }
      i2c_master.sendStop();
      return true;
    }
};

// - one SpiTransport for SPI protocol
class SpiTransport : public IAdxlTransport {
  private: SpiMaster spi_master;
  public:
    void init() override {
      spi_master.init();
      // chip select pin as output, set high
      DDRB |= (1 << PB1);
      PORTB |= (1 << PB1);
    }

    bool read(int addr, char* d, int len = 1) override {
      PORTB &= ~(1 << PB2); // CS low
      spi_master.transmit(0x80 | (len > 1 ? 0x40 : 0x00) | addr);
      for (int i = 0; i < len; ++i)
        d[i] = spi_master.transmit(0x00);
      PORTB |= (1 << PB2);  // CS high
      return true;
    }

    bool write(int addr, const char* d, int len = 1) override {
      PORTB &= ~(1 << PB2); // CS low
      spi_master.transmit(addr & 0x3F);
      for (int i = 0; i < len; ++i)
        spi_master.transmit(d[i]);
      PORTB |= (1 << PB2);  // CS high
      return true;
    }
};

// TODO: 3. implement this high level class
// * will get an IAdxlTransport* in constructor
// need to provide the fallowing functions:
//  - check if sensor is connected by read and check device id
//  - start/stop measurement
//  - read data from sensor, not return them
//  - get the values for every axis from independent functions
//  - two consecutive read from same axis will automaticaly will update values the second time
class Adxl {
    IAdxlTransport* transport;
    int16_t x, y, z;
    bool updated = false;

  public:
    Adxl(IAdxlTransport* t) : transport(t) {}

    void init() {
      transport->init();
      startMeasurement();
    }

    bool isConnected() {
      char id = 0;
      return transport->read(0x00, &id) && id == 0xE5;
    }

    void startMeasurement() {
      char val = 0x08;
      transport->write(0x2D, &val);
    }

    void stopMeasurement() {
      char val = 0x00;
      transport->write(0x2D, &val);
    }

    void updateData() {
      char buf[6];
      if (transport->read(0x32, buf, 6)) {
        x = (buf[1] << 8) | buf[0];
        y = (buf[3] << 8) | buf[2];
        z = (buf[5] << 8) | buf[4];
        updated = true;
      }
    }

    int getX() {
      if (!updated) updateData();
      updated = false;
      return x;
    }

    int getY() {
      if (!updated) updateData();
      updated = false;
      return y;
    }

    int getZ() {
      if (!updated) updateData();
      updated = false;
      return z;
    }
};

// TODO: 4. TEST IT!

// instantiation example:
// Adxl adxl(new SpiTransport);
//pentru SPI
SpiTransport spi;
Adxl adxl_1(&spi);

//pentru I2C
//I2cTransport i2c;
//Adxl adxl_2(&i2c);

UART uart;

void setup() {

  uart.init();
  adxl_1.init();
  //adxl_2.init();

}

void loop() {

  char adxl_array_1_x[64], adxl_array_1_y[64], adxl_array_1_z[64];
  char adxl_array_2_x[64], adxl_array_2_y[64], adxl_array_2_z[64];

  int adxl_1_x, adxl_1_y, adxl_1_z;
  //int adxl_2_x, adxl_2_y, adxl_2_z;



  while (true)
  {
    //SPI
    adxl_1_x = adxl_1.getX();
    adxl_1_y = adxl_1.getY();
    adxl_1_z = adxl_1.getZ();
    //I2C
//    adxl_2_x = adxl_2.getX();
//    adxl_2_y = adxl_2.getY();
//    adxl_2_z = adxl_2.getZ();

    //uart.writeString("Hello\n");
    uart.writeString("\n\n x: "); uart.writeString(itoa(adxl_1_x, adxl_array_1_x, 10 ));
    uart.writeString("\n y: "); uart.writeString(itoa(adxl_1_y, adxl_array_1_y, 10 ));
    uart.writeString("\n z: "); uart.writeString(itoa(adxl_1_z, adxl_array_1_z, 10 ));

//    uart.writeString(itoa(adxl_2_x, adxl_array_2_x, 10 ));
//    uart.writeString(itoa(adxl_2_y, adxl_array_2_y, 10 ));
//    uart.writeString(itoa(adxl_2_z, adxl_array_2_z, 10 ));
  }
}
