use <MCAD/involute_gears.scad>
use <../transmission_V2/encoder/encoderMount.scad>
use <../transmission_V2/wheel/geared_wheel.scad>

//$fn = 150;
clearance = 0.2;

//LEFT
//motorClamp();
//wheelFrame();

//RIGHT
//mirror([0,1,0])motorClamp();
//mirror([0,1,0])wheelFrame();

//clamp();
//wheel_shaft();
assembly();



module assembly(){
    // Left frame
    translate([0,10,0])wheelFrame();
    //wheel
    boxAndWheel();
    //motor
    color("yellow")translate([35,1,18])rotate([0,0,180])motor();

    //encoder mount
    translate([21,18,0])rotate([0,0,-90])holder();
    //speed sensor
    translate([33,1,26])speedSensor();
    //wheel support
    translate([-15,-67,0])clamp();
    translate([15,5,0])rotate([0,0,180])motorClamp();
}




// Motor support
module motorClamp(){
    union(){
        difference(){
            cube([30,32,45]);
            translate([-2,3,5])cube([35,25,38]);
            translate([3,3,38])cube([24,25,10]);
            
            translate([15,35,23])rotate([90,0,0])cylinder(15,4+clearance,4+clearance);
            translate([15,12,6])rotate([0,180,0])bolt();
            //mounting
            translate([3,-4,18.9])cube([24,10,3+clearance]);
            translate([3,-4,36.3])cube([24,10,3+clearance]);
            translate([15,-4,24.1])cube([14,10,10+clearance]);
        }
        
        difference(){
            translate([0,20,5])prism(30,10,10);
            translate([5,15,5])cube([20,15,10]);
        }
        translate([0,-10,0])difference(){
            prism(30,10,15);
            translate([5,-5,4])cube([20,25,20]);
        }
    }
}


// Wheel support
module clamp(){
    difference(){
        prism(30,20,40);    
        translate([5,0,5])cube([20,12,30]);
        translate([15,8,6])rotate([0,180,0])bolt();
        translate([15,25,23])rotate([90,0,0])cylinder(12,4+clearance,4+clearance);
        translate([-3,10,30])cube([35,12,20]);
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
            
            rotate([90,0,0])translate([11,11,5])cylinder(2,16,16);
        }
        union(){
            rotate([90,0,0])translate([32,2.5,-27.7])cylinder(37,1.5,1.5);
            rotate([90,0,0])translate([32,19.9,-27.7])cylinder(37,1.5,1.5);
        }
    }
    
    /*union(){
            rotate([90,0,0])translate([32,2.5,-27.7])cylinder(37,1.5,1.5);
            rotate([90,0,0])translate([32,19.9,-27.7])cylinder(37,1.5,1.5);
        }*/
}


// Frame
module wheelFrame(){
    difference(){
        translate([-50,-75,-2])cube([100,100,2]);
        //holes
        union(){
            //wheel
            translate([-45,-59,-5])cube([90,20,10]);
            //motor
            translate([-37,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([-27,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([-17,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([-7,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([2,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([12,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([22,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([32,-30,-6])rotate([0,0,90])adjustableBolt(47);
            translate([42,-30,-6])rotate([0,0,90])adjustableBolt(47);
            //exterior
            translate([-45,-70,-6])rotate([0,0,0])adjustableBolt(90);
        }
    }
}


module boxAndWheel(){
    //wheel
    translate([0,-38,23])rotate([-90,0,0])geared_wheel();
    //gear
    translate([-22.5,-36,30])rotate([-90,0,0])geared_shaft();
    //rotate([90,0,0])translate([0,23,28])cylinder(11,21,21);
    rotate([90,0,0])translate([0,23,20])wheel_shaft();
}

module wheel_shaft(){
    cylinder(35,3.95+clearance/2,3.95+clearance/2);
}

module speedSensor(){
    color("red")union(){
        difference(){
            translate([12.4,-23,-18.7])cube([1.6,40,28]);
            translate([11,10,-14])rotate([0,90,0])cylinder(5,2,2);
        }
        difference(){
            cube([14,12,7]);
            translate([-1,4,-1])cube([10,4,12]);
        }
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

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
   
module adjustableBolt(length = 25){
    union(){
        cube([length,3.2+clearance,25]);
        translate([-2,-1.3,0])cube([17,6,3]);
    }
}
