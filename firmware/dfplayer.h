/* dfplayer.h
 *
 *     class to control dfplayer mini
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */

#ifndef DFPLAYER_H
#define DFPLAYER_H

#include "SoftwareSerial.h"
#include "DFRobotDFPlayerMini.h"

#define volumeAddress      0x00
#define trackCountAddress  0x00     // Double Word

class DfPlayer : public DFRobotDFPlayerMini
{
    private:

    public:
        DfPlayer();
};
#endif
