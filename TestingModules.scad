use <./Star.scad>


Star(points=6, h=1, pointLength=6, inscCirc=24);

difference() {
    Star(points=6, pointLength=6, inscCirc=24);
    Star(points=6, pointLength=5, inscCirc=20);
}