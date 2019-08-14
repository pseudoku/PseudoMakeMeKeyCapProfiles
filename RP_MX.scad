use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  

//DP (Distored Pyramidal) [Double Penetration] Profile  

//TODO add shift 
keycap(keyID = 9, cutLen = 0, Stem =true,  Dish = true, visualizeDish = true, crossSection = false, homeDot = false, Legends = false);
////fullsetee
RowHome = [0,2.5,5,2.5,0,0];

//for(Col = [4:4]){ 
//  for(Row = [1:3]){
//  translate([19*Col, 19*Row +RowHome[Col], 0])keycap(keyID = Col*4+Row, cutLen = 0, Stem = true,  Dish = true, visualizeDish = false, crossSection = true);
//  }
//}

////// thumb
//  translate([-15, -4, 0])rotate([0,0,30])keycap(keyID = 0, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([10, 0, 0])rotate([0,0,15])keycap(keyID = 4, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([31, 2.2, 0])rotate([0,0,0])keycap(keyID = 8, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);

//Parameters
wallthickness = 1.75;
topthickness = 2.5;
stepsize = 30;  //resolution of Trajectory
step = 4;       //resolution of ellipes 
fn = 32;          //resolution of Rounded Rectangles: 60 for output
layers = 30;    //resolution of vertical Sweep: 50 for output

//---Stem param
slop    = 0.3;
stemRot = 0;
stemWid = 7.2;
stemLen = 5.5;
stemCrossHeight = 4;
extra_vertical = 0.6;
stemLayers = 50; //resolution of stem to cap top transition

