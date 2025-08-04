$fn = 100;

bottomThickness = 1.5;
wallThickness = 1.5;


screwRadiusM3 = 1.45;
screwRadiusM4 = 1.75;
screwRadiusM3Smooth = 1.6;


boltHeight = 14; // 14

innerBoltRadius = 5.3/2;
motorConnector(boltHeight, innerBoltRadius);

translate([0, 0, boltHeight])
boltConnector();


module boltConnector() {
    height = 15;
    innerBoltRad = 3;
    outerBoltRad = innerBoltRad + 1.5;
    
    difference() {
        union() {
            cylinder(height, r=outerBoltRad);
            translate([0, 0, 10 / 2])
            cube([outerBoltRad * 2, 18, 10], true);
        }
        cylinder(height, r=innerBoltRad);
        translate([0, 50 / 2, 10 / 2])
        rotate([90, 0, 0])
        cylinder(50, r=screwRadiusM4);
    }      
}


module motorConnector(height, innerRadius) {
    innerBoltRadius = innerRadius;
    outerBoltRadius = 3 + wallThickness;

    translate([.5/2+2.5, 0, height / 2])
    cube([1.5, 3.5, height], true);

    difference() {
        cylinder(height, r=outerBoltRadius);
        translate([0, 0, -1])
        cylinder(height + 2, r=innerBoltRadius);
    }    
}