#include "LedControl.h"

LedControl lc=LedControl(11,13,8,1);

unsigned char LabVIEW, command;

void setup() {
  // put your setup code here, to run once:

  lc.shutdown(0,false);

  lc.setIntensity(0,8);

  lc.clearDisplay(0);
  
  Serial.begin(9600);
  
}

void PrimulCadru (){
  //digitalWrite(led,HIGH);

  byte c8[8]={0x1C,0x3E,0x7E,0xFC,0xFC,0x7E,0x3E,0x1C};

  //byte c8[8]={0x7E,0x81,0x81,0x7E,0xFE,0x11,0x11,0xFE};

  lc.setRow(0,0,c8[0]);
  lc.setRow(0,1,c8[1]);
  lc.setRow(0,2,c8[2]);
  lc.setRow(0,3,c8[3]);
  lc.setRow(0,4,c8[4]);
  lc.setRow(0,5,c8[5]);
  lc.setRow(0,6,c8[6]);
  lc.setRow(0,7,c8[7]);
    
  }

void AlDoileaCadru (){
  //digitalWrite(led,LOW);

  byte a3[8]={0x3C,0xC2,0xA5,0x91,0x91,0xA5,0xC2,0x3C};

  lc.setRow(0,0,a3[0]);
  lc.setRow(0,1,a3[1]);
  lc.setRow(0,2,a3[2]);
  lc.setRow(0,3,a3[3]);
  lc.setRow(0,4,a3[4]);
  lc.setRow(0,5,a3[5]);
  lc.setRow(0,6,a3[6]);
  lc.setRow(0,7,a3[7]);
  
  }

void AlTreileaCadru (){
  //digitalWrite(led,LOW);

  byte d3[8]={0x18,0x18,0x18,0xFF,0xFF,0x18,0x18,0x18};

  lc.setRow(0,0,d3[0]);
  lc.setRow(0,1,d3[1]);
  lc.setRow(0,2,d3[2]);
  lc.setRow(0,3,d3[3]);
  lc.setRow(0,4,d3[4]);
  lc.setRow(0,5,d3[5]);
  lc.setRow(0,6,d3[6]);
  lc.setRow(0,7,d3[7]);
  
  }

void AlPatruleaCadru (){
  //digitalWrite(led,LOW);

  byte e3[8]={0x0C,0x1C,0x34,0x64,0xFF,0xFF,0x0C,0x0C};

  lc.setRow(0,0,e3[0]);
  lc.setRow(0,1,e3[1]);
  lc.setRow(0,2,e3[2]);
  lc.setRow(0,3,e3[3]);
  lc.setRow(0,4,e3[4]);
  lc.setRow(0,5,e3[5]);
  lc.setRow(0,6,e3[6]);
  lc.setRow(0,7,e3[7]);
  
  }  
  

void loop() {
  
  while(1){
    if(Serial.available()){
      LabVIEW=Serial.read();
      Serial.write(LabVIEW);
      command = LabVIEW;
    }
  

    switch(command){
      case '1':
          PrimulCadru();
          break;
      case '2':
          AlDoileaCadru();
          break;
      case '3':
          AlTreileaCadru();
          break;
      case '4':
          AlPatruleaCadru();
          break;
    }  
  }
}
