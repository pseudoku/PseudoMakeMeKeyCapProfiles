use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
use <z-butt.scad>
//TODOs 
//add shell towards bottom to make it rounder
//add o-ring portion 
//add variable radius for outer fillet
//Fanning? for thumbs
//MX stem


//enum 
Choc = 0;
MX = 1;
Null =2;
// override Z-butt param 
lp_key = [
//     "base_sx", 18.5,
//     "base_sy", 18.5,
     "base_sx", 17.65,
     "base_sy", 16.5,
     "cavity_sx", 16.1,
     "cavity_sy", 14.9,
     "cavity_sz", 1.6,
     "cavity_ch_xy", 1.6,
     "indent_inset", 1.5
     ];
/*Tester */
//translate([0,0,0])lp_master_base(xu = 2, yu = 1 );  

translate([0, 0, -.05])rotate([0,0,0])mirror([0,1,0]){
//  keycap(keyID = 6, cutLen = 0, Stem = Choc,  Dish = false, SecondaryDish = false, visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
}
translate([0, -8, -.05])rotate([0,0,0])mirror([0,0,0]){
  keycap(keyID = 6, cutLen = 0, Stem = Choc,  Dish = false, SecondaryDish = false, visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
}

// translate([14, 14, 0])rotate([0,0,90]) keycap(keyID = 0, cutLen = 0, Stem =true,  Dish = true, SecondaryDish = false,Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
// translate([0, 14, 0])rotate([0,0,90]) keycap(keyID = 0, cutLen = 0, Stem =true,  Dish = true, SecondaryDish = false,Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
// translate([14, 0, 0])rotate([0,0,90]) keycap(keyID = 0, cutLen = 0, Stem =true,  Dish = true, SecondaryDish = false,Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//translate([-18, 0, 10])rotate([0,0,90])mirror([0,0,0])keycap(keyID = 2, cutLen = 0, Stem =true,  Dish = false, SecondaryDish = false,Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//#translate([0,0,0])cube([14, 14, 2], center = true); // internal check
//#translate([1,0,0])cube([12, 14, 4], center = true); // internal check
//#translate([2,0,0])cube([11, 14, 4], center = true); // internal check
//#translate([0,0,5])cube([19.05, 19.05, 10], center = true); // internal check
//#translate([0,0,0])cube([17.5, 16.5, 10], center = true); // internal check
ChocCut = 0;

thumbStem = true;
thumbDish = true;
thumbVis  = false;
thumbSec  = false;


//-Parameters
wallthickness = 1.1; // 1.75 for mx size, 1.1
topthickness = 2.5; //2 for phat 3 for chicago
stepsize = 60;  //resolution of Trajectory
step =2;       //resolution of ellipes 
fn = 16;          //resolution of Rounded Rectangles: 60 for output
layers = 20;    //resolution of vertical Sweep: 50 for output
angularSteps = 20;

//---Stem param

//injection param
draftAngle = 0; //degree  note:Stem Only
Tol    = 0.10; //stem tolarance
stemRot = 0;
stemRad = 5.55; // stem outer radius
stemLen = 5.55 ;
stemCrossHeight = 4;
extra_vertical  = 0.6;
StemBrimDep     = 0.25; 
stemLayers      = 50; //resolution of stem to cap top transition
//TODO: Add wall thickness transition?


keyParameters = //keyParameters[KeyID][ParameterID]
[ 
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew,/*|*/ WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx, chop shift
    //Column 0    
    //set R2 14x14 choc trantisiton  
    [12.90,  12.90, 3.0, 3.0,  2.5,  0.0,  0.0, 0.0, -0, -0,/*|*/ 2,   2,    1,      3,     1,      3,     2,       2, 0], //R2 Top surface  
    [12.40,  12.40, 5.0, 8.0,-0.75,  0.0,  0.0, 0.0, -0, -0,/*|*/ 1,   1,    2,      3,     2,      3,     2,       2, 0], //R2 Bottom Choc surface 
    [12.40,  12.40, 5.0, 8.0,-0.75,  0.0,  0.0, 0.0, -0, -0,/*|*/ 1,   1,    2,      3,     2,      3,     2,       2, 0], //R2 Bottom MX  surface  
   //MX chop
    [12.40,  10.40, 3.0, 3.0,  2.5,  0.0,  0.0, 0.0, -0, -0,/*|*/ 2,   2,    2,      3,     2,      3,     2,       2, -1], //R3 Chop Top surface  
    [12.40,  10.40, 5.0, 6.0,-0.75,  0.0, -1.0, 0.0, -0, -0,/*|*/ .5,  1.2,  2,      1,     2,      1,     2,       2, -1], //R3 Chop Bottom surface  
    [12.40,  10.40, 12.40-5.5, 10.40-5.5,-0.5,  0.0, -1.0, 0.0, -0, -0,/*|*/ 1, 1, 2, 5.5,    2,  5.5,     2,       2, -1], //R3 MX Bottom surface  
//Choc Chop
    [12.40,  9.40, 3.0, 3.0,  2.5,  0.0,  0.0, 0.0, -0, -0,/*|*/ 2,   2,    2,      3,     2,      3,     2,       2, -2], //R3 Chop Top surface  
    [12.40,  9.40, 5.0, 6.0,-0.75,  0.0, -2.0, 0.0, -0, -0,/*|*/ 2,   2,  2,      1,     2,      1,     2,       2, -2], //R3 Chop Bottom surface  
    [12.40,  9.40, 12.40-5.5, 10.40-5.5,-0.5,  0.0, -1.0, 0.0, -0, -0,/*|*/ 1,  1,  2,  5.5, 2,  5.5,     2,       2, -1], //R3 MX Bottom surface  
    
    [17.20,  16.00, 5.6, 5.0,  4.6,    0,   .0,   0, -0, -0, 2, 2.5,  .10,      3,   .10,      3,     2,       2, 0], //R3 bottom
    //Thumb
    [17.20,  16.00,  4.25, 	3.25,  5.0,  -.5,  0.0,    -3,    -3,    -0,   2,   2,    .10,      2,     .10,      2,     2,       2], //Thumb 1
    [15.65,  26.4,   5.5, 	3.25,  4.9,  -.5,  0.0,    -3,    -2,    -2,   2,   2,     .3,      2,      .3,    2.5,     2,       2], //Thumb 1.5
    [15.65,  35.8,  4.25, 	3.25,  4.9, -.25,  0.0,    -2.5,    -4,    -2,   2,   3,     .3,      2,      .3,    2.5,     2,       2], //Thumb 2.0
    //1.25 5

];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx FTani FTanf BTani BTanf TanEX PhiInit PhiFin phiEX
  //Column 0
  [   4, 4.5, 3, -50,  7,  1.7, 11,  17,   2, /*|*/ 4.5,  4,  2,  -35,   11,    15,     2,     2,  3,    2,  3,   2, 203, 198, 2], //full
  [ 4.5,   4, 5, -40,7,1.7,11,15,2,4.5,4,5,-40,11,15,2,4,5,4,5,2, 200, 210,2], //Chicago Steno R3 flat
  [ 4.5,    4,    5,  -40,      7,    1.7,   11,    15,     2,      4.5,    4,    5,   -40,   11,    15,     2,     4,    5,    4,    5,   2, 200, 210,2], //Chicago Steno R3 flat
  
  [3.5, 4.5,  3, -30,  7,  1.7, 11,  17,   2, /*|*/ 3.,  3,  2.2,  -60,   11,    15,     2,     2,  3,    2,  3,   2, 203, 194, 2], //Chop
  [ 4.5,4,5,-40,7,1.7,11,15,2,4.5,4,5,-40,11,15,2,4,5,4,5,2, 200, 210,2], //
  [ 4.5,4,5,-40,7,1.7,11,15,2,4.5,4,5,-40,11,15,2,4,5,4,5,2, 200, 210,2], //
  
  [ 4, 5.5,  6, -60,  7,  1.7, 11,  17,   2, /*|*/ 2.5,  2,  -6,  -180,   11,    17,     2,     2,  3,    2,  3,   2, 203, 194, 2], //Chop
  [ 4.5,4,5,-40,7,1.7,11,15,2,4.5,4,5,-40,11,15,2,4,5,4,5,2, 200, 210,2], //
  [ 4.5,4,5,-40,7,1.7,11,15,2,4.5,4,5,-40,11,15,2,4,5,4,5,2, 200, 210,2], //
//Chicago Steno R3 flat

  [   5,  5.5,    0,  -40,      7,    1.7,   16,    18,     2,       5.5,  3.5,    5,   -50,   16,    18,     2,     5,   3.75,    2,    3.75,   2, 199, 210], //T1
  [  10,  4.5,    0,  -40,      7,    1.7,   16,    15,     2,        10,  3.5,    5,   -50,   16,    18,     2,     3,   3.75,    .75,    3.75,   2, 200, 210], //1.5u 
  [  14.5, 4.5,   4,  -40,      7,    1.7,   16,    18,     2,      14.5,  4.5,    2,   -35,   16,    23,     2,     3,   3.75,    .75,    3.75,   2, 200, 210], //2.0u 
];

