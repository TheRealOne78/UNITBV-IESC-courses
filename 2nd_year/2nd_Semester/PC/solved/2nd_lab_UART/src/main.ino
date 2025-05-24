#include <avr/io.h>
#include <string.h>

#define FOSC 16e6 // 16MHz
#define BAUD 9600 // Baud rate
#define MYUBRR FOSC/16/BAUD-1 // math equation

#define LED_0_PIN PD2
#define LED_1_PIN PD3
#define BUTTON_PIN PD4

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
        for (uint8_t i = 0; i < strlen(msg); i++)
            writeByte(msg[i]);
    }
};

UART uart;
char inputBuffer[50];
int  bufferIndex;
char receivedChar;


void responseBack(const char* userMsg) {
    uart.writeString("You said: ");
    uart.writeString(userMsg);
    uart.writeByte('\n');
}

void setup() {
    uart.init();
    DDRD |= (1 << LED_0_PIN) | (1 << LED_1_PIN); // LED1, LED2 as output
    DDRD &= ~(1 << BUTTON_PIN); // Button as input

    // init vars
    bufferIndex  = 0;
    receivedChar = '\0';
}

void loop() {
    // TODO: 3. buffer bytes from user and when reach newline(\n) send the buffer back - use responseBack(...)
    // TODO: 4. implementa text protocol, minimal turn leds on/off, read btn state

    receivedChar = uart.readByte();

    if (receivedChar == '\n' || bufferIndex >= 49) {
        inputBuffer[bufferIndex] = '\0';
        if (strcmp(inputBuffer, "0on") == 0) {
            PORTD |= (1 << LED_0_PIN);
            uart.writeString("LED 0 ON\n");
        }
        else if (strcmp(inputBuffer, "0off") == 0) {
            PORTD &= ~(1 << LED_0_PIN);
            uart.writeString("LED 0 OFF\n");
        }
        else if (strcmp(inputBuffer, "1on") == 0) {
            PORTD |= (1 << LED_1_PIN);
            uart.writeString("LED 1 ON\n");
        }
        else if (strcmp(inputBuffer, "1off") == 0) {
            PORTD &= ~(1 << LED_1_PIN);
            uart.writeString("LED 1 OFF\n");
        }
        else if (strcmp(inputBuffer, "btn") == 0) {
            if (PIND & (1 << BUTTON_PIN))
                uart.writeString("Button pressed\n");
            else
                uart.writeString("Button not pressed\n");
        }
        else
            responseBack(inputBuffer);
        bufferIndex = 0;
    }
    else
        inputBuffer[bufferIndex++] = receivedChar;
}
