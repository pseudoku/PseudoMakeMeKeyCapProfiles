use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  

//TODO add shift 
keycap(keyID = 7, cutLen = 0, Stem =true,  Dish = true, visualizeDish = true, crossSection = false, homeDot = false);
////fullset
//for(Row = [0:4]){ 
//  for(Col = [0:5]){
//  translate([20*Col, 20*Row, 0])keycap(keyID = Col*5+Row, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  }
//}

//Parameters
wallthickness = 1.75;
topthickness = 2.25;
stepsize = 50;  //resolution of Trajectory
step = 2;       //resolution of ellipes 
fn = 60;          //resolution of Rounded Rectangles: 60 for output
layers = 50;    //resolution of vertical Sweep: 50 for output 

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapRIn, CapRFn, CapREx
//Column 0
    [18.16,  18.16,     6, 	   6,   10,    0,    0,   -13,    -5,   -12,   2,   2,     .2,      3,     1], //R5
    [18.16,  18.16,     6, 	   6,  8+4,    0,    0,     5,   -10,    10,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,  7+4,    0,    0,    -2,   -10,     5,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,  8+4,    0,    0,    -7,   -10,    -5,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6, 11+4,    0,    0,   -13,   -10,   -10,   2,   2,     .2,      3,     1], //R1 4
//Column 1
    [18.16,  18.16,     6, 	   6,   10,    0,    0,   -13,     5,    12,   2,   2,     .2,      3,     1], //R5 
    [18.16,  18.16,     6, 	   6,  8+2,    0,    0,     5,    -3,     0,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,  7+2,    0,    0,    -2,    -3,     0,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,  8+2,    0,    0,    -7,    -3,     0,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6, 11+2,    0,    0,   -13,    -3,     0,   2,   2,     .2,      3,     1], //R1 9
//Column 2 middle
    [18.16,  18.16,     6, 	   6,   12,    0,    0,   -13,    10,    15,   2,   2,     .2,      3,     1], //R5
    [18.16,  18.16,     6, 	   6,    8,    0,    0,     5,     0,     0,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,    7,    0,    0,    -2,     0,     0,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,    8,    0,    0,    -7,     0,     0,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6,   11,    0,    0,   -13,     0,     0,   2,   2,     .2,      3,     1], //R1
//Column 3
    [18.16,  18.16,     6, 	   6, 11+3,    0,    0,    13,    -4,     0,   2,   2,     .2,      3,     1], //R5
    [18.16,  18.16,     6, 	   6,  8+3,    0,    0,     5,    -4,     0,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,  7+3,    0,    0,    -2,    -4,     0,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,  8+3,    0,    0,    -7,    -4,     0,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6, 11+3,    0,    0,   -13,    -4,     0,   2,   2,     .2,      3,     1], //R1
//Column 4
    [18.16,  18.16,     6, 	   6,11+5.5,    0,    0,    13,   -10,     0,   2,   2,     .2,      3,     1], //R5
    [18.16,  18.16,     6, 	   6,8+5.5,    0,    0,     5,   -10,     0,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,7+5.5,    0,    0,    -2,   -10,     0,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,8+5.5,    0,    0,    -7,   -10,     0,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6, 11+3,    0,    0,   -13,    10,     0,   2,   2,     .2,      3,     1], //R1
//Column 5
    [18.16,  18.16,     6, 	   6, 11+4,    0,    0,    13,    -6,     0,   2,   2,     .2,      3,     1], //R5
    [18.16,  18.16,     6, 	   6,  8+4,    0,    0,     5,    -6,     0,   2,   2,     .2,      3,     1], //R4
    [18.16,  18.16,     6, 	   6,  7+4,    0,    0,    -2,    -6,     0,   2,   2,     .2,      3,     1], //R3 Home
    [18.16,  18.16,     6, 	   6,  8+4,    0,    0,    -7,    -6,     0,   2,   2,     .2,      3,     1], //R2
    [18.16,  18.16,     6, 	   6, 11+5,    0,    0,   -13,    10,     0,   2,   2,     .2,      3,     1], //R1
];

