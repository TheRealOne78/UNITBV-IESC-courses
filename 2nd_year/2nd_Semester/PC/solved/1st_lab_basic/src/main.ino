#define LED_0_PIN PD2
#define LED_1_PIN PD3
#define BUTTON_PIN PD4

uint8_t cnt;

void setup() {
  // Setam pinii LED_0 si LED_1 ca output
  DDRD |= (1 << LED_0_PIN) | (1 << LED_1_PIN);
}

void setLed0State(bool state) {
  if(state)
    PORTD |= (1 << LED_0_PIN);
  else
    PORTD &= ~(1 << LED_0_PIN);
}

void setLed1State(bool state) {
  if(state)
    PORTD |= (1 << LED_1_PIN);
  else
    PORTD &= ~(1 << LED_1_PIN);
}

bool readBtnState() {
  // if input is HIGH, return true
  if(!(PIND & (1 << BUTTON_PIN)))
    return true;
  return false;
}

void oscilatingLed() {
  // TODO: 2. toggle the led1 with the pattern: 500ms on, 200ms off
  // TODO: 3. analyse on osciliscop the  led1 signal and measure the timing

  cnt++;
  if(cnt <= 5)
    PORTD |= (1 << LED_1_PIN);
  else if(cnt < 7)
    PORTD &= ~(1 << LED_1_PIN);
  else
    cnt = 0;
}

void toggleLed(bool btnState) {
  static bool lastState = false;
  static bool ledState  = false;
  if(!lastState & btnState) {
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
