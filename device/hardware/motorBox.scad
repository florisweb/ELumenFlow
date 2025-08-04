$fn = 100;

bottomThickness = 1.5;
wallThickness = 1.5;


screwRadiusM3 = 1.45;
screwRadiusM4 = 1.75;
screwRadiusM3Smooth = 1.6;
smoothRodRadius = 8.2/2;


axisSectionDepth = 40;

boxWidth = 150;
boxDepth = 195 - axisSectionDepth;
boxHeight = 60;

//endBox();
//translate([-boxWidth - 20, 0, 0])
box();

//translate([-boxWidth * 2 - 40, 0, 0])
//otherEndBox();

//motorMount();
//translate([0, 50, 0])
//otherMount();





module box(addConnectFlaps = true) {
    hookWidth = 10;
    hookDepth = 10;
    
    hookCount = 5;
    
    translate([-boxWidth, 0, 0])
    difference() 
    {
        cube([boxWidth, boxDepth, boxHeight]);
        translate([0, wallThickness, bottomThickness])
        cube([boxWidth, boxDepth - wallThickness * 2, boxHeight - bottomThickness]);
        
        for (i=[0:hookCount - 1]) {
            x = boxDepth / hookCount * (i + .5);
            translate([boxWidth - hookWidth, x, 0])
            rotate([0, 0, -90])
            hook(hookWidth, hookDepth + 1, 5, 0);
        }
    }
    
    for (i=[0:hookCount - 1]) {
        x = boxDepth / hookCount * (i + .5);
        translate([-boxWidth - hookWidth, x, 0])
        rotate([0, 0, -90])
        hook(hookWidth, hookDepth, 5);
    }
    
    if (addConnectFlaps) {
        
        overlapWidth = 10;
        overlapVerticalOffset = 2;
        translate([-2, wallThickness, bottomThickness + overlapVerticalOffset]) {
            cube([overlapWidth + 2, wallThickness, boxHeight - bottomThickness - overlapVerticalOffset]);
        
            translate([0, boxDepth - wallThickness * 3, 0])
            cube([overlapWidth + 2, wallThickness, boxHeight - bottomThickness - overlapVerticalOffset]);
        }
    }
}






module endBox() { // boxWidth = 50;
    box(addConnectFlaps=false);
    translate([-wallThickness, 0, 0])
    cube([wallThickness, boxDepth, boxHeight]);
    translate([-boxWidth / 2, 0, 0])
    cube([boxWidth / 2, boxDepth, bottomThickness]);
    
    translate([0, 0, bottomThickness])
    motorMount();
    translate([-3, -axisSectionDepth, 0])
    cube([15 + 3, boxDepth + axisSectionDepth, bottomThickness]);
}



module otherEndBox() {
    difference() {
        box(addConnectFlaps=true);
        translate([-boxWidth * 2, 0, 0])
        cube([boxWidth, boxDepth, boxHeight]);
    }
    translate([-boxWidth, 0, 0])
    cube([wallThickness, boxDepth, boxHeight]);

    
    translate([-boxWidth+3, 0, bottomThickness])
    otherMount();
    translate([-boxWidth, -axisSectionDepth, 0])
    cube([15 + 3, boxDepth + axisSectionDepth, bottomThickness]);
}








module motorMount() {
    thickness = 3;
    motorConnectorHeight = 42;
    
    difference() {
        union() {
            translate([0, -axisSectionDepth, 0])
            rotate([0, 0, 90])
            motorMountPanel(axisSectionDepth, motorConnectorHeight, thickness);
            
            translate([-thickness, -axisSectionDepth, motorConnectorHeight])
            cube([thickness, axisSectionDepth, boxHeight - motorConnectorHeight - bottomThickness]);
        }
        
        translate([-thickness, -axisSectionDepth/2, motorConnectorHeight])
        rotate([0, 90, 0])
        cylinder(r=smoothRodRadius,thickness);
    }
}


module otherMount() {
    thickness = 3;
    motorConnectorHeight = 42;
    threadedRodSmoothRadius = 3.3;
    
    difference() {
        translate([-thickness, -axisSectionDepth, 0])
        cube([thickness, axisSectionDepth, boxHeight]);
        
        translate([-thickness, -axisSectionDepth/2, motorConnectorHeight])
        rotate([0, 90, 0])
        cylinder(r=smoothRodRadius,thickness);
        
        translate([-thickness, -axisSectionDepth/2, motorConnectorHeight / 2])
        rotate([0, 90, 0])
        cylinder(r=threadedRodSmoothRadius, thickness);
    }
    translate([-thickness, -axisSectionDepth, boxHeight - 30])
    cube([1, axisSectionDepth, 30]);
}





module motorMountPanel(width, height, thickness) {
    screwRadius = 1.55;
    holeDistance = 31;

    motorHoleRadius = 12;
    xPadding = (width - (holeDistance + screwRadius * 2))/2;
    yPadding = (height - (holeDistance + screwRadius * 2))/2;

    
    difference() {
        cube([
            width,
            thickness, 
            height
        ]);
        
        translate([xPadding + screwRadius, thickness + 1, yPadding + screwRadius])
        {
            rotate([90, 0, 0]) cylinder(thickness + 2, r=screwRadius, true);

            translate([holeDistance, 0, 0])
            rotate([90, 0, 0]) cylinder(thickness + 2, r=screwRadius, true);
            translate([0, 0, holeDistance])
            rotate([90, 0, 0]) cylinder(thickness + 2, r=screwRadius, true);
            translate([holeDistance, 0, holeDistance])
            rotate([90, 0, 0]) cylinder(thickness + 2, r=screwRadius, true);
                
            translate([holeDistance / 2, 0, holeDistance / 2])
            rotate([90, 0, 0]) cylinder(thickness + 2, r=motorHoleRadius, true);
        }
    }
}












module hook(width, depth, size, margin = 0.01) {
    translate([-size/2 + margin, margin, 0])
    cube([size - margin * 2, depth - margin * 2, bottomThickness]);
    translate([-width/2 + margin, margin, 0])
    cube([width - margin * 2, size - margin * 2, bottomThickness]);
}