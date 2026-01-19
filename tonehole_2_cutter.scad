// Units: Inches
$fn = 100;

//conversion factors  
inches_to_mm = 25.4;

bottom_diameter = 0.485 * inches_to_mm;
top_diameter = 0.350 * inches_to_mm; // Adjusted to 0.090 to satisfy geometry with 0.28 side
side_length = 0.425 * inches_to_mm;   // Slant height

r1 = bottom_diameter / 2;
r2 = top_diameter / 2;

// Calculate height using Pythagorean theorem: 
// side^2 = height^2 + (radius_diff)^2
radius_diff = abs(r1 - r2);
height = sqrt(pow(side_length, 2) - pow(radius_diff, 2));

// Calculate height using Pythagorean theorem: 
// side^2 = height^2 + (radius_diff)^2
radius_diff = abs(r1_2 - r2_2);
height = sqrt(pow(side_length_2, 2) - pow(radius_diff, 2));

echo("Calculated Height:", height);
echo("Calculated Height:", height);

//draw the first cylinder
cylinder(r1 = r1, r2 = r2, h = height);


translate([bottom_diameter +.01, 0, 0]){
bottom_diameter_2 = 0.217 * inches_to_mm;
top_diameter_2 = 0.090 * inches_to_mm; // Adjusted to 0.090 to satisfy geometry with 0.28 side
side_length_2 = 0.28 * inches_to_mm;   // Slant height

r1_2 = bottom_diameter_2 / 2;
r2_2 = top_diameter_2 / 2;
cylinder(r1 = r1_2, r2 = r2_2, h = height);
}