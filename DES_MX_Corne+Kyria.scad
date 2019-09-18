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
//#square([18.16, 18.16], center = true);

//TODO add shift 
mirror([1,0,0])keycap(keyID = 33, cutLen = 0, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//n translate([0,19, 0])keycap(keyID = 3, cutLen = 0, Stem =true,  Dish = true, visualizeDish = true, crossSection = true, homeDot = false, Legends = false);
// translate([0,38, 0])mirror([0,1,0])keycap(keyID = 2, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = true, homeDot = false, Legends = false);
RowHome = [0,2.5,5,2.5,0,0];

//for(Col = [6:6]){ 
//  for(Row = [1:3]){
//  translate([19*Col, 19*Row +RowHome[Col], 0])keycap(keyID = Col*4+Row, cutLen = 0, Stem = false,  Dish = true, visualizeDish = false, crossSection = false,Legends = false);
//  } 
//}

//////corne thumb
//  translate([-15, -4, 0])rotate([0,0,30])keycap(keyID = 0, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([6, 0, 0])rotate([0,0,15])keycap(keyID = 4, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([26, 2.2, 0])rotate([0,0,0])keycap(keyID = 8, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);

////kyria Thumb
//  translate([-39, 0, 0])rotate([0,0,30])translate([0,-19.5, 0])keycap(keyID = 24, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([-39, 0, 0])rotate([0,0,30])translate([0, -1, 0])keycap(keyID = 25, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([-17, 0, 0])rotate([0,0,30])translate([0,  0, 0])keycap(keyID = 26, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([6, 0, 0])rotate([0,0,15])keycap(keyID = 27, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);
//  translate([26, 2.2, 0])rotate([0,0,0])keycap(keyID = 28, cutLen = 0, Stem =false,  Dish = true, visualizeDish = false, crossSection = false);

//normie hipro
//  for(Row = [0:4]){
//  translate([0, 19*Row, 0])keycap(keyID = 29+Row, cutLen = 0, Stem = false,  Dish = true, visualizeDish = false, crossSection = false,Legends = false);
//  } 

//#translate([0,38,13])cube([18-5.7, 18-5.7,1],center = true);

//Parameters
wallthickness = 2;   
topthickness  = 3;   //
stepsize      = 50;  //resolution of Trajectory
step          = 1;   //resolution of ellipes 
fn            = 64;  //resolution of Rounded Rectangles: 60 for output
layers        = 40;  //resolution of vertical Sweep: 50 for output
dotRadius     = 1.25;   //home dot size
//---Stem param
slop    = 0.25;
stemRot = 0;
stemWid = 5.5;
stemLen = 7.2;
stemCrossHeight = 4;
extra_vertical  = 0.6;
StemBrimDep     = 0.75; 
stemLayers      = 50; //resolution of stem to cap top transition

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//Column 0
    [17.16,  17.16*1.5, 6, 	   7,   13,    0,    0,   -13,    10,    -5,   2,   2,      1,   4.85,      1,      3,     2,       2], //R5 0 Corne thumb
    [17.16,  17.16,   6.5, 	 6.5,  9+4,    0,    0,    12,   -10,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,    -2,   -10,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  9+4,    0,    0,   -10,   -10,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
//Column 1
    [17.16,  17.16,     4, 	   5,   14,    0,    0,   -13,     5,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 4 corne thumb
    [17.16,  17.16,   6.5, 	 6.5,  9+3,    0,    0,    12,    -3,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,8+2.5,    0,    0,    -2,    -3,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  9+3,    0,    0,   -12,    -3,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
//Column 2 middle
    [17.16,  17.16,     4, 	   6,   15,    0,    0,   -13,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //R5 8 corne thumb
    [17.16,  17.16,   6.5, 	 6.5,    9,    0,    0,    10,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,    8,    0,    0,    -2,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,    9,    0,    0,   -12,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
//Column 3
    [17.16,  17.16,     6, 	   6, 12+3,    0,    0,    13,    -4,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 12
    [17.16,  17.16,   6.5, 	 6.5,  9+3,    0,    0,    10,    -4,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  8+3,    0,    0,    -2,    -4,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  9+3,    0,    0,   -10,    -4,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
//Column 4
    [17.16,  17.16,     6, 	   6,12+5.5,   0,    0,    13,   -10,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 16
    [17.16,  17.16,   6.5, 	 6.5,9+5.5,    0,    0,    10,   -10,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,8+5.5,    0,    0,    -5,   -10,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  9+4,    0,    0,   -12,     5,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
//Column 5
    [17.16,  17.16,     6, 	   6, 12+4,    0,    0,    13,    -6,     0,   2,   2,      1,      5,      1,      3,     2,       2], //R5 20
    [17.16,  17.16,   6.0, 	 6.0,  9+4,    0,    0,    -8,    -6,    15,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,  8+4,    0,    0,    -2,    -6,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,  9+6,    0,    0,   -12,    10,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
 //kyria Thumbs   
    [17.16,  17.16,     6, 	   5,    9,   -1,    0,    -8,     5,    -5,   2,   2,      1,      5,      1,      3,     2,       2], //T0R1
    [17.16,  17.16,     6, 	   5,   11,    0,    0,    -8,     0,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //T0R2
    [17.16,  17.16*2,   6, 	   7,   11,    0,    0,    -8,    10,    -5,   2,   2,      1,   4.85,      1,    3.5,     2,       2], //T1R1 2u
    [17.16,  17.16,     4, 	   5,   12,    0,    0,   -13,     5,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //T2R1 
    [17.16,  17.16,     4, 	   6,   13,    0,    0,   -13,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //T3R1 
//normie hipro
    [17.16,  17.16,   6.5, 	 6.5,   11,    0,    0,   -11,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 8 corne thumb
    [17.16,  17.16,   6.5, 	 6.5, 11.0,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [17.16,  17.16,   6.5, 	 6.5,    9,    0,    0,     3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,   10,    0,    0,   -11,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [17.16,  17.16,   6.5, 	 6.5, 14.0,    0,    0,   -14,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R1
];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  //Column 0
  [   8,  4.5,    7,  -39,      4,    1.8,   9.5,    15,     2,       10,    4,    8,  -30,    9.5,    20,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,   9.5,    19,     2,      4.5,  4.5,    5,  -55,    9.5,    16,     2], //R4
  [   6,    3,   18,  -50,      5,    1.8,   9.5,    15,     2,        5,  3.5,    8,  -55,    9.5,    16,     2], //R3
  [   6,    3,    8,  -50,      5,    1.8,   9.8,    15,     2,        6,    4,   13,  -30,    9.8,    16,     2], //R2
  //Column 1
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,   13,  -30,   10.5,    18,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,     9,    15,     2,        5,  4.2,    5,  -55,      9,    16,     2], //R4
  [   6,    3,   15,  -50,      5,    1.8,     9,    15,     2,        5,  3.5,    8,  -55,      9,    16,     2], //R3
  [   6,    3,    8,  -50,      5,    1.8,     9,    15,     2,        6,    4,   13,  -30,      9,    16,     2], //R2
  //Column 2
  [   5,  4.3,    5,  -48,      4,    1.9,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,   8.5,    15,     2,        5,  4.4,    5,  -55,    8.5,    15,     2], //R4
  [   6,    3,   18,  -50,      5,    1.8,   8.5,    15,     2,        5,  3.5,    8,  -55,    8.5,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  //Column 3
  [   5,    3,    5,  -50,      5,    1.5,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,   9.5,    18,     2,        5,    4,    5,  -55,    9.5,    16,     2], //R4
  [   6,    3,   15,  -50,      5,    1.6,   9.5,    15,     2,        5,  3.5,    8,  -55,    9.5,    16,     2], //R3
  [   6,    3,   10,  -50,      5,    1.6,   9.5,    15,     2,        6,    4,   13,  -30,    9.5,    16,     2], //R2
  //Column 4
  [   5,    3,    5,  -50,      5,    1.8,   8.5,    12,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,   9.5,    17,     2,        4,  4.9,    5,  -50,    9.5,    18,     2], //R4
  [   6,    3,   15,  -50,      5,    1.8,   9.5,    15,     2,        5,    4,   13,  -30,    9.5,    16,     2], //R3
  [   6,    3,   18,  -50,      5,    1.8,   9.6,    15,     2,        6,    4,   13,  -30,    9.6,    16,     2], //R2
  //Column 5
  [   5,    3,    5,  -50,      5,    1.8,   8.5,    10,     2,        6,    4,   13,  -30,    8.5,    16,     2], //R5
  [ 5.5,    3,   18,  -50,      5,    1.9,   9.2,    15,     2,      5.5,    4,   13,  -55,    9.2,    16,     2], //R4
  [   6,    3,   18,  -50,      5,    1.8,   9.2,    15,     2,        5,    4,   13,  -30,    9.2,    16,     2], //R3
  [   6,    3,   18,  -50,      5,    1.8,   9.6,    15,     2,        6,    4,   13,  -30,    9.6,    16,     2], //R2 
  
  [   5,  4.4,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T0R1
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2],//T0R2
  [  13,  4.5,    7,  -39,      4,    1.8,   9.5,    15,     2,       13,    4,    8,  -30,    9.5,    20,     2], //T1R1 2u
  [   5,  4.4,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,   13,  -30,   10.5,    18,     2], //T2R1 
  [   5,  4.4,    5,  -48,      4,    1.9,    11,    12,     2,        6,    4,   13,  -35,     11,    28,     2], //T3R1 
  
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,        5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  [   6,    3,   18,  -55,      5,    1.8,   8.8,    15,     2,        5,  3.5,    8,  -55,    8.8,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        5,    4,   12,  -55,    8.8,    16,     2], //R2
  [   5,  3.5,    8,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R1
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
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, homeDot = false, Stab = 0) {
  
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
        translate([0,0,StemBrimDep])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID)-StemBrimDep, slop); // generate mx cherry stem, not compatible with box
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
  D1=.15;
  D2=.05;
  H1=3.5;
  CrossDist = 1.75;
  difference(){
    // outside shape
    linear_extrude(height = depth) {
      offset(r=1){
        square(outer_cherry_stem(slop) - [2,2], center=true);
      }
    }
    inside_cherry_cross(slop);
    hull(){
      translate([CrossDist,CrossDist-.1,0])cylinder(d1=D1, d2=D2, H1);
      translate([-CrossDist,-CrossDist+.1,0])cylinder(d1=D1, d2=D2, H1);
    }
    hull(){
      translate([-CrossDist,CrossDist-.1])cylinder(d1=D1, d2=D2, H1);
      translate([CrossDist,-CrossDist+.1])cylinder(d1=D1, d2=D2, H1);
    }
  }
}

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
