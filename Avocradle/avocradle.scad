// Avocradle
//
// Copyright (C) 2017, Peter Volgyesi <peter.volgyesi@gmail.com>
//

$fa = 5;
$fs = 1;

// units: mm

// design params
HEIGHT = 30;
THICKNESS = 2;
D_INNER = 60;
D_OUTER =   90;
SINK = 6;
D_PEG = 6;
O_PEG = 15;

module hollow_cylinder(h, d, thickness) {
    inner_h = h - thickness;
    inner_d = max(d - 2 * thickness, 0);
    difference() {
        cylinder(h=h, d=d);
        translate([0, 0, thickness])  cylinder(h=inner_h, d=inner_d);
    }
}



module semisphere(d) {
    translate([0, 0, d/2]) difference() {
        sphere(d=d);
        translate([-d/2, -d/2, 0]) cube(size=[d, d, d/2]);
    }
}

union() {
    difference() {
        difference() {
            union() {
                hollow_cylinder(HEIGHT, D_OUTER, THICKNESS);
                translate([0, 0, -SINK]) semisphere(D_INNER, THICKNESS);
            }
            translate([0, 0, -SINK+THICKNESS]) semisphere(D_INNER - 2 * THICKNESS);
        }
        translate([-D_OUTER/2, -D_OUTER/2, -D_OUTER]) cube(size=[D_OUTER, D_OUTER, D_OUTER]);
    }

    // semisphere pegs
    translate([-O_PEG, 0, D_PEG/2]) rotate([180, 0, 0]) semisphere(d=D_PEG);
    translate([O_PEG, 0, D_PEG/2]) rotate([180, 0, 0]) semisphere(d=D_PEG);
    translate([0, -O_PEG, D_PEG/2]) rotate([180, 0, 0]) semisphere(d=D_PEG);
    translate([0, O_PEG, D_PEG/2]) rotate([180, 0, 0]) semisphere(d=D_PEG);

    // cylinder pegs
    //translate([-O_PEG, 0, 0]) cylinder(h=THICKNESS, d=D_PEG);
    //translate([O_PEG, 0, 0]) cylinder(h=THICKNESS, d=D_PEG);
    //translate([0, -O_PEG, 0]) cylinder(h=THICKNESS, d=D_PEG);
    //translate([0, O_PEG, 0]) cylinder(h=THICKNESS, d=D_PEG);
}