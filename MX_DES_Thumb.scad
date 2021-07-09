use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  

/*DES (Distorted Elliptical Saddle) Sculpted Profile for 6x3 and corne thumb 
Version 2: Eliptical Rectangle

*/
mirror([0,0,0])keycap(
  keyID  = 3, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  Dish   = true, //turn on dish cut
  Stab   = 0, 
  visualizeDish = false, // turn on debug visual of Dish 
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
 );
 
/*corne thumb hi pro*/
//color("royalblue")translate([-0,33,0]){
//  translate([-15, -4, 0])rotate([0,0,30])mirror([1,0,0])keycap(keyID = 0, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([6, 0, 0])rotate([0,0,15])keycap(keyID = 1, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([26, 2.2, 0])rotate([0,0,0])keycap(keyID = 2, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//}
/*corne thumb low pro*/
//color("gray"){
//  translate([-15, -4, 0])rotate([0,0,30])keycap(keyID =3, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([6, 0, 0])rotate([0,0,15])keycap(keyID = 6, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([26, 2.2, 0])rotate([0,0,0])keycap(keyID = 7, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = false);
//}

/*kyria Thumb*/
//// translate([-39, 0, 0])rotate([0,0,30])translate([0,-19.5, 0])keycap(keyID = 15 , cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([-39, 0, 0])rotate([0,0,30])translate([0,-19.5, 0])keycap(keyID = 13, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([-39, 0, 0])rotate([0,0,30])translate([0,0, 0])keycap(keyID = 14, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//// translate([-39, 0, 0])rotate([0,0,30])translate([0, -1, 0])keycap(keyID = 13, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// //  translate([-17, 0, 0])rotate([0,0,30])translate([0, 1 , 0])keycap(keyID = 12, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([-17, 0, 0])rotate([0,0,30])translate([0,-8.5, 0])mirror([1,0,0])keycap(keyID = 16, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([-17, 0, 0])rotate([0,0,30])translate([0, 10, 0])mirror([1,0,0])keycap(keyID = 17, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([6, 0, 0])rotate([0,0,15])keycap(keyID = 18, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
// translate([26, 2.2, 0])rotate([0,0,0])keycap(keyID = 19, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);


