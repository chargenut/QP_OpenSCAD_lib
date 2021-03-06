//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Bearings
//

include <bearings_h.scad>;

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces


module bearing(bearing_type = MF106zz)
{
	color("silver")
		difference()
		{
			union()
			{
				// flange
				if (bearing_flange_radius(bearing_type) > 0)
					cylinder(	r = bearing_flange_radius(bearing_type),
								h = bearing_flange_width(bearing_type));
				
				// main bearing
				cylinder(	r = bearing_radius(bearing_type),
							h = bearing_width(bearing_type));
			}
	
			// bore
			translate([0, 0, -ff])
				cylinder(	r = bearing_bore_diameter(bearing_type) / 2,
							h = bearing_width(bearing_type) + ff * 2);
		}
}

module BOM(quantity, vitamin, description = "undefined")
{
	d = (description != "undefined") ? str(" [", description, "]") : "";
	echo(str("BOM: ", quantity, "x ", vitamin, d));
}

module BOM_bearing(quantity = 1, bearing_type = MF128rs, description = "undefined")
{
	vitamin = str(bearing_name(bearing_type));
	BOM(quantity, vitamin, description);
}

//bearing(MF106zz);
//bearing(MR6082rs);
//BOM_bearing(quantity = 1, bearing_type = MF128rs, description = "undefined");
