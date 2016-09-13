//globals
$fn=50;
obj_round = 50;
twist_ratio = 1.62; // based on obj_height = 50 / twist=81
obj_height = 44;
twist=obj_height * twist_ratio;
shaft = 5.2;

module master(){
	module rightGear(twist) {
		rotate([0, 0, -25]) {
			translate([0, 0, obj_height/4])
			linear_extrude(height = obj_height/2, center = true, twist = twist, convexity = 10)
			    import (file = "small_gear.dxf", layer = "Layer_1");
			circle(r = 1);
		}
	}

    module gearObject() {

        module gear() {

            union() {
                rightGear(twist);
                mirror([0,0,1]) rightGear(twist);
            }

        }

        module hole() {
            cylinder(d=shaft, h=obj_height*2.1, center=true);
        }

        module bolt_hole() {
            translate([0, 0, obj_height/2-13]) rotate([0,90,0]) cylinder(d=2.5, h=10);
        }

        module bone() {
            difference() {
                gear(twist=twist);
                hole();
                #bolt_hole();
            }
        }
        union() {
            translate([5.6/2 - 0.7, -2.5, -obj_height/2]) cube([1.5,5,obj_height-7], center=false);
            bone();
        }
    }
gearObject();
}

intersection(){
    master();
}