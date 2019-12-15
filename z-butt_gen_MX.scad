  use <z-butt.scad>

//lp_master_base(xu = 1, yu = 1);
 shiftx = 5.1;
 rot    = 0;
//translate([0,0,20])lp_stem_cavity(xu = 2, yu = 1);
//difference(){
//  
//  mx_stem_cavity(xu = 1.5, yu = 1);
////  translate([0,4,5.5])mirror([1,0,0])text( text = "pqp", font ="Wingdings3:style=Regular", size = 2, valign = "center", halign = "center" );
//  translate([3.75+shiftx,-3.75,4.9])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,60])cylinder(r = .5, .1, $fn = 3);
//  }
//  translate([0.75+shiftx,-3.75,4.9])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,0])cylinder(r = .5, .1, $fn = 3);
//  }
//
//}
//  translate([2.25+shiftx,-4.5,4.9])rotate([0,180,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,-30])cylinder(r = .5, .1, $fn = 3);
//  }
//  
//  translate([3.75+shiftx,-2.,4.9])rotate([0,180,180])hull(){
//    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
//    translate([0,0,.5])rotate([0,0,30])cylinder(r = .5, .1, $fn = 3);
//  }
////  translate([0,0,-10])cube([20,20,20]);
////container(xu = 1, yu = 2.25, yn = 2);
// // simplex sig
//  translate([-4-shiftx,4,5]) {
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
//  
  difference(){
  
  mx_stem_cavity(xu = 1.5, yu = 1);
//  translate([0,4,5.5])mirror([1,0,0])text( text = "pqp", font ="Wingdings3:style=Regular", size = 2, valign = "center", halign = "center" );
  #rotate([0,0,rot]){
    translate([3.5+shiftx,-3.65,5.45])hull(){
      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
      translate([0,0,.5])rotate([0,0,60])cylinder(r = .5, .1, $fn = 3);
    }
    translate([0.5+shiftx,-3.65,5.45])hull(){
      rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
      translate([0,0,.5])rotate([0,0,0])cylinder(r = .5, .1, $fn = 3);
    }
  }
  
//  translate([0,0,-25])cube([20,20,50]);//check
}
rotate([0,0,rot]){
  translate([2.+shiftx,-4.40,5.55])rotate([0,180,180])hull(){
    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
    translate([0,0,.5])rotate([0,0,-30])cylinder(r = .5, .1, $fn = 3);
  }
//  translate([2.25+shiftx,-2.85,5.0])sphere(.20, $fn = 32);
  
  translate([3.5+shiftx,-2.0,5.55])rotate([0,180,180])hull(){
    rotate([0,0,30])cylinder(r = 1.5, .1, $fn = 3);
    translate([0,0,.5])rotate([0,0,30])cylinder(r = .5, .1, $fn = 3);
  }
}
//  translate([0,0,-10])cube([20,20,20]);
//container(xu = 1, yu = 2.25, yn = 2);
 // simplex sig
  rotate([0,0,rot])translate([-3.75-shiftx,4,5.5]) {
    difference() {
    minkowski(){
     {
       union(){
            cylinder(r=.75, .25, $fn = 32);
            translate([0,-.05,0])cube([4.5,.1,.25]);
          }
        }
      sphere(.15, $fn = 32);
      }
     cylinder(r=.75, , $fn = 32,center = true);
    }
        sphere(.65, $fn = 32);
        translate([2.25,0,0])sphere(.65, $fn = 32);
        translate([4.5,0,0])sphere(.65, $fn = 32);

  }