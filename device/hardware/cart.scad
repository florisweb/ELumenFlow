$fn = 100;

bottomThickness = 1.5;
wallThickness = 1.5;

screwRadiusM3 = 1.45;
screwRadiusM4 = 1.75;
screwRadiusM3Smooth = 1.6;
smoothRodRadius = 8.2/2;


axisSectionDepth = 40;


boxHeight = 48; // 60


cart();


motorConnectorHeight = 42;
module cart() {
    thickness = 9;
    padding = 5;
    depth = smoothRodRadius + padding * 2;
    height = 40;
    
    nutThickness = 5;
    nutDepth = 10;

    hoseRadius = 5.4/2;
    
    threadedRodSmoothRadius = 3.2;

    difference() {
        translate([-thickness, -depth, 0])
        cube([thickness, depth, height]);
        
        
        translate([-thickness, -depth/2, motorConnectorHeight/2 + padding])
        rotate([0, 90, 0])
        cylinder(r=smoothRodRadius + .4, thickness);
        
        translate([-thickness, -depth/2, padding])
        rotate([0, 90, 0])
        cylinder(r=threadedRodSmoothRadius, thickness);

        translate([-thickness / 2, -depth / 2, 0])
        cube([nutThickness, nutDepth, 40], true);
        
        translate([-thickness / 2, 0, height - 2])
        rotate([90, 0, 0])
        cylinder(r=hoseRadius, depth);
    }

}



