$fn = 100;

module beam() {
    translate([0, 0, -9])
    polyhedron(
        points = [
            [ 0,  0,  0 ],
            [ 1,  0,  0 ],
            [ 1,  2,  0 ],
            [ 0,  2,  0 ],
            [ 0,  0,  7 ],
            [ 1,  0,  7 ],
            [ 1,  9,  7 ],
            [ 0,  9,  7 ]],
        faces = [
            [0, 1, 2, 3],
            [4, 5, 1, 0],
            [7, 6, 5, 4],
            [5, 6, 2, 1],
            [6, 7, 3, 2],
            [7, 4, 0, 3]]);
    translate([0, 0, -2])
        cube([1, 9, 2]);
}
  

module cof_add(f) {
        difference() {
                cylinder(h = 4, r = 15 * f, center = true);
                cylinder(h = 8, r1 = 13 * f + 2, r2 = 13 * f - 6, center = true);
        }
        difference() {
                cylinder(h = 4, r1 = 22 * f, r2 = 22 * f + 4, center = true);
                cylinder(h = 8, r = 20 * f, center = true);
        }
        translate([0, 17.5 * f, 0]) {
            cylinder(h = 4, r1 = 8.84 * f, r2 = 8.84 * f + 4, center = true);
        }
        translate([15.16 * f, -8.75 * f, 0]) {
            cylinder(h = 4, r1 = 8.84 * f, r2 = 8.84 * f + 4, center = true);
        }
        translate([-15.16 * f, -8.75 * f, 0]) {
            cylinder(h = 4, r1 = 8.84 * f, r2 = 8.84 * f + 4, center = true);
        }
}

module cof_sub(f) {
        difference() {
                cylinder(h = 8, r = 20 * f, center = true);
                union() {
                    cylinder(h = 10, r = 15 * f, center = true);
                    translate([0, 17.5 * f, 0]) {
                        cylinder(h = 10, r = 8.84 * f, center = true);
                    }
                    translate([15.16 * f, -8.75 * f, 0]) {
                        cylinder(h = 10, r = 8.84 * f, center = true);
                    }
                    translate([-15.16 * f, -8.75 * f, 0]) {
                        cylinder(h = 10, r = 8.84 * f, center = true);
                    }
                }
        }
        translate([0, 17.5 * f, 0]) {
            cylinder(h = 8, r = 6.14 * f, center = true);
        }
        translate([15.16 * f, -8.75 * f, 0]) {
            cylinder(h = 8, r = 6.14 * f, center = true);
        }
        translate([-15.16 * f, -8.75 * f, 0]) {
            cylinder(h = 8, r = 6.14 * f, center = true);
        }    
}

module bottom() {
    difference() {
        union() {
            difference() {
                cube([190, 132, 76]);
                translate([2, 2, 2])
                    cube([186, 128, 76]);
            }
            translate([150, 2, 38])
                rotate([90, -90, 0])
                    cof_add(1.3);
            translate([150, 130, 38])
                rotate([-90, -90, 0])
                    cof_add(1.3);
            translate([188, 66, 38])
                rotate([90, -90, 90])
                    cof_add(1.3);
            multmatrix([[0, -1, 0, 190], [132, 0, 0, 0], [0, 0, 1, 76], [0, 0, 0, 1]])
                beam();
            multmatrix([[0, 1, 0, 0], [-132, 0, 0, 132], [0, 0, 1, 76], [0, 0, 0, 1]])
                beam();
        }
        union() {

            // Circle of friends
            translate([150, 2, 38])
                rotate([90, -90, 0])
                    cof_sub(1.3);
            translate([150, 130, 38])
                rotate([-90, -90, 0])
                    cof_sub(1.3);
            translate([188, 66, 38])
                rotate([90, -90, 90])
                    cof_sub(1.3);

            // Screw holes
            translate([6, 15, 80])
                cylinder(h = 30, r = 1.25, center = true);
            translate([6, 66, 80])
                cylinder(h = 30, r = 1.25, center = true);
            translate([6, 117, 80])
                cylinder(h = 30, r = 1.25, center = true);
            translate([184, 15, 80])
                cylinder(h = 30, r = 1.25, center = true);
            translate([184, 66, 80])
                cylinder(h = 30, r = 1.25, center = true);
            translate([184, 117, 80])
                cylinder(h = 30, r = 1.25, center = true);

            // Power supply
            translate([0, 9.5, 8])
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 2, center = true);
            translate([0, 122.5, 8])
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 2, center = true);
            translate([0, 9.5, 33.8])
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 2, center = true);
            translate([0, 9.5, 59.5])
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 2, center = true);
            translate([0, 122.5, 59.5])
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 2, center = true);
                    
                    
            translate([-2, 13.5, 4])
                difference() {
                    cube([6, 113, 59.5]);
                    union() {
                        multmatrix([[1, 0, 0, 0], [0, 1, 1, 125 - 10], [0, -1, 1, -10], [0, 0, 0, 1]])
                            cube([20, 26, 26], center = true);
                        multmatrix([[1, 0, 0, 0], [0, 1, 1, 125 - 10], [0, -1, 1, 63.5 + 6], [0, 0, 0, 1]])
                            cube([20, 26, 26], center = true);
                    }
                }
        }
    }
}

module gpu_holder() {
    color(c = [0, .3, .5, 1])
        cube ([83.8, 17.3, 3.8]);
    color(c = [.3, .3, .3, 1]) {
        translate([20.4, 4, 3.8]) {
            cube ([39, 7.3, 11.5]);
        }
    }
    color(c = [.7, .7, .7, 1]) {
        translate([67.2, 2, 3.8]) {
            cube ([16.6, 13.3, 7.5]);
        }
    }
}

module gpu() {
    color(c = [.7, .7, .7, 1]) {
        difference() {
            cube([0.86, 18.42, 120.02]);
            union() {
                translate([-1, 14.30, -1]) {
                    cube([10, 10, 8.27]);
                }
                translate([-1, -6.12, -1]) {
                    cube([10, 10, 8.27]);
                }
            }
        }
        difference() {
            translate([-11.43, 2.54, 120.02]) {
                cube([12.29, 19.05, 0.86]);
            }
            union() {
                translate([-5.08, 18.42, 120.02]) {
                    cylinder(h = 20, r = 2.21, center = true);
                }
                translate([-5.08, 20.63, 120.02]) {
                    cube([4.42, 4.42, 20], center = true);
                }
            }
        }
    }
    color(c = [.0, .3, .5, 1]) {
        translate([1, 13.14, 20.9]) {
            cube([145.7, 1.57, 55.3]);
        }
    }
}

module gpu_assembly() {
    translate([11.43, 0, 18.42]) {
        rotate([-90, 0, 0]) {
            translate([20.25, 6.275, 5])
                gpu_holder();
            gpu();
        }
    }
}

translate([0, 7, 85]) {
    // gpu_assembly();
}

bottom();