dishLayers = 30;

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//Column 0
    [17.16,  17.16*1.5, 6, 	   6,   14,    0,    0,   -13,   -10,    -5,   2,   2,      1,      5,      1,      3,     2,       2], //R5 0
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,    10,   -10,    -5,   2,   2,      1,      5,      1,      3,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  7+4,    0,    0,    -2,   -10,    -5,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,   -10,   -10,    -5,   2,   2,      1,      5,      1,      3,     2,       2], //R2
//Column 1
    [17.16,  17.16,     6, 	   6,   13,    0,    0,   -13,     5,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 4
    [17.16,  17.16,   6.5, 	 6.5,  8+3,    0,    0,     5,    -3,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,7+2.5,    0,    0,    -2,    -3,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  8+3,    0,    0,   -12,    -3,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R2
//Column 2 middle
    [17.16,  17.16,     6, 	   6,   13,    0,    0,   -13,    10,    15,   2,   2,      1,      5,      1,      3,     2,       2], //R5 8
    [17.16,  17.16,   6.5, 	 6.5,  7.1,    0,    0,     0,     0,     0,   2,   2,      1,   4.85,      1,      3,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,    7,    0,    0,    -2,     0,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,    8,    0,    0,   -12,     0,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R2
//Column 3
    [17.16,  17.16,     6, 	   6, 11+3,    0,    0,    13,    -4,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 12
    [17.16,  17.16,   6.5, 	 6.5,  8+3,    0,    0,     5,    -4,     0,   2,   2,      1,      5,      1,      5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  7+3,    0,    0,    -2,    -4,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  8+3,    0,    0,   -10,    -4,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R2
//Column 4
    [17.16,  17.16,     6, 	   6,11+5.5,   0,    0,    13,   -10,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 16
    [17.16,  17.16,   6.5, 	 6.5,8+5.5,    0,    0,     5,   -10,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,7+5.5,    0,    0,    -5,   -10,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,   -12,     5,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R2
//Column 5
    [17.16,  17.16,     6, 	   6, 11+4,    0,    0,    13,    -6,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 20
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,     5,    -6,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  7+4,    0,    0,    -2,    -6,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  8+6,    0,    0,   -12,    10,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R2
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
function CapRound0i(keyID)   = keyParameters[keyID][12];
function CapRound0f(keyID)   = keyParameters[keyID][13];
function CapRound1i(keyID)   = keyParameters[keyID][14];
function CapRound1f(keyID)   = keyParameters[keyID][15];
function ChamExponent(keyID) = keyParameters[keyID][16];
function StemExponent(keyID) = keyParameters[keyID][17];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
// EdOf    fn   LEx   WEx  DshDep     Ch0i, ch1i, Ch0f, Ch1f, DishExp
  //Column 0
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R3
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
  //Column 1
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R3
  [   1,  .005,    2,    2,    2,        6,    4, .3, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
  //Column 2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.7,   4.85,    3, .001, .001,  2], //R3 DSA
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
  //Column 3
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R3
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
  //Column 4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R3
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
  //Column 5
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R2
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R3
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R4
  [   2,  .005,    2,    2,    1.5,      6,    4, .001, .001,  2], //R5
];

function EdgeOffset(keyID) = dishParameters[keyID][0];  //
function LenFinal(keyID)   = dishParameters[keyID][1];  // 
function LenExpo(keyID)    = dishParameters[keyID][2];  //
function WidExpo(keyID)    = dishParameters[keyID][3];  //
function DishDepth(keyID)  = dishParameters[keyID][4];  //
function DishCham0i(keyID) = dishParameters[keyID][5];  //
function DishCham1i(keyID) = dishParameters[keyID][6];  //
function DishCham0f(keyID) = dishParameters[keyID][7];  //
function DishCham1f(keyID) = dishParameters[keyID][8];  //
function DishExpo(keyID)   = dishParameters[keyID][9];


//function FrontTrajectory(keyID) = 
//  [
//    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
//    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
//  ];
//
//function BackTrajectory (keyID) = 
//  [
//    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID)),
//    trajectory(forward = BackForward2(keyID), pitch =  BackPitch2(keyID)),
//  ];

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
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID) ,
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
function CapRoundness(t, keyID) = 
  [
    pow(t/layers, ChamExponent(keyID))*(CapRound0f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound0i(keyID),
    pow(t/layers, ChamExponent(keyID))*(CapRound1f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound1i(keyID)
  ];
  
function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  
function StemTranslation(t, keyID) =
  [
    ((1-t)/stemLayers*TopWidShift(keyID)),   //X shift
    ((1-t)/stemLayers*TopLenShift(keyID)),   //Y shift
    stemCrossHeight+.1 + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1))    //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((1-t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((1-t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;

//----- Distorted Pyramidal Dish

function DishTranslation(t, keyID) =
  [
    ((t)/dishLayers*TopWidShift(keyID)),   //X shift
    ((t)/dishLayers*TopLenShift(keyID)),   //Y shift
    KeyHeight(keyID)-(t)/dishLayers*(DishDepth(keyID))    //Z shift
  ];

function DishRotation(t, keyID) =
  [
    (-XAngleSkew(keyID)),   //X shift
    (-YAngleSkew(keyID)),   //Y shift
    (-ZAngleSkew(keyID))    //Z shift
  ];

function DishTransform(t, keyID) =
  [
    (1-pow(t/dishLayers, WidExpo(keyID)))*(BottomWidth(keyID) -TopWidthDiff(keyID)+EdgeOffset(keyID)) + (pow(t/dishLayers, WidExpo(keyID)))*(LenFinal(keyID)),
    (1-pow(t/dishLayers, LenExpo(keyID)))*(BottomLength(keyID)-TopLenDiff(keyID)+EdgeOffset(keyID)) + (pow(t/dishLayers, LenExpo(keyID)))*(LenFinal(keyID))
  ];

function DishRoundness(t, keyID) = 
  [
    pow(t/dishLayers, DishExpo(keyID))*(DishCham0f(keyID)) + (1-pow(t/dishLayers, DishExpo(keyID)))*DishCham0i(keyID),
    pow(t/dishLayers, DishExpo(keyID))*(DishCham1f(keyID)) + (1-pow(t/dishLayers, DishExpo(keyID)))*DishCham1i(keyID)
  ];

///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, homeDot = false, Stab = false) {
  
//  //Set Parameters for dish shape
//  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
//  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
//  
//  //Scaling initial and final dim tranformation by exponents
//  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
//  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 
//
//  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), 1, d = 0)) ];  
//  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i), 1, d = 0)) ];
  
  //builds
  difference(){
    union(){
      difference(){
        skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        
        //Cut inner shell
        if(Stem == true){ 
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
        }
      }
      if(Stem == true){
        rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop); // generate mx cherry stem, not compatible with box
        if (Stab != 0){
          translate([Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
          translate([-Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
          //TODO add binding support?
        }
        translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), rounded_rectangle_profile(StemTransform(i, keyID),fn=fn,r=StemRadius(i, keyID)))]); //Transition Support for taller profile
      }
    //cut for fonts and extra pattern for light?
    }
    
    //Cuts
    
    //Fonts
    if(Legends ==  true){
      //    #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,4,KeyHeight(keyID)-2.5])linear_extrude(height = 0.5)text( text = "Why?", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
      
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
        skin([for (i=[0:dishLayers]) transform(translation(DishTranslation(i, keyID)) * rotation(DishRotation(i, keyID)), 
          elliptical_rectangle(DishTransform(i, keyID), b = DishRoundness(i,keyID),fn=fn)
        )]);
     } else {
        #skin([for (i=[0:dishLayers]) transform(translation(DishTranslation(i, keyID)) * rotation(DishRotation(i, keyID)),           
          elliptical_rectangle(DishTransform(i, keyID), b = DishRoundness(i,keyID),fn=fn)
        )]);
     } 
   }
     if(crossSection == true) {
       translate([0,-15,-.1])cube([15,30,15]); 
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishDepth(keyID)-.1])sphere(d = 1);
}

//------------------stems 
$fn = fn;

function outer_cherry_stem(slop) = [ stemWid - slop * 2, stemLen - slop * 2];
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
    linear_extrude(height = stemCrossHeight) {
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
    linear_extrude(height = depth-topthickness/2) {
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

function elliptical_rectangle(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])), 0]
    - [b[1]*cos(atan(a[1]/b[1])), 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta3 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta3), a[1]*sin(theta3)]
    - [a[0]*cos(atan(b[0]/a[0])), 0]
    + [b[1]*cos(atan(a[1]/b[1])), 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta4 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta4), b[0]*sin(theta4)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;
    
function sign_x(i,n) = 
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) = 
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;
