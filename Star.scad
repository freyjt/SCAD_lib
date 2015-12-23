
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

module Star(points=5, pointLength=5, h=6, inscCirc=25) {
    
    Point(length=pointLength, base=4, h=h);

}

Star();