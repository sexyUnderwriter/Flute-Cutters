// Units: Inches
$fn = 100;

INCH = 25.4;

bottom_diameter = 0.217 * INCH;
top_diameter = 0.090 * INCH;
side_length = 0.28 * INCH;

r1 = bottom_diameter / 2;
r2 = top_diameter / 2;

// Calculate height using Pythagorean theorem: 
radius_diff = abs(r1 - r2);
height = sqrt(pow(side_length, 2) - pow(radius_diff, 2));

num_teeth = 12;
tooth_depth = .02 * INCH;
tooth_width_angle = 360 / num_teeth;
flute_twist = 0; // degrees of twist from bottom to top for right rake

tooth_cut_mm = 0.5; // 0.5mm cut into the base

module flute_on_cone(angle) {
    // The flute is a thin box that starts just 0.5mm inside the base and extends to the outside at the top
    hull() {
        // Bottom of flute (cuts 0.5mm into the base)
        rotate([0,0,angle])
            translate([r1 + tooth_depth/2, 0, 0])
                cylinder(h=0.01, r=tooth_depth/2, $fn=12);
        rotate([0,0,angle])
            translate([r1 - tooth_cut_mm, 0, 0])
                cylinder(h=0.01, r=tooth_depth/2, $fn=12);
        // Top of flute (at top of cone, outside, with twist)
        rotate([0,0,angle - flute_twist])
            translate([r2 + tooth_depth/2, 0, height])
                cylinder(h=0.01, r=tooth_depth/2, $fn=12);
        rotate([0,0,angle - flute_twist])
            translate([r2, 0, height])
                cylinder(h=0.01, r=tooth_depth/2, $fn=12);
    }
}

module fluted_cone() {
    difference() {
        // Main cone
        cylinder(r1 = r1, r2 = r2, h = height, $fn = 100);

        // Flutes (serrations), following the cone's surface, now on the outside and cutting just 0.5mm into the base
        for (i = [0:num_teeth-1]) {
            angle = i * tooth_width_angle;
            flute_on_cone(angle);
        }
    }
}

fluted_cone();