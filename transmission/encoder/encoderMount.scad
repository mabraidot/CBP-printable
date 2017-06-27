
$fn = 100;
clearance = 0.2;

holder();
mirror([1,0,0])translate([20,0,0])holder();

module holder(){
    difference(){
        union(){
            //floor
            difference(){
                cube([15,51,5]);
                rotate([180,0,90])translate([10,5.7,-5.5])adjustableBolt();
                translate([8,35,-1])cube([11,17,20]);
            }
            //wall
            translate([0,35,0])cube([5,16,25]);
        }
        rotate([0,90,0])translate([-18,41,-1])adjustableBolt();
    }
    
}
module adjustableBolt(){
    union(){
        cube([13,3.2+clearance,25]);
        translate([-2,-1.3,0])cube([17,6,3]);
    }
}