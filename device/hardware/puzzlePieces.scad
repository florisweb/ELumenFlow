$fn = 100;

bottomThickness = 1.5;
wallThickness = 1.5;


hookWidth = 10;
hookDepth = 10;
hookSize = 5;

translate([-(hookWidth + 5) / 2, 10, 0])
cube([hookWidth + 5, 5, bottomThickness]);
hook(hookWidth, hookDepth + 1, hookSize);


translate([20, 0, 0])
hookHolder(hookWidth, hookDepth, hookSize);





module hookHolder(width, depth, size) {
    difference() {
        translate([-(width + 5) / 2, -5, 0])
        cube([width + 5, depth + 5, bottomThickness]);
        hook(width, depth, size, 0);
    }
}
module hook(width, depth, size, margin = 0.01) {
    translate([-size/2 + margin, margin, 0])
    cube([size - margin * 2, depth - margin * 2, bottomThickness]);
    translate([-width/2 + margin, margin, 0])
    cube([width - margin * 2, size - margin * 2, bottomThickness]);
}



