// Units: Inches
$fn = 100;

INCH = 25.4;

bottom_diameter = 0.335 * INCH;
top_diameter = 0.290 * INCH;
side_length = 0.365 * INCH;

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
cutter_width = 0.04 * INCH; // Width of the V-cutter at the outside

module flute_on_cone(angle) {
    // The flute is a polygon that creates a sawtooth shape
    hull() {
        // Bottom of flute
        rotate([0,0,angle])
            linear_extrude(height=0.01)
                polygon(points=[
                    [r1, 0],
                    [(r1 + tooth_depth) * cos(tooth_width_angle/2), (r1 + tooth_depth) * sin(tooth_width_angle/2)],
                    [r1 * cos(tooth_width_angle), r1 * sin(tooth_width_angle)],
                    [r1 - tooth_cut_mm, 0]
                ]);

        // Top of flute
        rotate([0,0,angle - flute_twist])
            translate([0, 0, height])
                linear_extrude(height=0.01)
                    polygon(points=[
                        [r2, 0],
                        [(r2 + tooth_depth) * cos(tooth_width_angle/2), (r2 + tooth_depth) * sin(tooth_width_angle/2)],
                        [r2 * cos(tooth_width_angle), r2 * sin(tooth_width_angle)],
                        [r2 - tooth_cut_mm, 0]
                    ]);
    }
}


// M4 tap drill diameter (clearance for tap): 3.3mm
m4_tap_diameter = 3.3; // mm
m4_tap_radius = m4_tap_diameter / 2;
m4_tap_depth = height / 2;

module fluted_cone() {
    difference() {
        // Main cone
        cylinder(r1 = r1, r2 = r2, h = height, $fn = 100);

        // Flutes (serrations), following the cone's surface, now on the outside and cutting just 0.5mm into the base
        for (i = [0:num_teeth-1]) {
            angle = i * tooth_width_angle;
            flute_on_cone(angle);
        }

        // Central M4 tap hole from the top, depth = height/2
        translate([0, 0, height - m4_tap_depth])
            cylinder(r = m4_tap_radius, h = m4_tap_depth, $fn = 60);
    }
}

fluted_cone();