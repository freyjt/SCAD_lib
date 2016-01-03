



use <./Star.scad>

module Star_Dome(h=10, points=5, straight=false, pointLength=10, inscCirc=25, layerCount=5) {
    
    layerHeight     = h   / layerCount;
    echo(layerHeight);
    layerReduction  = inscCirc / layerCount; //diameter reduction
    // only meaningful if straight = false
    pointProportion = (straight==true) ? 0 : pointLength / (inscCirc / 2);
    for(i = [0:layerCount]) {
        //point length should change with insc circle
        Star(   points      = points,
                inscCirc    = inscCirc    - (i * layerReduction),
                pointLength = pointLength - (i * (layerReduction/2) * pointProportion), 
                straight    = straight,
                h           = layerHeight * i);
    }
}
//Star(straight = true);
Star_Dome( straight=true );