use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
//use <z-butt.scad>

//NOTE: with sweep cuts, top surface may not be visible in review, it should be visible once rendered

mirror([0,0,0])keycap(
  keyID  = 1, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  StemRot = 0,//change stem orientation by deg
  Dish   = true, //turn on dish cut
  Stab   = 0, 
  visualizeDish = false, // turn on debug visual of Dish 
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
); 

//Parameters
wallthickness = 1.2;   
topthickness  = 2;   //
stepsize      = 50;  //resolution of Trajectory
step          = 1;   //resolution of ellipes 
fn            = 32;  //resolution of Rounded Rectangles: 60 for output
layers        = 40;  //resolution of vertical Sweep: 50 for output
dotRadius     = 1.25;   //home dot size
//---Stem param
slop    = 0.25;
stemWid = 8;
stemLen = 6;
stemCrossHeight = 1.8;
extra_vertical  = 0.6;
StemBrimDep     = 0; 
stemLayers      = 50; //resolution of stem to cap top transition
driftAngle      = 0;

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
    //Column 0    
    //Levee: Chicago in choc Dimension 
    [17.20,  16.00,   5.6, 	   5,  3.8,    0,  -.5,     7,    -0,    -0,   2, 2,    .10,      3,     .10,      3,     2,       2], //Chicago Steno R2x 1u
    [17.20,  16.00,   5.6, 	   5,  4.4,    0,   .0,     0,    -0,    -0,   2, 2,    .10,      3,     .10,      3,     2,       2], //Chicago Steno R3x 1u
    [35.85,  15.65,     7, 	   7,  4.4,    0,   .0,     0,    -0,    -0,   2, 2,    .30,      5,     .30,      5,     2,       2], //Chicago Steno R3x 1.5u 
    [35.85,  15.65,     7, 	   7,  4.4,    0,   .0,     0,    -0,    -0,   2, 2,    .30,      5,     .30,      5,     2,       2], //Chicago Steno R3x 2u 
    //mods 3
    
    [17.20,  16.00,  4.25, 	3.25,  5.5,  -.7,  0.7,     0,    -4,    -0,   2,   2,    .10,      2,     .10,      2,     2,       2], //Levee Corner R2
    [17.20,  16.00,  4.25, 	3.25,  5.2,  -.8,  0.6,     0,    -4,    -0,   2,   3,    .10,      2,     .10,      2,     2,       2], //Levee Corner R2
    //1.25 5
    [21.3,   15.60,  5.6, 	   5,  4.5,    0,   .0,     5,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R2/R4 1.25u
    [21.4,   15.60,  5.6, 	   5,  4.5,    0,   .0,     0,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R3 1.25u
    //1.5 7
    [26.15,  15.60,   5.6, 	   5,  4.5,    0,   .0,     5,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R2/R4 1.5
    [26.15,  15.60,   5.6, 	   5,  4.5,    0,   .0,     0,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R3 1.5u
    //1.75 9
    [30.90,  15.60,   5.6, 	   5,  4.5,    0,   .0,     5,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R2/R4 1.5
    [30.90,  15.60,   5.6, 	   5,  4.5,    0,   .0,     0,    -0,    -0,   2,   2,     .5,      3,      .5,      3,     2,       2], //Chicago Steno R3 1.5u
    // Ergo shits
    [18.75,  18.75,   5.6, 	   5,    8,    0,   .25,     0,    -0,    -0,   2, 2.5,    .10,      3,     .10,      3,     2,       2], //highpro 19.05 R2|4 
    [17.20,  16.00,   5.6, 	   5,  4.7,    0,   .0,      3,    -0,    -0,   2, 2.5,    .10,      2,     .10,      3,     2,       2], //Chicago Steno R2 ALT
    [17.20,  16.00,   5.6, 	   5,  5.5,    0,   .0,      7,    -0,    -0,   2, 2.5,    .10,      2,     .10,      3,     2,       2], //Chicago Steno R1 Steap
    [17.20,  16.00,   5.6, 	   5,  7.0,    0,   .0,     10,    -0,    -0,   2, 2.5,    .10,      2,     .10,      3,     2,       2], //Chicago Steno R1 mild with alt R2
];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDepi DishDepf,DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  [   5,  2.3,    2,  -55,    1.5,   3.75,   8.5,    8.5,    2,       5,    3,    2,  -50,    8.5,    8.7 ,     2], //R2x 1u
  [ 4.5,  3.3,   -3,  -45,    1.5,   3.75,   8.5,   8.7,     2,     4.5,  3.3,   -3,  -45,    8.5,   8.7,     2], //R3x 1u
  [ 4.5,  3.2,   -5,  -45,    1.5,   3.75,  19.0,    18,     2,     4.5,  3.2,   -5,  -45,   19.0,    18,     2], //R3x 2u
  [ 4.5,  3.2,   -5,  -45,    1.5,   3.75,  19.0,    18,     2,     4.5,  3.2,   -5,  -45,   19.0,    18,     2], //R3x 2u
  [   4,  4.2,   -5,  -15,      1,      3,  18.2,    21,     2,       5,    3,   -5,  -15,   18.2,    21,     2], //R3 2u
  [  4.,  1.5,    8,  -55,      3,      7,   9.0,     9,     2,       4,    3,    3,  -50,    9,     9,     2],  //R3
  [  4.,  1.5,   -0,  -50,      3,      7,   9.0,     9,     2,       4,    3,    -10,  -50,    9,     9,     2],  //R3
  [   5,  3.5,    8,  -50,      5,    1.8,   8.8,    15,     2,       6,    4,   13,   30,    8.8,    16,     2], //R1
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
   [[c+a,-b]],
    ellipse(a, b, d = 0,rot1 = 270, rot2 =450),
   [[c+a,b]]
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
  
function CapRadius(t, keyID) = pow(t/layers, ChamExponent(keyID))*ChamfFinRad(keyID) + (1-pow(t/layers, ChamExponent(keyID)))*ChamfInitRad(keyID);

function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  
function StemTranslation(t, keyID) =
  [
    ((1-t)/stemLayers*TopWidShift(keyID)),   //X shift
    ((1-t)/stemLayers*TopLenShift(keyID)),   //Y shift
     stemCrossHeight+.1 + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1))   //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((1-t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((1-t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent 


///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, csrossSection = false, Dish = true, Stem = false,StemRot = 0, homeDot = false, Stab = 0) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), DishDepth(keyID)+1.5, d = 0)) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i), DishDepth(keyID)+1.5, d = 0)) ];
  
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
        translate([0,0,StemBrimDep])rotate([0,0,StemRot])choc_stem();
        if (Stab != 0){
//          translate([Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
//          translate([-Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
          //TODO add binding support?
        }
        rotate([0,0,StemRot])translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), rounded_rectangle_profile(StemTransform(i, keyID),fn=fn,r=StemRadius(i, keyID)))]); //Transition Support for taller profile
      }
    //cut for fonts and extra pattern for light?
    }
    
    //Cuts
    
    //Fonts
    if(Legends ==  true){
          #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-1,-5,KeyHeight(keyID)-2.5])linear_extrude(height = 1)text( text = "ver2", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
      translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } else {
      #translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)]) rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } 
   }
     if(crossSection == true) {
       translate([0,-15,-.1])cube([15,30,15]); 
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = dotRadius);
}

