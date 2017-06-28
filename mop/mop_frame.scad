
//$fn = 150;
clearance = 0.2;





//motor();
//frame();
mop();




/******************************/
/**** UTILS *******************/
/******************************/

// Frame
module mop(){
    difference(){
        union(){
            // supports
            translate([-65,-40,0])cube([130,2,5]);
            translate([-65,38,0])cube([130,2,5]);
            translate([38,-40,0])rotate([0,0,90])cube([80,2,5]);
            translate([-36,-40,0])rotate([0,0,90])cube([80,2,5]);
            
            // ballbearing support
            
            // mop mounting
            translate([60,25,0])cube([10,15,5]);
            translate([60,-40,0])cube([10,15,5]);
            translate([-70,25,0])cube([10,15,5]);
            translate([-70,-40,0])cube([10,15,5]);
            
            // frame
            translate([-90,-50,-2])cube([180,100,2]);
            
        }
        //holes
        union(){
            // holes
            translate([0,0,-1.5])cylinder(r=11+clearance, h=20);
            // spokes
            translate([15,-35,-3])cube([20,70,4]);
            translate([40,-35,-3])cube([20,70,4]);
            
            translate([-35,-35,-3])cube([20,70,4]);
            translate([-60,-35,-3])cube([20,70,4]);
            // mop flexible mounting
            translate([65,30,-2.8])bolt();
            translate([65,-30,-2.8])bolt();
            translate([-65,30,-2.8])bolt();
            translate([-65,-30,-2.8])bolt();
        }
    }
}


// Frame
module frame(){
    //color("yellow")translate([-11,-11,0])rotate([90,0,90])motor();
    union(){
        // supports
        translate([-65,-40,0])cube([130,2,5]);
        translate([-65,38,0])cube([130,2,5]);
        translate([38,-40,0])rotate([0,0,90])cube([80,2,5]);
        translate([-36,-40,0])rotate([0,0,90])cube([80,2,5]);
        // frame
        difference(){
            translate([-70,-40,-2])cube([140,80,2]);
            //holes
            union(){
                // motor mounting
                translate([-7,10,-6])rotate([0,0,90])adjustableBolt(20);
                translate([10.4,10,-6])rotate([0,0,90])adjustableBolt(20);
                // holes
                translate([0,0,-6])cylinder(r=10, h=20);
                // spokes
                translate([15,-35,-3])cube([20,70,4]);
                translate([40,-35,-3])cube([20,70,4]);
                
                translate([-35,-35,-3])cube([20,70,4]);
                translate([-60,-35,-3])cube([20,70,4]);
                // mop flexible mounting
                translate([65,30,2])rotate([0,180,0])bolt();
                translate([65,-30,2])rotate([0,180,0])bolt();
                translate([-65,30,2])rotate([0,180,0])bolt();
                translate([-65,-30,2])rotate([0,180,0])bolt();
            }
        }
    }
}



// Arduino Motor
module motor(){
    difference(){
        union(){
            //motor
            translate([36.6,-0.3,0.2])cube([29,19,22]);
            //gearbox
            cube([36.8,18.4,22.4]);
            rotate([90,0,0])translate([11,11,-27.7])cylinder(37,2.7,2.7);
            
        }
        union(){
            rotate([90,0,0])translate([32,2.5,-27.7])cylinder(37,1.5,1.5);
            rotate([90,0,0])translate([32,19.9,-27.7])cylinder(37,1.5,1.5);
        }
    }
}

module adjustableBolt(length = 25){
    union(){
        cube([length,3.2+clearance,25]);
        translate([-2,-1.3,0])cube([17,6,3]);
    }
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
