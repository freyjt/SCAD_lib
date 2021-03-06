
//very simple point object
module Star_Point(length=5, base=5, h=6) {
    
    linear_extrude(height=h){
        polygon(points=[
            [0     ,  base/2],
            [0     , -base/2],
            [length,  0     ]
        ]);
    } 
    
} //END Star_point


//Helper for Star Determines and sets pointlength if we are making a 'straight'
//  star
function setPl( pointLength, length, straight, ang) =
    (straight)?(length*(1/tan(90-ang)))/((1/tan(ang/2))+(1/tan(90-ang))) : pointLength;
//END setPl


//Creates a star with a given number of points
//Gap if $fn is not properly set
//@straight: will override pointLength to make sure star appears to
// be constructed of connected straight lines
module Star_slower(points=5, pointLength=5, h=6, inscCirc=24, straight=false) {
    
    //Precalc values that define the shape of the star
    lTheta = 180 / points;
    pL     = setPl(pointLength, inscCirc/2, straight, 2*lTheta);
    A      = (inscCirc / 2) - pL;
    radius = A / cos(lTheta);
    B      = 2*radius*sin(lTheta);

    //create a plug for the center of the star
    cylinder(r=radius, h=h);
    
    //create all points
    for(i = [0:points])
        rotate([0,0, 2*i*lTheta])
            translate([A,0,0])
                Star_Point(length=pL, base=B, h=h);

}

//Playing around with comprehensions to speed up star drawing
module Star( points=5, pointLength=5, h=6, inscCirc= 24, straight=false) {
    lTheta = 180 / points;
    pL     = setPl(pointLength, inscCirc/2, straight, 2*lTheta);
    intRad = ((inscCirc / 2) - pL) / cos(lTheta);
    extRad = ( inscCirc / 2);
    
    extPoints = [for(i = [0:points]) [ extRad * sin(2*i*lTheta), extRad * cos(2*i*lTheta) ]];
    intPoints = [for(i = [0:points]) [intRad * sin(2*i*lTheta + lTheta),  intRad * cos(2*i*lTheta + lTheta) ]];
    Points    = [for(i = [0:points*2]) (i%2==0) ? extPoints[i / 2] : intPoints[(i-1)/2] ];
 
 
 
    linear_extrude(height = h) {
        polygon(Points);
    }
  
}



$fn=29; //make sure there are no gaps in the center rendering
//Star(points=9, pointLength=11, inscCirc=24, straight=true);


Star_faster(straight = true );


