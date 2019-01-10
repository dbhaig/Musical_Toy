/* musical_touch_toy.ino
 *
 *    Firmware for musical touch toy
 *
 *    Copyright 2019 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
#include "dfplayer.h"
#include <ADCTouch.h>

DfPlayer dfplayer;

SoftwareSerial player_uart(3, 4); // rx, tx

bool player_busy();
bool touch();

int touch_ambient;

void setup() {
    touch_ambient = 572;    // Adjust this value to alter sensitivity to touch

    pinMode(A7, INPUT);       // Connected to dfplayer BUSY pin

    player_uart.begin(9600); 

    if (!dfplayer.begin(player_uart, false)) 
       Serial.println("Ignoring dfplayer.begin() error");

       Serial.begin(115200);
       Serial.println(ADCTouch.read(A0, 500),DEC);

    dfplayer.volume(30);   // Can be set from 0 to 30
}


void loop() {
    if (!player_busy() && touch()) dfplayer.next();
    if (player_busy() && !touch()) dfplayer.stop();

    Serial.println(ADCTouch.read(A0, 500),DEC);
}

bool player_busy() {
    if (analogRead(A7) < 500) return true;
    return false;
}

#define touchThreshold 6 

bool touch() {
    if ((ADCTouch.read(A0) - touch_ambient) > touchThreshold) return true; 
    return false;

}
