module plugs() {
	cylinder(d = 8, h = 4, center = true, $fn = 30);
	translate([12, 0, 0]) cylinder(d = 8, h = 4, center = true, $fn = 30);
	translate([-12, 0, 0]) cylinder(d = 8, h = 4, center = true, $fn = 30);
	translate([0, 12, 0]) cylinder(d = 8, h = 4, center = true, $fn = 30);
	translate([0, -12, 0]) cylinder(d = 8, h = 4, center = true, $fn = 30);
}

difference() {
	cylinder(d = 40, h = 4, center = true, $fn = 120);
	#translate([0,0,0]) plugs();
}