SecondaryDishParam = 
[  
  [   6,  3.5,    7,  -50,      3,    2,    8,     8,     2,          5,    5,    5,    15,   10,   20,     2], //Chicago Steno R2/R4
  [   6,  3.5,    7,  -50,      3,  2.5,    8,    20,     3,          2,  4.2,    8,     0,    8,    8,     3], //Chicago Steno R3 flat
  [   6,  3.5,    7,  -50,      3,  2.5,    8,    20,     3,          2,  4.2,    8,     0,    8,    8,     3], //Chicago Steno R3 chord
  
  [   6,  3.5,    7,  -50,      3,    2,    8,     8,     2,          5,    5,    5,    15,   10,    20,     2], //Levee Steno R2/R4
  [   6,  3.5,    7,  -50,      5,  1.0,   16,    23,     2,          6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4
  [   6,  3.5,    7,  -50,      5,  1.0,   16,    23,     2,          6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4

  [   6,  3.5,    7,  -50,      5,  1.0,   16,    23,     2,          6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4
  [   6,  3.5,    7,  -50,      5,  1.0,   16,    23,     2,          6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4
  [   6,  3.5,    7,  -50,      5,  1.0,   16,    23,     2,          6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4

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
function ChopShift(keyID)    = keyParameters[keyID][18];

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
function ForwardTanInit(keyID)= dishParameters[keyID][16];
function ForwardTanFin(keyID) = dishParameters[keyID][17];
function BackTanInit(keyID)   = dishParameters[keyID][18];
function BackTanFin(keyID)    = dishParameters[keyID][19];
function TanArcExpo(keyID)    = dishParameters[keyID][20];
function TransitionAngleInit(keyID) = dishParameters[keyID][21];
function TransitionAngleFin(keyID)  = dishParameters[keyID][22];
function TransitionAngleExpo(keyID)  = dishParameters[keyID][23];

function SFrontForward1(keyID) = SecondaryDishParam[keyID][0];  //
function SFrontForward2(keyID) = SecondaryDishParam[keyID][1];  // 
function SFrontPitch1(keyID)   = SecondaryDishParam[keyID][2];  //
function SFrontPitch2(keyID)   = SecondaryDishParam[keyID][3];  //
function SDishDepth(keyID)     = SecondaryDishParam[keyID][4];  //
function SDishHeightDif(keyID) = SecondaryDishParam[keyID][5];  //
function SFrontInitArc(keyID)  = SecondaryDishParam[keyID][6];
function SFrontFinArc(keyID)   = SecondaryDishParam[keyID][7];
function SFrontArcExpo(keyID)  = SecondaryDishParam[keyID][8];
function SBackForward1(keyID)  = SecondaryDishParam[keyID][9];  //
function SBackForward2(keyID)  = SecondaryDishParam[keyID][10];  // 
function SBackPitch1(keyID)    = SecondaryDishParam[keyID][11];  //
function SBackPitch2(keyID)    = SecondaryDishParam[keyID][12];  //
function SBackInitArc(keyID)   = SecondaryDishParam[keyID][13];
function SBackFinArc(keyID)    = SecondaryDishParam[keyID][14];
function SBackArcExpo(keyID)   = SecondaryDishParam[keyID][15];


function FrontTrajectory(keyID) = 
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(backward = BackForward1(keyID), pitch =  -BackPitch1(keyID)),
    trajectory(backward = BackForward2(keyID), pitch =  -BackPitch2(keyID)),
  ];

function SFrontTrajectory(keyID) = 
  [
    trajectory(forward = SFrontForward1(keyID), pitch =  SFrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = SFrontForward2(keyID), pitch =  SFrontPitch2(keyID)),  //You can add more traj if you wish 
  ];

function SBackTrajectory (keyID) = 
  [
    trajectory(forward = SBackForward1(keyID), pitch =  SBackPitch1(keyID)),
    trajectory(forward = SBackForward2(keyID), pitch =  SBackPitch2(keyID)),
    trajectory(forward = 4, pitch =  -15),
    trajectory(forward = 6, pitch =  -5),
  ];
//------- function defining Dish Shapes,
//helper function
function flip (singArry) = [for(i = [len(singArry)-1:-1:0]) singArry[i]];   
function mirrorX (singArry) = [for(i = [len(singArry)-1:-1:0]) [-singArry[i][0], singArry[i][1]]];   
function mirrorY (singArry) = [for(i = [len(singArry)-1:-1:0]) [singArry[i][0], -singArry[i][1]]];  
  
//function ()

function Fade (Arry1, Arry2, t, steps, pows) =len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1]) (1-pow(t/steps, pows))*Arry1[i]+pow(t/steps, pows)*Arry2[i]]: [[0,0]];
  
function Mix (a, b, t, steps, pows)= (1-pow(t/steps, pows))*a+pow(t/steps, pows)*b;
function smoothStart (init, fin, t, steps, power) = 
  (1-pow(t/steps,power))*init + pow(t/steps,power)*fin ; 

function smoothStop (init, fin, t, steps, power) = 
  (fin-init)*(1-pow(1-t/steps,power))+init; 

function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (i =[0:angularSteps]) let(t = smoothStart(rot1,rot2,i,angularSteps,1)) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b,c,d) = 
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0,rot1 = 90, rot2 = 270)
//   [[c+a,-b]]
  );