//------------------stems 
$fn = fn;

module choc_stem(draftAng = 5) {
  stemHeight = 3.1;
  dia = .15;
  wids = 1.2/2;
  lens = 2.9/2; 
  module Stem() {
    difference(){
      translate([0,0,-stemHeight/2])linear_extrude(height = stemHeight)hull(){
        translate([wids-dia,-3/2])circle(d=dia);
        translate([-wids+dia,-3/2])circle(d=dia);
        translate([wids-dia, 3/2])circle(d=dia);
        translate([-wids+dia, 3/2])circle(d=dia);
      }

    //cuts
      translate([3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight, d2=7,3.5, center = true, $fn = 64);
      translate([-3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight,d2=7,3.5, center = true, $fn = 64);
    }
  }

  translate([5.7/2,0,-stemHeight/2+2])Stem();
  translate([-5.7/2,0,-stemHeight/2+2])Stem();
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
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
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

//lp_key = [
////     "base_sx", 18.5,
////     "base_sy", 18.5,
//     "base_sx", 17.65,
//     "base_sy", 16.5,
//     "cavity_sx", 16.1,
//     "cavity_sy", 14.9,
//     "cavity_sz", 1.6,
//     "cavity_ch_xy", 1.6,
//     "indent_inset", 1.5
//     ];
//Choc Chord version Chicago Stenographer
//#square([18.16, 18.16], center = true);
//translate([0,19,0])keycap(keyID = 1, cutLen = 0, Stem =false,  Dish = true, Stab = 0 , visualizeDish = true, crossSection = false, homeDot = false, Legends = false);
//translate([0,0,0])lp_master_base(xu = 2, yu = 1 );  
//stem_cavity_negative(lp_key, x=1, y=1);
//}
//#translate([0,0,0])cube([14.5, 13.5, 10], center = true); // internal check
//#translate([0,0,0])cube([17.5, 16.5, 10], center = true); // external check
//translate([0,17,0])mirror([0,1,0])keycap(keyID = 0, cutLen = 0, Stem =false,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([18,0,0])mirror([0,0,0])keycap(keyID = 0, cutLen = 0, Stem =false,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//n translate([0,19, 0])keycap(keyID = 3, cutLen = 0, Stem =true,  Dish = true, visualizeDish = true, crossSection = true, homeDot = false, Legends = false);
// translate([0,38, 0])mirror([0,1,0])keycap(keyID = 2, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = true, homeDot = false, Legends = false);
