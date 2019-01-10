/* dfplayer_mini_pcb.scad
 *
 *    OpenSCAD script to generate a  3D model for the DFPlayer-Mini Module 
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
$fn = 50;
use<straight_header.scad>

module dfplayer_pcb() {

    pcb_l = 20.5;
    pcb_w = 20.5;
    pcb_h = 1.0;

    l_r = 1.45;  // Radius of large mounting holes
    tol = 0;

    size = 1;
    font = "Liberation Sans";
    letter_height = 1;

    module substrate () {
        difference() {
            color("darkgreen") cube([pcb_l, pcb_w, pcb_h], center=true);
            translate([-pcb_l/2, 0, -1]) cylinder(r=1, h=2);
        }
    }


    module pcb_name() {
        color("white") 
        translate([-7, 0, -0.5])
        rotate([0, 0, 90])
        linear_extrude(letter_height)
        text("DFPlayer Mini", size = size, font = font, halign = "center", valign = "center");
    }


    module header_holes() {

        d_e = 0.4;   // Distance of mounting holes from the edge
        h_r = 0.35;     // Radius of header holes

        for(x  = [0 : 7]) {
        translate([-pcb_l/2 + d_e + h_r + x*2.7, -pcb_w/2 + d_e + h_r, 0]) cylinder(r=h_r, h = 1.1*pcb_h, center = true);
        }
    }

    module headers() {
        translate([-pcb_l/2 + 2.54/2, pcb_w/2 - 2.54/2, -9.0])
        straight_header(8, 1);
        translate([-pcb_l/2 + 2.54/2, -pcb_w/2 + 2.54/2, -9.0])
        straight_header(8, 1);
    }

    module socket() {
        translate([-3.1, -pcb_l/2+3.1, pcb_h/2]) color("silver") cube([14.1, 14.7, 2.0]);
    }

    translate([0, 0, pcb_h/2]) {
        socket();
        substrate();
        headers();
        pcb_name();
    }
}

module  dfplayer_clip () {

    l = 20.5;
    w = 13;
    h = 2.4;

        translate([0, 0,  3.5]) cube([l, w, h], center=true);
        translate([0, 0, -3.5]) cube([l, w, h], center=true);
        translate([-l/2-h/2+0.65, 0, 0]) cube([2.4, w, 2.4+7], center=true);
}

//dfplayer_clip();
//dfplayer_pcb(); 
