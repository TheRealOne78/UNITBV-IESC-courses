  // Obiective:
// 1. prezentat documentatie ATmega328P
// 2. configurarea pinilor pentru citire/scriere
// 3. scrierea/citirea pe pini
// 4. intorducere in utilizarea aparaturii de laborator
//  4.1. prezentare + utilizarea multimetru (masurare R, Vd)
//  4.2. prezentare + vizaulizarea unui semnal periodic pe osciloscop
//  4.3. prezentare + utilizare sursa de tensiune

// Componente
// 2 LED-uri + rezistente de ??? Ohmi (se va calcula)
// 1 Push Button + rezistenta de ??? Ohmi (se va argumenta)

// TODO: 4. use power supply for Arduino

#define LED_0_PIN 2
#define LED_1_PIN 3
#define BUTTON_PIN 4
int cnt;
void setup() {
  // TODO: 1. configure pin directions and turn off leds
  DDRD = DDRD | B00001100;
  PORTD = B00001100;
}

void inline setLed0State(bool state) {
  // TODO: 1. turn led0 on or off based on state
  if( state )
    PORTD |= (1 << LED_0_PIN);
  else
    PORTD &= ~(1<< LED_0_PIN);
}

// read button state
bool inline readBtnState() {
  // TODO: 1. return if button is pressed
  if (!(PIND & (1 << BUTTON_PIN))) {
    return true;
  }
  return false;
}

void inline setLed1State(bool state) {
  // TODO: 2. turn led1 on or off based on state
  if( state )
    PORTD |= (1<< LED_1_PIN);
  else
    PORTD &= ~(1<< LED_1_PIN);
}

static void oscilatingLed() {
  // TODO: 2. toggle the led1 with the pattern: 500ms on, 200ms off
  // TODO: 3. analyse on osciliscop the  led1 signal and measure the timing

  cnt++;
  if(cnt <= 5)
    PORTD |= (1<< LED_1_PIN);
  else if(cnt < 7)
    PORTD &= ~(1<< LED_1_PIN);
  else
    cnt=0;
}

// detect button press and toggle the led0 state
static void toggleLed(bool btnState) {
  static bool lastState = 0;
  static bool ledState  = false;
  if ( !lastState & btnState ) {
    ledState = !ledState;
    setLed0State(ledState);
  }
  lastState = btnState;
}

void loop() {
  toggleLed(readBtnState());
  oscilatingLed();
  delay(100);
}
