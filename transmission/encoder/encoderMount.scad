
$fn = 100;
clearance = 0.2;

holder();

module holder(){
    union(){
        //floor
        difference(){
            cube([15,31,5]);
            rotate([180,0,90])translate([5,5.7,-5.5])adjustableBolt();
        }
        //wall
        translate([15,26,5])rotate([0,0,90])
            difference(){
                cube([5,15,25]);
                rotate([0,90,0])translate([-18,6,-1])adjustableBolt();
            }
    }
    
}
module adjustableBolt(){
    union(){
        cube([13,3.2+clearance,25]);
        translate([-2,-1.3,0])cube([17,6,3]);
    }
}