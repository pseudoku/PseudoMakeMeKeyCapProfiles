use <z-butt.scad>


lp_master_base(xu = 1.5, yu = 1);
//mark_height = 4.9;
mark_height = 1.55;

//translate([0,0,20])lp_stem_cavity(xu = 2, yu = 1);
//difference(){
//  
//  lp_stem_cavity(xu = 2, yu = 1);
////  translate([0,4,5.5])mirror([1,0,0])text( text = "pqp", font ="Wingdings3:style=Regular", size = 2, valign = "center", halign = "center" );
//  translate([1,0,0,]){
//    translate([3.75,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,60])cylinder(r = .5, .1, $fn = 3);
//    }
//    translate([0.75,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,0])cylinder(r = .5, .1, $fn = 3);
//    }
//  }
//    translate([1,0,0,])translate([2.25,-4.5,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,-30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//  translate([1,0,0,])translate([3.75,-2.,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,30])cylinder(r = .5, .1, $fn = 3);
//  }
//    translate([-5,4,mark_height-.1]) {
//    difference() {
//    minkowski(){
//     {
//       union(){
//            cylinder(r=.75, .25, $fn = 32);
//            translate([0,-.05,0])cube([4.5,.1,.25]);
//          }
//        }
//      sphere(.15, $fn = 32);
//      }
//     cylinder(r=.75, , $fn = 32,center = true);
//    }
//        sphere(.65, $fn = 32);
//        translate([2.25,0,0])sphere(.65, $fn = 32);
//        translate([4.5,0,0])sphere(.65, $fn = 32);
//
//  }
//}

//  translate([0,0,-10])cube([20,20,20]);
//container(xu = 1, yu = 2.25, yn = 2);
 // simplex sig
 //1.5u
//difference(){
//  
//  lp_stem_cavity(xu = 1.5, yu = 1);
////  translate([0,4,5.5])mirror([1,0,0])text( text = "pqp", font ="Wingdings3:style=Regular", size = 2, valign = "center", halign = "center" );
//  translate([1,0,0,]){
//    translate([5.5,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,60])cylinder(r = .5, .1, $fn = 3);
//    }
//    translate([8.5,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,0])cylinder(r = .5, .1, $fn = 3);
//    }
//  }
//  translate([1,0,0,])translate([7.0,-4.5,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,-30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//  translate([1,0,0,])translate([8.5,-2.1,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//    translate([-10,4.5,mark_height-.1]) {
//    difference() {
//    minkowski(){
//     {
//       union(){
//            cylinder(r=.75, .25, $fn = 32);
//            translate([0,-.05,0])cube([4.5,.1,.25]);
//          }
//        }
//      sphere(.15, $fn = 32);
//      }
//     cylinder(r=.75, , $fn = 32,center = true);
//    }
//        sphere(.65, $fn = 32);
//        translate([2.25,0,0])sphere(.65, $fn = 32);
//        translate([4.5,0,0])sphere(.65, $fn = 32);
//
//  }
//}
//  
  // 2u sig
//difference(){
//  
//  lp_stem_cavity(xu = 2, yu = 1);
////  translate([0,4,5.5])mirror([1,0,0])text( text = "pqp", font ="Wingdings3:style=Regular", size = 2, valign = "center", halign = "center" );
//  translate([1,0,0,]){
//    translate([13.6,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,60])cylinder(r = .5, .1, $fn = 3);
//    }
//    translate([10.4,-3.75,mark_height ])hull(){
//      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//      translate([0,0,.5])rotate([0,0,0])cylinder(r = .5, .1, $fn = 3);
//    }
//  }
//  translate([1,0,0,])translate([12.,-4.5,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,-30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//  translate([1,0,0,])translate([13.6,-2.,mark_height ])rotate([0,0,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//    translate([-15,4.5,mark_height-.1]) {
//    difference() {
//    minkowski(){
//     {
//       union(){
//            cylinder(r=.75, .25, $fn = 32);
//            translate([0,-.05,0])cube([4.5,.1,.25]);
//          }
//        }
//      sphere(.15, $fn = 32);
//      }
//     cylinder(r=.75, , $fn = 32,center = true);
//    }
//        sphere(.65, $fn = 32);
//        translate([2.25,0,0])sphere(.65, $fn = 32);
//        translate([4.5,0,0])sphere(.65, $fn = 32);
//
//  }
//}