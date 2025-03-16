// Obiective:
// 1. configurare UART
// 2. scrierea pe UART
// 3. citirea pe UART
// 4. protocol text

// Componente
// 2 LED-uri + rezistente de ??? Ohmi (se va calcula)
// 1 Push Button + rezistenta de ??? Ohmi (se va argumenta)

#define FOSC 16e6 // 16MHz
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1
// save for other labs


class UART {
 public: 
  void init() {

    // TODO: 1. configure UART
    // set UART pin directions
    // set baud rate 9600
    // enable RX and TX
    // set frame format: 8 bits, 1 stop bit, no parity
    // DO NOT CHAMGE ALL THE BITS
    DDRD |= (1 << PD1);
    DDRD &= ~(1 << PD0);
    uint16_t ubrr = MYUBRR;
    UBRR0H = (unsigned char)(ubrr>>8);
    UBRR0L = (unsigned char)ubrr;
    UCSR0B = (1<<RXEN0)|(1<<TXEN0);
    UCSR0C = (1<<USBS0)|(3<<UCSZ00);
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
        return UDR0;
  }

  void writeString(const char* msg) {

    for (int i = 0; i < strlen(msg); i++)
      writeByte(msg[i]);
  }

    void readString(char* buffer, int maxLength) {
    int i = 0;
    char received;
    do {
      received = readByte(); // Read each character
      if (received != '\n' && i < maxLength - 1) { // Stop at newline
        buffer[i++] = received;
      }
    } while (received != '\n' && i < maxLength - 1);
    
    buffer[i] = '\0'; // Null-terminate the string
  }
};



UART uart;

void setup() {
  uart.init();
}

void responseBack(const char* userMsg) {
  uart.writeString("You said: ");
  uart.writeString(userMsg);
  uart.writeString("\n");
}

void loop() 
{
  // TODO: 3. buffer bytes from user and when reach newline(\n) send the buffer back - use responseBack(...)
  // TODO: 4. implementa text protocol, minimal turn leds on/off, read btn state
    char inputBuffer[50]; // Adjust size as needed
  uart.readString(inputBuffer, sizeof(inputBuffer)); // Read input
  responseBack(inputBuffer); // Send response
}
