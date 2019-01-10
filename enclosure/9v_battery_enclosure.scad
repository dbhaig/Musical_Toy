/* 9v_battery_enclosure.scad
 *
 *    OpenSCAD script to generate a  3D model for a 9V battery enclosure with switch
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
$fn = 50;

module 9V_enclosure() {

    l = 68.5;   // length of enclosure
    w = 33.4;   // width of enclosure
    h = 21.5;   // height of enclosure
    s_h = 1.6;  // height on/off switch above enclosure
    r = 2;      // corner radius


    color("grey")
    minkowski () {
        cube([h-2*r, w-2*r, l/2], center=true);
        cylinder(r=r, h=l/2);
    }

    color("red") translate([-0.6, 13, 51]) cylinder(r=0.6);
    color("black") translate([0.6, 13, 51]) cylinder(r=0.6);

    color("silver") translate([-h/2, -7, 43])  cube([s_h, 8, 3], center=true);

}

//9V_enclosure();
