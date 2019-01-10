/* speaker.scad
 *
 *    OpenSCAD script to generate a  3D model for the speaker
 *
 *    Copyright 2018 Don Haig (time4tux at gmail dot com)
 *
 *    GNU GPLv3 (See LICENSE for details) 
 *
 */
$fn = 50;

module speaker() {

    r = 30/2;   // speaker radius
    h = 13;     // speaker height
    h_r = 1.4;  // speaker hole radius


    module holes() {

    h_r = 1.4;   // hole radius
    h_s = 4;     // hole separation

        module hole_row(n, h_s) {
            for (x = [0:1:n-1]) {
            translate([r-(h_s*x+(n-1)*h_r), 0, 0]) cylinder(r=h_r, h = h/2);
            }
        }

        translate([0, 2.3*h_s, 0]) hole_row(1); 
        translate([-2.2*h_s, 2*h_s, 0]) hole_row(2, 2*4.5); 
        translate([-h_s, h_s, 0]) hole_row(4, 4.5); 
        hole_row(5, 4.5); 
        translate([-h_s, -h_s, 0]) hole_row(4, 4.5); 
        translate([-2.2*h_s, -2*h_s, 0]) hole_row(2, 2*4.5); 
        translate([0, -2.3*h_s, 0]) hole_row(1); 
    }

    module pins() {
        p_r = 0.8/2;    // pin radius
        p_l = 7.2;      // pin length

        translate([-(7+p_r), 0, -p_l]) cylinder(r=p_r, h=p_l);
        translate([+(7+p_r), 0, -p_l]) cylinder(r=p_r, h=p_l);
    }


    difference() {
        color("black") cylinder(r=r, h=h);
        color("white") translate([0, 0, 0.6*h]) holes();
    }
    color("silver") pins();
}

module speaker_clip() {
    o_r = 20;   // speaker clip outer radius
    i_r = 30/2;   // speaker clip inner radius
    h = 14;       // speaker clip height
    s_l = 3;        // support length
    s_w = 10;        // support width
    s_h = 94;       // support height

   module prism(){
        p_l = 6;
        p_w = 4;
        p_h = 5;
        polyhedron(
                points=[[0,0,0], [p_l,0,0], [p_l,p_w,0], [0,p_w,0], [0,p_w,p_h], [p_l,p_w,p_h]],
                faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
        );
    }

    difference() { 
        translate([0, 0, 0,]) cylinder(r=o_r, h=h);
        translate([0, 0, -1.2,]) cylinder(r=i_r, h=h);
        translate([0, 0, 12,]) cylinder(r=i_r-2, h=3);
    }

    // side supports
    translate([-s_w/2, o_r-1.5, -s_h+h]) cube([s_w, s_l, s_h]);
    translate([-s_w/2, -o_r-1.5, -s_h+h]) cube([s_w, s_l, s_h]);

    // nubs
    n_r = 1.6;        // nub radius
    n_h = 6;        // nub height
    translate([-n_h/2, i_r+n_r+2, -28]) rotate([0, 90, 0]) cylinder(r=n_r, h=n_h);
    translate([-n_h/2, -i_r-n_r-2, -28]) rotate([0, 90, 0]) cylinder(r=n_r, h=n_h);
    
    translate([-n_h/2, i_r+n_r+3.2, -80]) rotate([0, 90, 0]) cylinder(r=n_r, h=n_h);
    translate([-n_h/2, -i_r-n_r-3.2, -80]) rotate([0, 90, 0]) cylinder(r=n_r, h=n_h);

    // bottom prisms
    translate([-n_h/2, i_r+2, -21.5]) rotate([0, 0, 0]) prism();
    translate([n_h/2, -i_r-2, -21.5]) rotate([0, 0, 180]) prism();

    // speaker holder prisms
    //translate([n_h/2, i_r - 1, 0]) rotate([0, 180, 0]) prism();
    //translate([-n_h/2, -i_r + 2, 0]) rotate([0, 180, 180]) prism();
}
//speaker_clip();
//translate([0, 0, 0]) speaker();
