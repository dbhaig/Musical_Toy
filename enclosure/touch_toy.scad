/* touch_toy_enclosure.scad
 *
 *    OpenSCAD script to generate an enclosure for touch toy
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
$fn = 50;

include <helix.scad>
include <speaker.scad>
include <arduino_nano_pcb.scad>
include <dfplayer_pcb.scad>
include <9v_battery_enclosure.scad>

i_r = 44/2;
o_r = 45/2+2;

h = 108;


module bottom_bevel() {
    translate([0, 0, 5-0.01]) cylinder(r1=i_r+1, r2=(i_r+1)/1.1, h = 5);
    translate([0, 0, -0.01]) cylinder(r=i_r+1, h = 5);
}

module top_bevel() {
     translate([0, 0, h+0.01]) rotate([0, 180, 0]) bottom_bevel();
}

module spiral_shell(){

    module speaker_holes() {
      sp_h = 0;
      x = 8;
      y = 8;
      r = 2;
      h = 6;

      translate([-x+x/2, y, sp_h]) cylinder(r=r, h = h);
      translate([0+x/2, y, sp_h]) cylinder(r=r, h = h);
      translate([-x+x/2, -y, sp_h]) cylinder(r=r, h = h);
      translate([0+x/2, -y, sp_h]) cylinder(r=r, h = h);
      translate([-x, 0, sp_h]) cylinder(r=r, h = h);
      translate([0, 0, sp_h]) cylinder(r=r, h = h);
      translate([x, 0, sp_h]) cylinder(r=r, h = h);

    }

    difference() {

        minkowski() {
            cylinder(r=o_r-2, h = h);
            sphere(r=2);
        }
      translate([0, 0, -5]) helix(radius = i_r +1 , wire_r = 0.8, pitch = 25, coils = 4.75, step = 5);
      translate([0, 0, 0]) cylinder(r=i_r, h = h);
      translate([0, 0, h-3]) speaker_holes(); 

      translate([0, 0, -3]) cylinder(r=i_r+1, h = 4);
      translate([0, 0, 0.9]) cylinder(r1=i_r+2, r2=(i_r+1)/2, h = 10);

    }
}

module cap() {

      h = 10;

    difference() {
        minkowski() {
            cylinder(r=o_r, h = h);
            sphere(r=2);
        }
      translate([0, 0, 0]) cylinder(r=o_r, h = 1.5*h);
    }
}
module 9V_surround() {
    
    module surround() {
        difference() {
            minkowski() {
                cube([21, 33, 2], center=true);
                cylinder(r= 2, h = 2, center=true);
            }
            translate([2, 0, -1]) 
            9V_enclosure();

        }
    }

    module 9v_end() {
        difference() {
            minkowski() {
                cube([21, 33, 2], center=true);
                cylinder(r= 2, h = 2, center=true);
            }
            translate([2, 0, -70]) 
            9V_enclosure();
            // wire feed thru hole
            translate([0, -13, -3]) cylinder(r=2, h=6);
        }
    }

   module prism(){                                                                                                                                
         p_l = 4;                                                                                                                                  
         p_w = 3;                                                                                                                                  
         p_h = 5;                                                                                                                                  
         polyhedron(                                                                                                                               
                 points=[[0,0,0], [p_l,0,0], [p_l,p_w,0], [0,p_w,0], [0,p_w,p_h], [p_l,p_w,p_h]],                                                  
                 faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]                                                                             
         );                                                                                                                                        
   }       

   module stops () {
        translate([5.3, -20, 1.5]) rotate([0, 90, 0]) prism();
        translate([-5.3, -20, -2.5]) rotate([0, -90, 0]) prism();
        translate([5.3, 20, -2.5]) rotate([180, -90, 0]) prism();
        translate([-5.3, 20, 1.5]) rotate([180, 90, 0]) prism();
   }
    surround();
    translate([0, 0, 52]) 9v_end();
    translate([0, 0, 58]) dfplayer_clip();
    translate([0, 0, 52.5]) stops();
    translate([0, 0, 0.5]) stops();
    translate([-0.1, 0, 0]) nano_clip_capture();

}

module nano_clip_capture () {
    module side() cube([3.6, 5, 56]);
    difference() {
        union() {
            translate([-12.4, -18.5, -2]) side();
            translate([-12.4, 18.5-5, -2]) side();
        }
        translate([-12.7, 0, 26]) 
        rotate([0, 90, 180]) arduino_nano_clip_footprint();
    }
}

module frame() {
    9V_surround();
    translate([0, 0, 76]) speaker_clip();

    color("blue") translate([-12, 0, 26]) rotate([0, 90, 180]) arduino_nano_clip();

    translate([2, 0, -2])rotate([0, 0, 180]) 9V_enclosure();

    translate([1, 0, 59.5]) rotate([0, 180, 180]) dfplayer_pcb();


    translate([-12.6, 0, 28]) rotate([0, 90, 180]) arduino_nano_pcb();

    translate([0, 0, 75.3]) speaker();

}

//frame();

difference() {
    union() {
    translate([0, 0, -17.7]) spiral_shell();
//    translate([0, 0, -20]) cap();
    }

//    translate([0, 0, -40]) cube([50, 50, 150]);
//    translate([0, 0, -25]) cube([100, 100, 20], center=true);

//    translate([0, 0, 6]) rotate_extrude(convexity = 10) translate([26, 0, 0]) circle(r = 2);
//    translate([-100, -100, 0]) cube([100, 100, 10]);
//    translate([0, 0, 0]) cube([100, 100, 10]);
}
