
//very simple point object
module Point(length=5, base=5, h=6) {
    
    linear_extrude(height=h){
        polygon(points=[
            [0     ,  base/2],
            [0     , -base/2],
            [length,  0     ]
        ]);
    }
    
}

function setPl( pointLength, inscCirc, straight) =
    (straight)? inscCirc / 4 : pointLength;

//Creates a star with a given number of points
//Gap if $fn is not properly set
//@straight: will override pointLength to make sure star appears to
// be constructed of connected straight lines
module Star(points=5, pointLength=5, h=6, inscCirc=24, straight=false) {
    
    pL = setPl(pointLength, inscCirc, straight);
    echo(pL);
    lTheta = 180 / points;
    A      = (inscCirc / 2) - pL;
    radius = A / cos(lTheta);
    B      = 2*radius*sin(lTheta);
    echo(A);

    
    cylinder(r=radius, h=h);
    for(i = [0:points])
        rotate([0,0, 2*i*lTheta])
            translate([A,0,0])
                Point(length=pL, base=B, h=h);

}

$fn=29;

Star(points=5, pointLength=6, inscCirc=30, straight=true);





