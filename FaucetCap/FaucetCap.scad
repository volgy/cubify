/* Faucet Vacuum Breaker Valve Cap */


$fa = 5;
$fs = 1;


DIA = 32.4;
HEIGHT = 6;
THICKNESS = 2;


module semihollow_cylinder(inner_h, inner_d, thickness) {
    h = inner_h + thickness;
    d = inner_d + 2 * thickness;
    difference() {
        cylinder(h=h, d=d);
        translate([0, 0, thickness])  cylinder(h=inner_h, d=inner_d);
    }
}

module hollow_cylinder(inner_h, inner_d, thickness) {
    h = inner_h;
    d = inner_d + 2 * thickness;
    difference() {
        cylinder(h=h, d=d);
        cylinder(h=inner_h, d=inner_d);
    }
}

union() {
    semihollow_cylinder(inner_h=HEIGHT, inner_d=DIA, thickness=THICKNESS);
    translate([0, 0, HEIGHT]) hollow_cylinder(inner_h=2, inner_d=DIA-1, thickness=THICKNESS+0.5);
}