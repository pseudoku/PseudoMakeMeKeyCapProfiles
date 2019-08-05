plate_thickness = 1;
plate_size = 15.6;
edge_offset = 1;
bottom_height = 5;
bottom_size = plate_size - 2;

top_height = 11.6;

switch_height = 3.0;
switch_thick = 1;
switch_width = 5;
switch_length = 3;

cap_height = .38*25.4;
cap_heightShift = 0.69*25.4;
cap_width = 18.3;

clip_Length = 3;  // length clipped

//dummy key switch with caps to check position
module Switch(switchScale= [1,1,1], colors = "teal", clipLength = 0, type = "")
{
  difference(){
    union(){
      translate([0,0,1.75]){
        difference(){
          translate([0,0,0.5])cube([15,15,1], center = true);
          //cuts
      //    translate([15/2-1/2,0,.5])cube([1,10.5,2], center = true);
      //    translate([-15/2+1/2,0,.5])cube([1,10.5,2], center = true);
        }

        translate([0,0,1.5])cube([13,13,2], center = true);
        color("springGreen")translate([0,0,4])cube([11.4,4,3], center = true);
        color("springGreen")translate([0,1,4])cube([3,5,3], center = true);
        color("DarkSlateGray")translate([0,0,-1])cube([13,14,2,],center = true);
        color("DarkSlateGray")translate([0,0,-2-2.5])cylinder(d=3.3, 2.5);
        color("DarkSlateGray")translate([5,0,-2-2.5])cylinder(d=1.6, 2.5); 
        color("DarkSlateGray")translate([-5,0,-2-2.5])cylinder(d=1.6, 2.5); 

        //cap
        color("ivory")hull(){
          translate([0,0,4.5+1])cube([17.5,16.8,2],center = true);
          translate([0,1.25,4.5+1+1.5])cube([14.5,12.5,1.5],center = true);
        }
      }
    }
    if (clipLength != 0){ // commiting unholy act in name of ergonomics
      translate([0, -sign(clipLength)*7.8-clipLength,  0])cube([20, 15.6, 40], center = true);
    }
  }
}

module Cutter()
{
  bottom_height = 4.5;
  bottom_chamfer_width = 3;
  bottom_chamfer_height =  1;
  bottom_chamfer_thickness = .6;

  bottom_peg_diameter = 4;
  bottom_peg_height =  3;
  bottom_peg_chamfer = 1;
  bottom_peg_side_scale = 1.7/4;

  translate([-bottom_size/2, -bottom_size/2 ,0])cube([bottom_size,bottom_size,bottom_height]);

  translate([0,0, -(bottom_peg_height -bottom_peg_chamfer)]){
    cylinder(d=bottom_peg_diameter, h= bottom_peg_height -bottom_peg_chamfer);
    translate([5,0,0])scale(v=[bottom_peg_side_scale,bottom_peg_side_scale,1])cylinder(d=bottom_peg_diameter, h= bottom_peg_height -bottom_peg_chamfer);
    translate([-5,0,0])scale(v=[bottom_peg_side_scale,bottom_peg_side_scale,1])cylinder(d=bottom_peg_diameter, h= bottom_peg_height -bottom_peg_chamfer);

    translate([0,0, -bottom_peg_chamfer]){
      cylinder(d2=bottom_peg_diameter , d1 = bottom_peg_diameter -2*bottom_peg_chamfer, h= bottom_peg_chamfer);
      translate([5,0,0])scale(v=[bottom_peg_side_scale,bottom_peg_side_scale,1])cylinder(d2=bottom_peg_diameter , d1 = bottom_peg_diameter -2*bottom_peg_chamfer, h= bottom_peg_chamfer);
      translate([-5,0,0])scale(v=[bottom_peg_side_scale,bottom_peg_side_scale,1])cylinder(d2=bottom_peg_diameter , d1 = bottom_peg_diameter -2*bottom_peg_chamfer, h= bottom_peg_chamfer);
    }
  }
}

//MX series keyhole
// TODO: add alps support?
module Keyhole(tol = .1, cutThickness = .5, clipLength = 0)
{
  $fn = 10;
  bottom_length = 13.9+tol;
   plate_thickness = 3.51; //mm
  holeLength = bottom_length+tol*2;
  //latch nibs
  nib_radius= 1;
  nib_length = 3;

  translate([0,0,-1.25])difference(){
    union(){
      translate([0,0,1.25])cube([holeLength, holeLength, plate_thickness+tol], center =true);
//      translate([0,0,.25-cutThickness/2])cube([holeLength+1, holeLength+1, plate_thickness+cutThickness], center =true);  
    }
    
    union(){
      if (clipLength != 0){
        translate([0, -sign(clipLength)*7.8-clipLength, 0])cube([20, 15.6, 40], center = true);
      }
    }
  }
}

module Stabilizer(offsets = 23.8/2)
{
  plate_thickness = 3.6; //mm
  stabilizer_width = 5;
  stabilizer_length = 12.2;
  translate([offsets,0,0])cube([stabilizer_width,stabilizer_length,plate_thickness], center = true);
  translate([-offsets,0,0])cube([stabilizer_width,stabilizer_length,plate_thickness], center = true);
}

module TrackPoint(nibLength = 20)
{
  color("red")translate([0,0,-.5])cube([4.5,4.5,5], center= true); //nib
  color("gold")cylinder(d = 2, nibLength); //nib
  color("gold")translate([0,0,nibLength])sphere(2); //nib
  translate([0,30.3/2-8,-3/2])cube([26.46, 30.3, 3], center = true);
}

module RotaryEncoder(stemLength = 13, Wheel = 0)
{
 color("grey")translate([0,0, -6.1/2])cube([11.5, 13.5, 6.1], center = true);
 cylinder(d = 7, 7.8);

 translate([0,0,7.8])difference(){
   cylinder(d = 5.8, stemLength);
   translate([-5.8/2,5.8/2-1.5,3])cube([11.5, 13.5, stemLength]);
 }
 color("grey")translate([0,0,7.8])cylinder(d = Wheel, stemLength);
}

//################ Test Calls ###################
//Switch(clipLength = -4);
Keyhole(.1, clipLength = -4);
//Stabilizer(20);
// RotaryEncoder(Wheel = 0);
//Switch([1,1.5,1]);
//TrackPoint();
