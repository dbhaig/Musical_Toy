/* arduino_nano_pcb.scad
 *
 *    OpenSCAD script to generate a  3D model for the arduino nano Module 
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
$fn = 50;
use<straight_header.scad>

module arduino_nano_pcb() {

    pcb_l = 43.1;
    pcb_w = 18.1;
    pcb_h = 1.4;

    tol = 0;

    size = 1.8;
    font = "Liberation Sans";
    letter_height = pcb_h;

    module substrate () {
        difference() {
            color("darkgreen") cube([pcb_l, pcb_w, pcb_h], center=true);
        }
    }


    module pcb_name() {
        color("white") 
        translate([-1, 0, -0.5])
        rotate([0, 0, -90])
        linear_extrude(letter_height)
        text("Nano", size = size, font = font, halign = "center", valign = "center");
    }


    module mounting_holes() {

        d_e = 0.2;   // Distance of mounting holes from the edge
        h_r = 1.0/2;   // Radius of mounting holes

        translate([pcb_l/2 - h_r - d_e, pcb_w/2 - h_r - d_e, 0]) cylinder(r=h_r, h = 1.1*pcb_h, center = true);
        translate([-pcb_l/2 + h_r + d_e, pcb_w/2 - h_r - d_e, 0]) cylinder(r=h_r, h = 1.1*pcb_h, center = true);

        translate([pcb_l/2 - h_r - d_e, -pcb_w/2 + h_r + d_e, 0]) cylinder(r=h_r, h = 1.1*pcb_h, center = true);
        translate([-pcb_l/2 + h_r + d_e, -pcb_w/2 + h_r + d_e, 0]) cylinder(r=h_r, h = 1.1*pcb_h, center = true);
    }

    module pin_header_pads() {
        translate([-pcb_l/2 + 2.54/2, pcb_w/2 - 2.54/2, 0])
        header_pads(15, 1, pcb_h);
        translate([-pcb_l/2 + 2.54/2, -pcb_w/2 + 2.54/2, 0])
        header_pads(15, 1, pcb_h);
    }

    module pin_header_holes() {
        translate([-pcb_l/2 + 2.54/2, pcb_w/2 - 2.54/2, 0])
        header_holes(15, 1, pcb_h);
        translate([-pcb_l/2 + 2.54/2, -pcb_w/2 + 2.54/2, 0])
        header_holes(15, 1, pcb_h);
    }

    module mini_usb() {

        color("silver")
        translate([pcb_l/2 - 8, 0, 1.9*pcb_h])
        rotate([90, 0, 90])
        linear_extrude(9.1)
        polygon(points=[[-7.7/2,2], [7.7/2,2], [6.5/2,-2], [-6.5/2,-2]]);
    }

    module reset_button() {
        translate([-19.75+15.1, 0, pcb_h]) 
        union () {
            color("silver")
            cube([3.6, 6, 1.9], center=true);
            color("orange")
            cube([1.1, 2.4, 2.2], center=true);
        }
    }

    translate([0, 0, pcb_h/2]) {
        difference() {
            union() {
                substrate();
                translate([2.54, 0, 0]) pin_header_pads();
            }
            mounting_holes();
            translate([2.54, 0, 0]) pin_header_holes();
        }
        mini_usb();
        reset_button();
        pcb_name();
    }
}

module  arduino_nano_clip () {

    pcb_l = 43.1;
    pcb_w = 18.1;
    pcb_h = 1.4;

    module bottom_support(){
        difference() {
        translate([0, 0, -3]) cube([pcb_l +4, , 1.6*pcb_w, 2], center=true);
        translate([0, 0, -3]) cube([pcb_l, , pcb_w, 2.1], center=true);
        }
    }

    module other_end() {
        rotate([0, 0, 180])
        difference() {
            translate([0, 0, 0]) cube([4, , 1.3*pcb_w, 7], center=true);
            translate([-2, 0, 1]) cube([4.01, , 1.05*pcb_w, 1.5*pcb_h], center=true);
        }

    }
    module usb_end() {
        difference() {
            translate([0, 0, 0]) cube([4, , 1.3*pcb_w, 7], center=true);
            translate([0, 0, 4.2]) cube([4.01, , 0.45*pcb_w, 5], center=true);
            translate([-2, 0, 2.1]) cube([4.01, , 1.05*pcb_w, 2.5*pcb_h], center=true);
            translate([-1.5, 0, 0]) cube([3.01, , 0.9*pcb_w, 3], center=true);
        }
    }

    translate([0, 0, 0]) bottom_support();
    translate([pcb_l/2, 0, 0]) usb_end();
    translate([-pcb_l/2, 0, 0]) other_end();
}

    module arduino_nano_clip_footprint() {
        translate([0, 0, -3]) cube([48.1, , 1.7*18.1, 2.4], center=true);
    }

//arduino_nano_clip();
//translate([0, 0, 0.5]) arduino_nano_pcb();
