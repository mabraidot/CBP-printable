use <MCAD/involute_gears.scad>
use <wheelv1.33.scad>


//*****************************************************
backlash = 0.05;
clearance = 0.2;

teeth_small = 14;   // number of teeth on small gear
teeth_big = 70;     // number of teeth on big gear
pressure = 20;      // pressure angle
pitch = 1.5;        // diametral pitch of all gears
//$fn=150;             // enable smoth cylinders
//*****************************************************
  

geared_shaft();
geared_wheel();

module geared_shaft(){
    translate([50,0,0])difference(){
        gear_small(t=19);
        translate([0,0,-0.1])shaftHole(shaftDiameter = 5.7, shaftHubDiameter = 3.9, height=20);
    }
}

module geared_wheel(){
    union(){
        translate([0,0,-3])gear_big(bd=8, t=11);
        wheel();
    }
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

module gear_small(nt=teeth_small, dp=pitch, t=8, pa=pressure, bd=0){
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

module shaftHole(shaftDiameter = 8, shaftHubDiameter = 0, height=20){
    
    translateShaftDiameter = (shaftHubDiameter>0) ? (shaftHubDiameter/2) : (shaftDiameter/2);
    
    difference(){
        cylinder(r=shaftDiameter/2, h=height);
        translate([-7.5,translateShaftDiameter,0])cube([15,10,height]);
    }
    
}