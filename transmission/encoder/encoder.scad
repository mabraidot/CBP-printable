
$fn = 100;

holeDiameter = 8.2;     // Default M8 plus clearance
timingHoles = 14;       // Encoder resolution
shaftHeight = 12;
collarHeight = 8;      // Height of the timing bars
collarWidth = 1.4;        // Widht of the timing bars
diameter = 35;          // Desired total encoder diameter

nutDiameter = 5.4; 		// The distance across the nut, from flat to flat, default M3
nutThickness = 2.3; 	// The thickness of the nut, default M3
setScrewDiameter = 3;	// The diameter of the set screw clearance hole, default M3


trappedNut = false;     // TrappedNut or Nails

nails = 4;
nailsWidth = 2;
nailsHeight = 6;


//////////////////////////////////////////////////////////////

timingBars();
cap();

module cap(){
    
    encoderDiameter = diameter - (collarWidth*2);
    radius = (encoderDiameter/2)+collarWidth;
    
    difference(){
        // The body of the wheel/shoulder
        union(){
            cylinder(2,radius,radius);
            if(trappedNut){
                cylinder(shaftHeight,10,10);
            }
        }
        
        // Punch out the mounting hole
        translate([0,0,-0.5])
            cylinder( r=holeDiameter/2, h=holeDiameter + collarWidth + 2);
        // Punch out the trapped nut
        if(trappedNut){
        translate([6,0,shaftHeight-3.5])
            rotate([0,-90,180])
                nutTrap(
                    nutDiameter, 
                    nutThickness, 
                    setScrewDiameter, 
                    depth=(holeDiameter/2)+0.5,
                    holeLengthTop=((encoderDiameter-holeDiameter)/2)/2, 
                    holeLengthBottom=((encoderDiameter-holeDiameter)/2)/2
                );
        }
    }
    
    if(!trappedNut){
        for ( i = [0 : nails-1] ) {
             //rotate( i*(360/nails), [0, 0, 1])
             rotate([0,8,i*(360/nails)])
             arc( nailsWidth, 
                nailsHeight, 
                (holeDiameter/2)+nailsWidth, 
                degrees =200/nails 
                );
        }
    }
    
}

module timingBars(){
    encoderDiameter = diameter - (collarWidth*2);
    for ( i = [0 : timingHoles-1] ) {
         rotate( i*(360/timingHoles), [0, 0, 1])
         arc( collarWidth, 
            collarHeight+1, 
            (encoderDiameter/2)+collarWidth, 
            degrees =220/timingHoles 
            );
    }
}

module arc( height, depth, radius, degrees ) {
	// This dies a horible death if it's not rendered here 
	// -- sucks up all memory and spins out of control 
	render() {
		difference() {
			// Outer ring
			rotate_extrude($fn = 100)
				translate([radius - height, 0, 0])
					square([height,depth]);
		
			// Cut half off
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		
			// Cover the other half as necessary
			rotate([0,0,180-degrees])
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		
		}
	}
}

module nutTrap( inDiameter=5.4, thickness=2.3, setScrewHoleDiameter=3, depth=10, holeLengthTop=5, holeLengthBottom=5 )
{
	side = inDiameter * tan( 180/6 );

	render()
	union() {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, inDiameter, thickness], center=true );
		}
	
		translate([depth/2,0,0]) 
			cube( [depth, inDiameter, thickness], center=true );
	
		translate([0,0,-(thickness/2)-holeLengthBottom+2]) 
			cylinder(r=setScrewHoleDiameter/2, h=thickness+holeLengthTop+holeLengthBottom, $fn=15);
	}
}