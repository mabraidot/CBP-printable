use <../transmission/gears/wheelGears.scad>

$fn = 100;
clearance = 0.2;


/*union(){
    rotate([0,0,90])translate([-70,-30,0])holder();
    boxAndWheel();
}*/

// Left frame
wheelFrame();
// Right frame
mirror([0,1,0])translate([0,-70,0])wheelFrame();

// Frame
module wheelFrame(){
    difference(){
        translate([-50,-75,-2])cube([100,100,2]);
        union(){
            translate([-40,-49,-5])cube([80,20,10]);
            translate([32.5,-11.5,-6])bolt();
            translate([-24,15,-6])bolt();
            rotate([0,0,90])translate([-66,-15,-6])adjustableBolt();
            
            translate([-40,-20,-5])cube([60,27,10]);
            translate([-40,-66,-5])cube([45,10,10]);
            translate([20,-66,-5])cube([20,10,10]);
            translate([-15,-2,-5])cube([55,17,10]);
        }
    }
}

module adjustableBolt(){
    union(){
        cube([13,3.2+clearance,25]);
        translate([-2,-1.3,0])cube([17,6,3]);
    }
}