//#translate([0,38,13])cube([18-5.7, 18-5.7,1],center = true);
//echo(len(keyParameters));
//Parameters
wallthickness = 2; // 1.5 for norm, 1.25 for cast master
topthickness  = 2.5;   // 3 for norm, 2.5 for cast master
stepsize      = 50;  //resolution of Trajectory
step          = 6;   //resolution of ellipes 
fn            = 16;  //resolution of Rounded Rectangles: 60 for output
layers        = 40;  //resolution of vertical Sweep: 50 for output
dotRadius     = 1.25;   //home dot size
//---Stem param
Tol    = 0.10;
stemRot = 0;
stemWid = 7.2;
stemLen = 5.5;
stemCrossHeight = 4;
extra_vertical  = 0.6;
StemBrimDep     = 0.25; 
stemLayers      = 50; //resolution of stem to cap top transition

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//corne thumb high pro
    [17.16,  26.66,     6, 	   7,   12,    0,    0,   -0,    10,    -5,   2,   2,      1,   4.85,      1,      3,     2,       2], //R5 1.5 Corne thumb
    [17.16,  17.16,     4, 	   5,   11,    0,    0,   -0,     5,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5  corne thumb
    [17.16,  17.16,     4, 	   6,   13,    0,    0,   -0,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //R5  corne thumb
//Low profile corne thumb
    [17.16,  26.66,     6, 	   7, 9.0,    0,    0,    -8,    10,    -5,   2,   2,      1,   4.85,      1,      3,     2,       2], //T1R5  external rot 3
    [17.16,  26.66,     6, 	   7, 9.0,    0,    0,    -8,    10,    -0,   2,   2,      1,   4.85,      1,      3,     2,       2], //T1R5  nuetral 
    [17.16,  26.66,     6, 	   7, 9.0,    0,    0,    -8,    10,     5,   2,   2,      1,   4.85,      1,      3,     2,       2], //T1R5  internal rot Corne thumb
    [17.16,  17.16,     4, 	   5, 10.,    0,    0,   -12,     5,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5  corne thumb
    [17.16,  17.16,     4, 	   6,  11,    0,    0,   -12,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //R5  corne thumb
//Column high sculpt 3 row system
    [17.16,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 8
    [17.16,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [17.16,  17.16,   6.5, 	 6.5, 8.75,    0,    0,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 deepdish
 //kyria Thumbs   13 ~ 19
    [17.16,  35.56,     4, 	   7, 13.5,    0,    0,    -8,     5,     0,   2,   2,      1,     6.,      1,    3.5,     2,       2], //T0R1 2u
    [17.16,  17.16,     6, 	   5,   11,  -.5,    0,    -9,     7,    10,   2,   2,      1,      5,      1,      3,     2,       2], //T0R1 1u
    [17.16,  17.16,     6, 	   5,   13,  -.5,    0,    -9,     7,     5,   2,   2,      1,      5,      1,    3.5,     2,       2], //T0R2 1u
    [17.16,  35.56,     6, 	   7,   11,    0,    0,    -8,    10,    -5,   2,   2,      1,   4.85,      1,    3.5,     2,       2], //T1R1 2u
    [17.16,  17.16,     4, 	   6,   12,   .5,    0,   -13,    -7,    10,   2,   2,      1,      5,      1,      2,     2,       2], //T1R1 1u
    [17.16,  17.16,     6, 	   5,   15,  -.5,    0,    -9,    -7,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //T1R2 1u
    [17.16,  17.16,     4, 	   6,   13,   .5,    0,   -13,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //T2R1 
    [17.16,  17.16,     4, 	   6,   13,    0,    0,    -8,    10,    20,   2,   2,      1,      5,      1,      2,     2,       2], //T3R1 

//lowest profile
    [17.16,  17.16,   6.5, 	 6.5, 7.25,    0,    0,     3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 6
    [17.16,  17.16,   6.5, 	 6.5,    7,    0,   .5,  .001,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5, 7.25,    0, -.25,    -5,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [17.16,  17.16,   6.5, 	 6.5,    7,    0,   .5,  .001,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 deepdish
];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  //higt corne thumb
  [   8,   5,    -1,  -39,      4,    1.8,   9.5,    15,     2,       10,    4,    8,  -30,    9.5,    20,     2], //R5
  [   5,  4.3,   -2,  -48,      5,      2,  10.5,    10,     2,        6,    4,   13,  -30,   10.5,    18,     2], //R5
  [   5,  4.3,   -2,  -48,      4,    1.9,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //R5
  
  [ 8.5,  5.0,    7,  -39,      4,    1.9,   9.5,    15,     2,       10,    4,    8,  -30,    9.5,    20,     2], //R5
  [ 8.3,  5.0,    7,  -39,      4,    1.9,   9.5,    15,     2,       10,    4,    8,  -30,    9.5,    20,     2], //R5
  [ 8.5,  5.0,    7,  -39,      4,    1.9,   9.5,    15,     2,       10,    4,    8,  -30,    9.5,    20,     2], //R5
  [   5,  4.8,    5,  -48,      5,    2.2,  10.5,    10,     2,        6,    4,   13,  -30,   10.5,    18,     2], //R5
  [   5,  4.8,    5,  -48,      4,    2.0,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //R5

  // low pro 3 row system
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,        5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  [   5,  3.5,   10,  -55,      5,    1.8,   8.5,    15,     2,        5,  3.7,   10,  -55,    8.5,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [ 4.8,  3.3,   18,  -55,      5,    2.0,   8.5,    15,     2,      4.8,  3.3,   18,  -55,    8.5,    15,     2], //R3 deep
  //kyria
  [  13,  5.5,    5,  -40,      4,    1.8,  10.5,    30,     2,       12,    8,   5,    -5,    10.5,     40,     2], //T1R1 2u
  [   5,  4.4,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T0R1 1u
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T0R2 1u
  [  13,  4.5,    7,  -39,      4,    1.8,  10.5,    15,     2,       13,    4,    8,  -30,   10.5,    20,     2], //T1R1 2u
  [   5,  4.4,    5,  -48,      4,    1.9,    11,    12,     2,      5.5,  3.5,    8,  -50,     11,    28,     2], //T1R1 1u
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T1R2 1u
  [   5,  4.4,    5,  -48,      4,    1.9,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //T2R1 
  [   5,  4.4,    5,  -48,      4,    1.9,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //T3R1 
  // low pro mil sculpt 3 row system
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,        5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  [   5,  3.8,    8,  -55,      5,    1.8,   8.5,    15,     2,        5,  4.2,    8,  -55,    8.5,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [5.25,  3.,   16,  -55,      5,    1.8,   8.5,    15,     2,       5.25,  3.1,   16,  -55,    8.5,    15,     2], //R3 deep
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
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID), roll  = 0), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID), roll  = -0, yaw = 0),
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
    stemCrossHeight+.1+StemBrimDep + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1 -StemBrimDep))    //Z shift
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
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, crossSection = true,Legends = false, homeDot = false, Stab = 0) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), 1, d = 0)) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i), 1, d = 0)) ];
  
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
        translate([0,0,StemBrimDep])rotate(stemRot)difference(){   
          //cylinderical Stem body 
          cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
          skin(StemCurve);
          skin(StemCurve2);
        }

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

MXWid = 4.03/2+Tol; //horizontal lenght
MXLen = 4.23/2+Tol; //vertical length

MXWidT = 1.15/2+Tol; //horizontal thickness
MXLenT = 1.25/2+Tol; //vertical thickness

function stem_internal(sc=1) = sc*[
[MXLenT, MXLen],[MXLenT, MXWidT],[MXWid, MXWidT],
[MXWid, -MXWidT],[MXLenT, -MXWidT],[MXLenT, -MXLen],
[-MXLenT, -MXLen],[-MXLenT, -MXWidT],[-MXWid, -MXWidT],
[-MXWid,MXWidT],[-MXLenT, MXWidT],[-MXLenT, MXLen]
];  //2D stem cross with tolance offset and additonal transformation via jog 
//trajectory();
function StemTrajectory() = 
  [
    trajectory(forward = 5.25)  //You can add more traj if you wish 
  ];
  
  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() = 
  [
    trajectory(forward = .5)  //You can add more traj if you wish 
  ];
  
  StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
  StemCurve2  = [ for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]),  stem_internal()) ]; 


module choc_stem() {
  
    translate([5.7/2,0,-3.4/2+2])difference(){
    cube([1.25,3, 3.4], center= true);
    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
  }
  translate([-5.7/2,0,-3.4/2+2])difference(){
    cube([1.25,3, 3.4], center= true);
    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
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
