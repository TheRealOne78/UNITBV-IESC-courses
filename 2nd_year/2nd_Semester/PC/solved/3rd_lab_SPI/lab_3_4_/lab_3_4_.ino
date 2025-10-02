// Simple hardware serial passthrough for Nano
// Forwards USB Serial <-> Hardware UART (D0=RX, D1=TX)

void setup() {
  Serial.begin(115200); // USB to PC
  Serial.setTimeout(1);
}

void loop() {
  // Forward data in both directions
  if (Serial.available()) {
    char c = Serial.read();
    Serial.write(c); // echo back to PC (optional)
    Serial.write(c); // forward to STM32
  }
}
