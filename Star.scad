
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


//Creates a star with a given number of points
//Gap if $fn is not properly set
//@straight: will override pointLength to make sure star appears to
// be constructed of connected straight lines
module Star(points=5, pointLength=5, h=6, inscCirc=24, straight=false) {
    if(straight == true){
        echo("straight is true");
        pL = inscCirc / 4; 
    } else {
        pL = pointsLength;
    }
    echo(pL);
    
    lTheta = 180 / points;
    A      = (inscCirc / 2) - pL;
    radius = A / cos(lTheta);
    B      = 2*radius*sin(lTheta);
    

    
    cylinder(r=radius, h=h);
    for(i = [0:points])
        rotate([0,0, 2*i*lTheta])
            translate([A,0,0])
                Point(length=pointLength, base=B, h=h);

}

$fn=29;

Star(points=6, pointLength=6, inscCirc=30, straight=true);





