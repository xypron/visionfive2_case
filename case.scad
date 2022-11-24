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
                translate([-1, -5.88, -1]) {
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

module card_holder() {
    color(c = [1, 0.5, 0]) {
        // ground plate
        difference() {
            cube([190, 132, 2]);
            union() {
                translate([20, 12, -5])
                    cube([158, 108, 10]);
                // Screw holes
                translate([6, 15, 0])
                    cylinder(h = 30, r = 1.75, center = true);
                translate([6, 66, 0])
                    cylinder(h = 30, r = 1.75, center = true);
                translate([6, 117, 0])
                    cylinder(h = 30, r = 1.75, center = true);
                translate([184, 15, 0])
                    cylinder(h = 30, r = 1.75, center = true);
                translate([184, 66, 0])
                    cylinder(h = 30, r = 1.75, center = true);
                translate([184, 117, 0])
                    cylinder(h = 30, r = 1.75, center = true);
            }
        }
        difference() {
            translate([2.5, 122.5, 0])
                cube([13.68, 3, 70]);

            union() {
                translate([11.43, 123.5, 9]) {
                    rotate([90, 0, 0])
                        cylinder(h = 20, r = 1.65, center = true);
                }
                translate([11.43, 123.5, 36]) {
                    rotate([90, 0, 0])
                        cylinder(h = 20, r = 1.65, center = true);
                }
                translate([11.43, 123.5, 60]) {
                    rotate([90, 0, 0])
                        cylinder(h = 20, r = 1.65, center = true);
                }
            }
        }

        // vertical walls
            translate([22, 125, 0])
                cube([165.5, 2, 8.5]);

        difference() {
            translate([20.0, 8.775, 0]) {
                cube([159.5, 2, 40]);
            }
            // Slit for card holder
            translate([50.63, 8.5, 29.5])
                cube([45, 40, 3]);
        }
        // Support for GPU holder
        translate([36.68, 8.775, 0])
            cube([83.8, 5, 3.345]);
        translate([36.68, 8.775, 21.645])
            cube([83.8, 4, 2]);

        translate([177.5, 2.5, 0])
            cube([2, 125, 40]);

        // GPU support
        difference() {
            union() {
                translate([157.5, 35.775, 0])
                    cube([20, 10, 2]);
                translate([157.5, 35.775, 0])
                    cube([20, 2, 20]);
            }
            translate([156.5, 30.775, 12.18])
                cube([10, 10, 2.6]);
        }

        translate([2.5, 121, 0]) {
            cube([2, 8.5, 70]);
        }
        difference() {
            union() {
                translate([2.5, 2.5, 0])
                    cube([12, 8, 70]);
                translate([14.18, 2.5, 0])
                    cube([7.5, 9, 70]);
            }
            union() {
                translate([4.5, 4.5, -1])
                    cube([14, 4, 72]);
                translate([16.18, 4.5, -1])
                    cube([3.5, 5, 72]);
                // Slit for GPU
                translate([16.18, 8.5, 12.62])
                    cube([1.5, 6.5, 11.22]);
                // Slit for platina holder
                translate([16.18, 8.5, 29.5])
                    cube ([2.5, 6., 37]);

            }
        }
        difference() {
            translate([177.5, 2.5, 0])
                cube([10, 8, 70]);
            translate([179.5, 4.5, -1])
                cube([6, 4, 72]);
        }
        difference() {
            translate([177.5, 121.5, 0])
                cube([10, 8, 70]);
            translate([179.5, 123.5, .1])
                cube([6, 4, 72]);
        }
        // bars
        translate([14.18, 8.5, 0])
            cube([2, 8.5, 40]);
        translate([14.18, 8.5, 0])
            cube([2, 117, 11]);
        translate([14.18, 8.5, 25.42])
            cube([2, 117, 17]);
        translate([14.18, 8.5, 65])
            cube([2, 117, 5]);
    }
}

module platina() {
    color(c = [.3, .3, .3, 1]) {
        difference() {
            cube ([74.2, 100.2, 1.6]);
            translate([21.7, 3.6, 0])
                cylinder(h = 10, r = 1.75, center = true);
            translate([21.7, 96.6, 0])
                cylinder(h = 10, r = 1.75, center = true);
            translate([70.7, 3.6, 0])
                cylinder(h = 10, r = 1.75, center = true);
            translate([70.7, 96.6, 0])
                cylinder(h = 10, r = 1.75, center = true);
        }
    }
    color(c = [.7, .7, .7, 1]) {
        // Ethernet
        translate([-3.3, 1.9, 1.6])
            cube([21.3, 16, 13.5]);
        translate([-3.3, 21.5, 1.6])
            cube([21.3, 16, 13.5]);
        // HDMI
        translate([-3.3, 42, 3])
            cube([23, 5.5, 15]);
        // USB
        translate([-3.3, 53.9, 2.3])
            cube([17.8, 14.6, 15.6]);
        translate([-3.3, 73.4, 2.3])
            cube([17.8, 14.6, 15.6]);
        // Audio
        translate([-1, 91.5, 1.6])
            cube([15, 7, 6]);
        translate([0, 95.1, 4.6]) {
            rotate([0, 90, 0])
                cylinder(h = 6, r = 3, center = true);
        }
    }
}

module platina_holder() {
    color(c = [.3, .3, .3, 1]) {
        difference() {
            union() {
                translate([-2.5, 0, -14])
                    cube ([76.7, 100.2, 2]);

                translate([-2.5, 0, -14])
                    cube ([76.7, 2, 11.5]);

                translate([-2.5, 98.2, -14])
                    cube ([76.7, 2, 11.5]);

                translate([72.2, 0, -14])
                    cube ([2, 100.2, 11.5]);

                translate([-2.5, -10, -14])
                    cube ([2, 122.2, 36]);

                translate([-13.93, 110.2, -14])
                    cube ([21.43, 2, 36]);

                translate([-2.5, 0, -14])
                    cube ([10, 112.2, 2]);

                translate([5.5, 98.2, -14])
                    cube ([2, 14, 11.5]);

                translate([34.2, -10, -14])
                    cube ([40, 100.2, 2]);

                translate([21.7, 3.6, -7])
                    cylinder(h = 14, r = 3.5, center = true);
                translate([21.7, 96.6, -7])
                    cylinder(h = 14, r = 3.5, center = true);
                translate([70.7, 3.6, -7])
                    cylinder(h = 14, r = 3.5, center = true);
                translate([70.7, 96.6, -7])
                    cylinder(h = 14, r = 3.5, center = true);
            }

            union() {

                translate([7.5, 10, -15])
                    cube ([56.7, 80.2, 4]);

                translate([26.2, 8.1, 0])
                    cube([6, 6, 14], center = true);

                // PCIe cable
                translate([34.2, 100.2, -4]) {
                    rotate([90, 0, 0])
                        cylinder(h = 10, r = 3, center = true);
                }
                translate([34.2, 100.2, -1])
                    cube([6, 6, 6], center = true);

                // Screw holes
                translate([-7.5, 108, -8]) {
                    rotate([90, 0, 0])
                        cylinder(h = 20, r = 2.25, center = true);
                }
                translate([-7.5, 108, 16]) {
                    rotate([90, 0, 0])
                        cylinder(h = 20, r = 2.25, center = true);
                }

                translate([21.7, 3.6, -7])
                    cylinder(h = 16, r = 1.25, center = true);
                translate([21.7, 96.6, -7])
                    cylinder(h = 16, r = 1.25, center = true);
                translate([70.7, 3.6, -7])
                    cylinder(h = 16, r = 1.25, center = true);
                translate([70.7, 96.6, -7])
                    cylinder(h = 16, r = 1.25, center = true);

                // Ethernet
                translate([-3.3, .9, .6])
                    cube([21.3, 18, 15.5]);
                translate([-3.3, 20.5, .6])
                    cube([21.3, 18, 15.5]);
                // HDMI
                translate([-3.3, 41, 2])
                    cube([23, 7.5, 17]);
                // USB
                translate([-3.3, 52.9, 1.3])
                    cube([17.8, 16.6, 17.6]);
                translate([-3.3, 72.4, 1.3])
                    cube([17.8, 16.6, 17.6]);
                // Audio
                translate([-1.25, 90.5, 0.6])
                    cube([15, 9, 8]);
                translate([0, 95.1, 4.6]) {
                    rotate([0, 90, 0])
                        cylinder(h = 10, r = 4, center = true);
                }
            }
        }
    }
}

module cover() {
    color(c = [0.3, 0.3, 0.3]) {
        // ground plate
        difference() {
            union() {
                difference() {
                    cube([190, 132, 71]);
                    translate([2, 2, -2])
                        cube([186, 128, 71]);
                    translate([-4, 12, 6])
                        cube([10, 110, 60]);
                }
                translate([120, 66, 69]) {
                    rotate([0, 0, 180])
                        cof_add(2.1);
                }
            }
            union() {
                translate([120, 66, 69]) {
                    rotate([0, 0, 180])
                        cof_sub(2.1);
                }
            }
        }
    }
}

/*
difference() {
    translate([0, 0, 78])
        cover();
    translate([-2, 120, 100])
        cube([200, 200, 200]);
}
*/
translate([18.93, 15.5, 120]) {
    platina();
    platina_holder();
}

translate([0, 0, 76]) {
    card_holder();
}

translate([5, 6.5, 85]) {
    gpu_assembly();
}
bottom();

// platina_holder();
// card_holder();
rotate([180, 0, 0]) {
//    cover();
}