function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  // 
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4];  //
function TopWidShift(keyID)  = keyParameters[keyID][5];
function TopLenShift(keyID)  = keyParameters[keyID][6];
function XAngleSkew(keyID)   = keyParameters[keyID][7];
function YAngleSkew(keyID)   = keyParameters[keyID][8];
function ZAngleSkew(keyID)   = keyParameters[keyID][9];
function WidExponent(keyID)  = keyParameters[keyID][10];
function LenExponent(keyID)  = keyParameters[keyID][11];
function ChamfInitRad(keyID) = keyParameters[keyID][12];
function ChamfFinRad(keyID)  = keyParameters[keyID][13];
function ChamExponent(keyID) = keyParameters[keyID][14];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  //Column 0
  [   5,    3,  5.8,  -42,    3.5,    1.5,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    18,     2], //R5
  [   6,    3,   15,  -50,    3.5,    1.5,   8.5,    19,     2,        5,    4,   13,  -50,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      4,    1.7,   8.5,    15,     2,        5,    4,   13,  -30,    8.5,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.6,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.7,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    18,     2], //R1
  //Column 1
  [   5,  3.5,    5,  -48,    3.5,    1.5,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      5,    1.7,     9,    15,     2,        5,    4,   13,  -30,      9,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R1
  //Column 2
  [   5,  3.5,    5,  -48,    3.5,    1.7,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    18,     2], //R5
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      5,    1.7,   8.5,    15,     2,        5,    4,   13,  -30,    8.5,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R1
  //Column 3
  [   5,    3,    5,  -50,    3.5,    1.5,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [   6,    3,   18,  -50,    3.5,    1.6,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      4,    1.6,   8.5,    15,     2,        5,    4,   13,  -30,    8.5,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R1
  //Column 4
  [   5,    3,    5,  -50,    3.5,    1.6,   8.6,    12,     2,        6,    4,   13,  -30,    8.6,    16,     2], //R5
  [   6,    3,   18,  -50,    3.5,    1.6,   8.5,    17,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      4,    1.7,   8.5,    15,     2,        5,    4,   13,  -30,    8.5,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.6,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.6,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R1
  //Column 5
  [   5,    3,    5,  -50,    3.5,    1.5,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R4
  [   6,    3,   18,  -50,      5,    1.7,   8.5,    15,     2,        5,    4,   13,  -30,    8.5,    16,     2], //R3
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R2
  [   6,    3,   18,  -50,    3.5,    1.5,   8.5,    15,     2,        6,    4,   13,  -30,    8.5,    16,     2] //R1
];

 
function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  // 
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepth(keyID)     = dishParameters[keyID][4];  //
function DishHeightDif(keyID) = dishParameters[keyID][5];  //
function FrontInitArc(keyID)  = dishParameters[keyID][6];
function FrontFinArc(keyID)   = dishParameters[keyID][7];
function FrontArcExpo(keyID)  = dishParameters[keyID][8];
function BackForward1(keyID)  = dishParameters[keyID][9];  //
function BackForward2(keyID)  = dishParameters[keyID][10];  // 
function BackPitch1(keyID)    = dishParameters[keyID][11];  //
function BackPitch2(keyID)    = dishParameters[keyID][12];  //
function BackInitArc(keyID)   = dishParameters[keyID][13];
function BackFinArc(keyID)    = dishParameters[keyID][14];
function BackArcExpo(keyID)   = dishParameters[keyID][15];


function FrontTrajectory(keyID) = 
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID)),
    trajectory(forward = BackForward2(keyID), pitch =  BackPitch2(keyID)),
  ];

//------- function defining Dish Shapes

function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (t = [rot1:step:rot2]) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b,c,d) = 
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0,rot1 = 90, rot2 = 270)
//   [[c+a,-b]]
  );

function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , // 
 b*sin(phi),
]; 
  
path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];


//--------------Function definng Cap 
function CapTranslation(t, keyID) = 
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

function InnerTranslation(t, keyID) =
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*(KeyHeight(keyID)-topthickness))    //Z shift
  ];

function CapRotation(t, keyID) =
  [
    ((1-t)/layers*XAngleSkew(keyID)),   //X shift
    ((1-t)/layers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/layers*ZAngleSkew(keyID))    //Z shift
  ];

function CapTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID) ,
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
  
function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  
function CapRadius(t, keyID) =  pow(t/layers, keyParameters[keyID][14])*keyParameters[keyID][13] + (1-pow(t/layers, keyParameters[keyID][14]))*keyParameters[keyID][12];


///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, homeDot = false) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), 1, d = 0)) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i),  1, d = 0)) ];
  
  difference(){
    union(){
      difference(){
        skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), rounded_rectangle_profile(CapTransform(i, keyID),fn=fn,r=CapRadius(i, keyID)))]);
        
        //Cut inner
        if(Stem == true){
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), rounded_rectangle_profile(InnerTransform(i, keyID),fn=fn,r=CapRadius(i, keyID)))]);
        }
      }
      if(Stem == true)rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);

    //cut for fonts and extra pattern for light?
    }
    
    //Cuts
    //Fonts
//    #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,4,KeyHeight(keyID)-2.5])linear_extrude(height = 0.5)text( text = "Why?", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
  //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
      translate([0,.00001,KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } else {
      #translate([0,.00001,KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } 
   }
     if(crossSection == true) {
       translate([0,-15,-.1])cube([15,30,15]); 
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = 1);
}

//------------------stems 
$fn = 32;
slop = 0.3;
stemRot = 0;
extra_vertical = 0.6;
function outer_cherry_stem(slop) = [7.2 - slop * 2, 5.5 - slop * 2];
function outer_cherry_stabilizer_stem(slop) = [4.85 - slop * 2, 6.05 - slop * 2];
function outer_box_cherry_stem(slop) = [6 - slop, 6 - slop];

// .005 purely for aesthetics, to get rid of that ugly crosshatch
function cherry_cross(slop, extra_vertical = 0) = [
  // horizontal tine
  [4.03 + slop, 1.15 + slop / 3],
  // vertical tine
  [1.25 + slop / 3, 4.23 + extra_vertical + slop / 3 + .005],
];
module inside_cherry_cross(slop) {
  // inside cross
  // translation purely for aesthetic purposes, to get rid of that awful lattice
  translate([0,0,-0.005]) {
    linear_extrude(height = 4) {
      square(cherry_cross(slop, extra_vertical)[0], center=true);
      square(cherry_cross(slop, extra_vertical)[1], center=true);
    }
  }

  // Guides to assist insertion and mitigate first layer squishing
  {
    for (i = cherry_cross(slop, extra_vertical)) hull() {
      linear_extrude(height = 0.01, center = false) offset(delta = 0.4) square(i, center=true);
      translate([0, 0, 0.5]) linear_extrude(height = 0.01, center = false)  square(i, center=true);
    }
  }
}

module cherry_stem(depth, slop) {
  difference(){
    // outside shape
    linear_extrude(height = depth) {
      offset(r=1){
        square(outer_cherry_stem(slop) - [2,2], center=true);
      }
    }
    inside_cherry_cross(slop);
  }
}


/// ----- helper functions 
function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360) 
			r * [cos(a), sin(a)] 
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];

function sign_x(i,n) = 
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) = 
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;
