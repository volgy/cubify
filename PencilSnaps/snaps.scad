PENCIL_DIA = 7;
PENCIL_LEAD_DIA = 2;
PENCIL_LENGTH = 190;
PENCIL_HEAD_LENGTH = 10;
PENCIL_COLOR = "yellow";

SNAP_W = 1.5;
SNAP_INNER_DIA = 9.3;
SNAP_CLAW_WIDTH = 0.4;
SNAP_OUTER_DIA = SNAP_INNER_DIA + 2*SNAP_W;
SNAP_COLOR = "gray";
SNAP_H = SNAP_OUTER_DIA * cos(30);

module pencil() {
	
	difference() {
		union() {
			difference() {
				color(PENCIL_COLOR) cylinder(h = PENCIL_LENGTH, d = PENCIL_DIA, center = true, $fn = 6);  
				cylinder(h = PENCIL_LENGTH+1, d = PENCIL_LEAD_DIA, center = true, $fn = 30);  
			}
			color("black") cylinder(h = PENCIL_LENGTH, d = PENCIL_LEAD_DIA, center = true, $fn = 30);
		}
		translate([0, 0, (PENCIL_LENGTH-PENCIL_HEAD_LENGTH)/2]) difference() {
			translate([0, 0, 1]) cylinder(h = PENCIL_HEAD_LENGTH+1, d = PENCIL_DIA, center = true, $fn = 30);
			cylinder(h = PENCIL_HEAD_LENGTH, d1 = PENCIL_DIA, d2 = 0, center = true, $fn = 30);
		}
	}
}

module snap_claw() {
	color(SNAP_COLOR)
	union () {
		# translate([0,0,0]) cube([2*SNAP_W, 3*SNAP_W, SNAP_H], center = true);
		translate([SNAP_OUTER_DIA/2, 0, 0]) union() {
			difference() {
				cylinder(h = SNAP_H, d = SNAP_OUTER_DIA, center = true, $fn = 6);
				cylinder(h = SNAP_H+1, d = SNAP_INNER_DIA, center = true, $fn = 6);
				translate([SNAP_OUTER_DIA/2 + SNAP_INNER_DIA/2*sin(30), 0, 0]) cube(SNAP_OUTER_DIA, SNAP_OUTER_DIA, SNAP_H, center = true);
			}
			linear_extrude(height = SNAP_H, center = true, convexity = 2, twist = 0)
				polygon(points=[[SNAP_INNER_DIA/2 * sin(30), SNAP_INNER_DIA/2 * cos(30)],
							    	 [0, SNAP_INNER_DIA/2 * cos(30)],
         	             	 [SNAP_INNER_DIA/2 * sin(30), SNAP_INNER_DIA/2 * cos(30)-SNAP_CLAW_WIDTH]], paths=[[0,1,2]]);

			linear_extrude(height = SNAP_H, center = true, convexity = 2, twist = 0)
				polygon(points=[[SNAP_INNER_DIA/2 * sin(30), -SNAP_INNER_DIA/2 * cos(30)],
							 		 [0, -SNAP_INNER_DIA/2 * cos(30)],
	      	                [SNAP_INNER_DIA/2 * sin(30), -SNAP_INNER_DIA/2 * cos(30)+SNAP_CLAW_WIDTH]], paths=[[0,1,2]]);
		}
	}
}

module snap_turn () {
	union() {
		translate([SNAP_H/2, 0, 0]) snap_claw();
		translate([0, 0, (SNAP_H)/2]) rotate([0, -90, 180]) snap_claw();
		# color(SNAP_COLOR)  cube([SNAP_H, 3*SNAP_W, SNAP_H], center = true);
	}
}

module snap_twist () {
	union() {
		snap_claw();
		rotate([90, 0, 180]) snap_claw();
	}
}


module snap_inline () {
	union() {
		snap_claw();
		rotate([0, 0, 180]) snap_claw();
	}
}

// pencil();
//translate([SNAP_OUTER_DIA/2, 0, 0]) snap_simple();
//snap_twist();

translate([0,0,0]) {
	snap_inline();
	translate([15, 0, 0]) snap_turn();
	translate([-18, 0, 0]) snap_twist();
}