function DishShape2 (a,b, phi = 200, theta, r) = 
  concat(
//   [[c+a,b]],
    mirrorY([[a,b*sin(phi)-r*sin(theta)*2]]), //bounday vertex to clear ends 

     mirrorY([for (t = [step:step*2:theta])let( sig = atan(a*cos(phi)/-b*sin(phi)))
     [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
      +a*cos(phi)
      -r*cos(sig)
      +a, 
    
       r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
      +b*sin(phi)
      +r*sin(sig)]
    ]),
  
    (mirrorY(ellipse(a, b, d = 0,rot1 = 180, rot2 = phi))),
    ellipse(a, b, d = 0,rot1 = 180, rot2 = phi),
    
[for (t = [step:step*2:theta])let( sig = atan(a*cos(phi)/-b*sin(phi)))
     [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
      +a*cos(phi)
      -r*cos(sig)
      +a, 
    
       r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
      +b*sin(phi)
      +r*sin(sig)]
    ],

    [[a,b*sin(phi)-r*sin(theta)*2]] //bounday vertex to clear ends 
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
    ((1-t)/layers*TopLenShift(keyID)+ChopShift(keyID)),   //Y shift
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
//    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
//    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
stemWid,stemLen
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent 
  
//DishShape2 vars 

function DishTransition (t, keyID) =  pow(t/stepsize,TransitionAngleExpo(keyID) )*TransitionAngleFin(keyID) + (1-pow(t/stepsize, TanArcExpo(keyID) ))*TransitionAngleInit(keyID);


function FTanRadius (t, keyID) = pow(t/stepsize,TanArcExpo(keyID) )*ForwardTanInit(keyID) + (1-pow(t/stepsize, TanArcExpo(keyID) ))*ForwardTanFin(keyID);
function BTanRadius (t, keyID) = pow(t/stepsize,TanArcExpo(keyID) )*BackTanInit(keyID)  + (1-pow(t/stepsize, TanArcExpo(keyID) ))*BackTanFin(keyID);
function TanTransition (t, keyID) = pow(t/stepsize,TanArcExpo(keyID) )*TransitionAngleInit(keyID)  + (1-pow(t/stepsize, TanArcExpo(keyID) ))*TransitionAngleFin(keyID);


///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, crossSection = false, Dish = true, SecondaryDish = false, Stem = false, homeDot = false, Stab = 0, Legends = false) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID);
  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], 
    DishShape2( a= DishDepth(keyID), b= FrontDishArc(i), phi = DishTransition(i,keyID) , theta= 60
    , r = FTanRadius(i, keyID))) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  
    DishShape2(DishDepth(keyID), BackDishArc(i), phi = DishTransition(i,keyID), theta= 60
    , r = BTanRadius(i, keyID))) ];  
  
  //Secondary Dish
  SFrontPath = quantize_trajectories(SFrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  SBackPath  = quantize_trajectories(SBackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  function SFrontDishArc(t) =  pow((t)/(len(SFrontPath)),SFrontArcExpo(keyID))*SFrontFinArc(keyID) + (1-pow(t/(len(SFrontPath)),SFrontArcExpo(keyID)))*SFrontInitArc(keyID); 
  function SBackDishArc(t)  =  pow((t)/(len(SBackPath)),SBackArcExpo(keyID))*SBackFinArc(keyID) + (1-pow(t/(len(SFrontPath)),SBackArcExpo(keyID)))*SBackInitArc(keyID);
  
  SFrontCurve = [ for(i=[0:len(SFrontPath)-1]) transform(SFrontPath[i], DishShape(SDishDepth(keyID), SFrontDishArc(i), 1, d = 0)) ];  
  SBackCurve  = [ for(i=[0:len(SBackPath)-1])  transform(SBackPath[i],  DishShape(SDishDepth(keyID),  SBackDishArc(i), 1, d = 0)) ];
    
  //builds
  difference(){
    union(){
//      difference(){
        skin([for (i=[0:layers]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        //Bottom shell
        if( Stem == Choc){
        skin([for (i=[0:layers]) transform(translation(CapTranslation(i, keyID+1)) * rotation(CapRotation(i, keyID+1)), elliptical_rectangle(CapTransform(i, keyID+1), b =  CapRoundness(i,keyID+1),fn=fn))]); //outer shell
        }else {
          skin([for (i=[0:layers]) transform(translation(CapTranslation(i, keyID+2)) * rotation(CapRotation(i, keyID+2)), elliptical_rectangle(CapTransform(i, keyID+2), b  = CapRoundness(i,keyID+2),fn=fn))]); //outer shell
          }
        //Cut inner shell
//      }
      if(Stem == Choc){
        rotate([0,0,stemRot])translate([0,0,-2.])choc_stem(draftAng = draftAngle); // generate mx cherry stem, not compatible with box
      } else if (Stem +MX){
        translate([0,0,-4.25])rotate(stemRot)cylinder(d =5.5, 3.75, $fn= 64);
        
//        translate([0,0,-.001])skin([for (i=[0:stemLayers]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), rounded_rectangle_profile(StemTransform(i, keyID),fn=fn,r=1 /*StemRadius(i, keyID) */ ))]); //outer shell
          
        
      }
    //cut for fonts and extra pattern for light?
     if(visualizeDish == true && Dish == true){
      #translate([-TopWidShift(keyID),TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);
     }
    }
    
    //Cuts
    
    //Fonts
    if(cutLen != 0){
      translate([sign(cutLen)*(BottomLength(keyID)+CapRound0i(keyID)+abs(cutLen))/2,0,0])
        cube([BottomWidth(keyID)+CapRound1i(keyID)+1,BottomLength(keyID)+CapRound0i(keyID),50], center = true);
    }
    if(Legends ==  true){
      }
   //Dish Shape 
    if(Dish == true){
      translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);
     
    if (Stem == MX){
      translate([0,0,-4.25])rotate(stemRot){   
          skin(StemCurve);
          skin(StemCurve2);
        }
      }
     if(SecondaryDish == true){
       #translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);
       mirror([1,0,0])translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);

     }
   }
     if(crossSection == true) {
       translate([0,-25,-.1])cube([15,50,15]); 
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = 1);
}

//------------------stems 
$fn = fn;

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
    trajectory(forward = 4.00)  //You can add more traj if you wish 
  ];
  
  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() = 
  [
    trajectory(forward = .5)  //You can add more traj if you wish 
  ];
  
  StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
  StemCurve2  = [ for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]),  stem_internal()) ]; 


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
