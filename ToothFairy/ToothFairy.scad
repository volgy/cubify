
// Units: mm

$fa = 1;
$fs = 0.1;

H_BOTTOM =  6.5;
H_TOP = 44.5;
DIA = 9.5;
THICKNESS = 2;

// Calculated constants, do not edit
H_FULL = H_TOP + H_BOTTOM;
DIA_MID = DIA * H_TOP / (H_TOP + H_BOTTOM);

module hollow_cylinder(h, d1, d2, thickness, center=false) {
    shift = center ? 0 : h/2;
    inner_h = h - 2*thickness;
    inner_d1_x = (h-thickness)/h * d1 + thickness/h * d2 - 2 * thickness;
    inner_d2_x = (h-thickness)/h * d2 + thickness/h * d1 - 2 * thickness;
    inner_d1 = max(inner_d1_x, 0);
    inner_d2 = max(inner_d2_x, 0);
    translate([0, 0, shift]) {
        difference() {
            cylinder(h=h, d1=d1, d2=d2, center=true);
            cylinder(h=inner_h, d1=inner_d1, d2=inner_d2, center=true);
        }
    }
}

module tooth() { 
    translate([-DIA, 0, 0]) hollow_cylinder(h = H_BOTTOM, d1 = DIA, d2 = DIA_MID, thickness=THICKNESS);
    translate([DIA, 0, 0]) hollow_cylinder(h = H_TOP, d1 = DIA_MID, d2 = 0, thickness=THICKNESS);
}

module tooth_pair() {
    for(i=[-1:2:1]) translate([0, i*DIA, 0]) {
        tooth();
    }
}

tooth_pair();