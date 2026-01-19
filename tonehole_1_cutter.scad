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