use <MCAD/involute_gears.scad>

//*****************************************************
backlash = 0.25;
clearance = 0.2;

teeth_small = 12;   // number of teeth on small gear
teeth_big = 60;     // number of teeth on big gear
pressure = 20;      // pressure angle
pitch = 1.5;        // diametral pitch of all gears
$fn=100;             // enable smoth cylinders
//*****************************************************
    
//shaft();
//reduction();
//wheel();
//box();

//bolt();
//nut();
//trapped_nut();
//bearing_clamp();
//motor_clamp();
//tab_wing();
assembly();
//boxAndWheel();

module boxAndWheel(){
    rotate([90,0,0])translate([0,23,34])cylinder(11,42,42);
    color("darkorange")
        rotate([90,0,0])translate([0,23,18])wheel();
    color("yellow")
        translate([-50,-26.5,0])box();
}

module assembly(){
    color("darkorange")
        rotate([90,0,0])translate([-24,1,-4])shaft();
    color("darkorange")
        rotate([90,0,0])reduction();
    color("darkorange")
        rotate([90,0,0])translate([-24,0,9])reduction();
    color("darkorange")
        rotate([90,0,0])translate([0,0,18])wheel();
    color("yellow")
        translate([-50,-26.5,-23])box();
}



module box(){
    union(){
        // reduction 1 nut
        rotate([90,0,0])translate([21.5,20,-1])trapped_nut();
        // reduction 2 nut
        rotate([90,0,180])translate([-54.5,20,29])trapped_nut();
        difference(){
            cube([76,30,26]);
            // hollow box cut
            translate([2,2,2])cube([72,26,26]);
            // shaft cut
            rotate([90,0,0])translate([26,24,-31])cylinder(4, 6, 6);
            // wheel cut
            rotate([90,0,0])translate([50,23,-3])
                cylinder(4, 12, 12);
            // reduction 1 cut
            rotate([90,0,0])translate([26,23,-3])
                cylinder(4, 1.5+clearance, 1.5+clearance);
            // reduction 2 cut
            rotate([90,0,0])translate([50,23,-31])
                cylinder(4, 1.5+clearance, 1.5+clearance);
            
        };
        rotate([90,0,0])translate([26,24,-45.5])motor_clamp();
        rotate([90,0,0])translate([50,23,-2])bearing_clamp();
        rotate([0,0,90])translate([15,-76,0])tab_wing();
    }
    
}


// Total height: 29mm
// Diameter: 41.6mm
module wheel(){
    gear_big(t=4, bd=3);
    difference(){
        translate([0,0,4])cylinder(30,3.95+clearance/2,3.95+clearance/2);
        translate([0,0,19])cylinder(16,1.75+clearance/2,1.75+clearance/2);
    }
}

// Total height: 14mm
// Diameter: 41.6mm
module reduction(){
    gear_big(t=4, bd=2.8+clearance);
    translate([0,0,4])gear_small(t=10, bd=2.8+clearance);
}

// Diameter: 9.6mm
module shaft(){
    gear_small(t=8, bd=2.0+clearance);
}


//*****************************************************
module gear_big(nt=teeth_big, dp=pitch, t=4, pa=pressure, bd=0){
    gear(number_of_teeth = nt,
		diametral_pitch = dp,
		gear_thickness = t,
		rim_thickness = t,
		hub_thickness = t,
		bore_diameter = bd,
        backlash = backlash,
		clearance = clearance,
		pressure_angle = pa);
}

module gear_small(nt=teeth_small, dp=pitch, t=4, pa=pressure, bd=0){
    gear(number_of_teeth = nt,
		diametral_pitch = dp,
		gear_thickness = t,
		rim_thickness = t,
		hub_thickness = t,
		bore_diameter = bd,
		backlash = backlash,
		clearance = clearance,
		pressure_angle = pa);
}
module bolt(){
    union(){
        cylinder(25, 1.5+clearance, 1.5+clearance);
        cylinder(3, 3.5, 3.5, $fn=6);
    }
}

module nut(){
    union(){
        cylinder(25, 1.5+clearance, 1.5+clearance);
        translate([-0.5,0,5])cylinder(3, 3.5, 3.5, $fn=6);
        translate([-2.2,-3.05,5])cube([10,6.1,3]);
    }
}
module trapped_nut(){
    difference(){
        union(){
            cube([9,6,8]);
            translate([4.5, 0, 0])cylinder(8, 4.5, 4.5);
        }
        rotate([0,0,90])translate([3,-4.5,-3])nut();
    }
}
module bearing_clamp(){
    union(){
        difference(){
            cylinder(8, 13.95, 13.95);
            translate([0,0,-0.5])cylinder(9, 10.92, 10.92);
            translate([-4,9,-0.5])cube([8,5,9]);
        }
        difference(){
            union(){
                translate([4,11,0])cube([3,9,8]);
                translate([-7,11,0])cube([3,9,8]);
            }
            rotate([0,90,0])translate([-4,16,-8.5])rotate([0,0,90])bolt();
        }
    }
}
module motor_clamp(){
    difference(){
        union(){
            // clamp
            difference(){
                cylinder(8, 15.5, 15.5);
                translate([0,0,-0.5])cylinder(9, 12.5, 12.5);
                translate([-4,11,-0.5])cube([8,5,9]);
            }
            // clamp wings
            difference(){
                union(){
                    translate([4,13,0])cube([3,9,8]);
                    translate([-7,13,0])cube([3,9,8]);
                }
                rotate([0,90,0])translate([-4,18,-8.5])
                    rotate([0,0,90])bolt();
            }
            // base
            translate([-8,-24,0])cube([16,6,16]);
            // base joint
            translate([-8,-19,0])cube([16,6,8]);
        };
        rotate([90,0,0])translate([0,4,11.8])bolt();
    }
    
}
module tab_wing(){
    difference(){
        rotate([0,0,22.5])cylinder(6,14,14,$fn=8);
        rotate([180,0,90])translate([-6.5,0,-6.5])bolt();
        translate([-16,1,-1])cube([32,20,8]);
    }
}