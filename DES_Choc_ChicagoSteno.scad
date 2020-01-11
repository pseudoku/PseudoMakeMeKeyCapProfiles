use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
use <z-butt.scad>
//DES (Distorted Elliptical Saddle) Choc Chord version Chicago Stenographer with sculpted gergo thumb cluter
//TODO: fine tune levee as the dish is not replicated compared to chicago
/*Tester */
//difference(){
////   #lp_stem_cavity(yu = 2);
//  #translate([0,-0,-0])cube([16.5,36.5,20], center = true);
//}

difference(){
 translate([0,0,-0])keycap(keyID = 5, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
}
// #lp_master_base();

// for(j=  [0:5])
// for(i = [0:3])
// translate([19*j,19*i,0])keycap(keyID = 3, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//for (i = [15:18]) 
////difference(){
//
//,
//for (i = [19:22]) 
//  translate([19*1.25,19*(i-19),0])keycap(keyID = i, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//translate([0,16, 0])keycap(keyID = 14, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//
//translate([17,0, 0])mirror([1,0,0])keycap(keyID = 13, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//
//translate([17,16, 0])mirror([1,0,0])keycap(keyID = 14, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//Levee Additional Dist


//Test Mods
//translate([0,20, 0])keycap(keyID = 2, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([0,40, 0])rotate([0,0,180])keycap(keyID = 1, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([0,0, 0])rotate([0,0,0])keycap(keyID = 1, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//translate([20,19, 0])keycap(keyID = 12, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([20,38, 0])rotate([0,0,180])keycap(keyID = 11, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([20,0, 0])rotate([0,0,0])keycap(keyID = 11, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);

//translate([24,0, 0])keycap(keyID = 8, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//
//translate([24,20, 0])keycap(keyID = 9, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//translate([24,40, 0])rotate([0,0,180])keycap(keyID = 8, cutLen = -ChocCut, Stem =true,  Dish = true, Stab = 0 , visualizeDish = false, crossSection = false, homeDot = false, Legends = false);
//
// translate([0,19, 0])keycap(keyID = 3, cutLen = 0, Stem =true,  Dish = true, visualizeDish = true, crossSection = true, homeDot = false, Legends = false);
// translate([0,38, 0])mirror([0,1,0])keycap(keyID = 2, cutLen = 0, Stem =true,  Dish = true, visualizeDish = false, crossSection = true, homeDot = false, Legends = false);

RowHome = [0,2.5,5,2.5,0,0];
//#translate([20,0,0])cube([14.5, 13.5, 10], center = true); // internal check
ChocCut = 0;
// Levee Test
//  translate([19*0, 5, 0])rotate([-15,0,0])
//    keycap(keyID = 9, cutLen = -ChocCut, Stem = thumbStem,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([19*0, 19-5, 0])rotate([15,0,0])
//    keycap(keyID = 10, cutLen = ChocCut, Stem = thumbStem,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([-19+5, 19*.5, .5])rotate([15,0,90])
//    keycap(keyID = 11, cutLen = ChocCut, Stem = thumbStem,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([19*1, 19*1, 0])
//    keycap(keyID = 12, cutLen = ChocCut, Stem = thumbStem,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);

//Test 1.5 mods 


thumbStem = true;
thumbDish = true;
thumbVis  = false;
thumbSec  = false;
////// thumb
//  translate([0,0,0])rotate([0,0,30])translate([-19,0,0])keycap(keyID = 4, cutLen = 0, Stem = thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//
//  translate([0,0,0])rotate([0,0,30])translate([-19,28,0])rotate([0,0,180])keycap(keyID = 16, cutLen = 0, Stem =thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([0,0,0])rotate([0,0,30])translate([0,0,0])keycap(keyID = 6, cutLen = 0, Stem =thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([0,0,0])rotate([0,0,30])translate([0,28,0])rotate([0,0,0])keycap(keyID = 5, cutLen = 0, Stem =thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([0,0,0])rotate([0,0,15])translate([25,1.5,0])rotate([0,0,180])keycap(keyID = 24, cutLen = 0, Stem =thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);
//  translate([0,0,0])rotate([0,0,0])translate([51,12,0])keycap(keyID = 20, cutLen = 0, Stem =thumbStem ,  Dish = thumbDish, visualizeDish = thumbVis, crossSection = thumbSec,Legends = false);

//-Parameters
wallthickness = 1.1; // 1.75 for mx size, 1.1
topthickness = 2.5; //2 for phat 3 for chicago
stepsize = 50;  //resolution of Trajectory
step = 2;       //resolution of ellipes 
fn = 32;          //resolution of Rounded Rectangles: 60 for output
layers = 30;    //resolution of vertical Sweep: 50 for output

//---Stem param
slop    = 0.3;
stemRot = 0;
stemWid = 8;
stemLen = 6;
stemCrossHeight = 1.8;
extra_vertical = 0.6;
stemLayers = 50; //resolution of stem to cap top transition
//#cube([18.16, 18.16, 10], center = true); // sanity check border

//injection param
draftAngle = 0; //degree  note:Stem Only
//TODO: Add wall thickness transition?


keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
    //Column 0
    [17.26,  17.26,   4.5, 	   2,  4.5,    0,   .0,     5,    -0,    -0,   2,   3,      1,      2,      1,      6,     2,       2], //Phat Fingers 0
    [17.26,  17.26,     7, 	   4,  5.5,    0,   .0,     5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2/R4
    [17.26,  17.26,     7, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 flat
    [17.26,  17.26,     7, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 deep

    //Gergo Thumb Sculpted 
    [17.06,  35.96,     7, 	   3,  5.4,    0,    0,    -3,    -7,    -0,   2,   2,      1,      2,      1,      4,     2,       2], //Chicago T0 R1 2u 3
    [17.06,  17.06,     7, 	   4,  6.4,    0,   .0,    -6,     0,     0,   2,   2,      1,      2,      1,      4,     2,       2], //Chicago T0 R2 1u
    [17.06,  35.96,     7, 	   3,  5.4,    0,    0,    -3,     7,    -0,   2,   2,      1,      3,      1,      4,     2,       2], //Chicago T1 R2 2u
    [17.06*1.50,17.16,  7, 	   5,  6.2,    0,    0,    -2,     4,     5,   2,   2,      1,      3,      1,      4,     2,       2], //Chicago T2 R1 1.25
    [17.16*1.25,17.16,  7, 	   5,  6.8,    0,    0,    -2,     3,    -0,   2,   2,      1,      3,      1,      4,     2,       2], //Chicago T3 R1 1.25
    
    //Gergo 1.5 mods 
    [17.06*1.5,17.26,   7, 	   4,  5.5,    0,   .0,     5,     0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2/R4 8
    [17.06*1.5,17.26,   7, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3flat
    
    //Phat Fingers Uniform
    [17.26,  17.26,     2, 	   2,  5,      0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      3,     2,       2], //10
    
    //Levee: Chicago in choc Dimension  11~14
    [16.10,  15.10,     5, 	   4,  5.5,    0,   .0,     5,    -0,    -0,   2,   3,    .75,      1,     .75,      4,     2,       2], //Chicago Steno R2/R4
    [16.10,  15.10,     6, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,    .75,      1,     .75,      4,     2,       2], //Chicago Steno R3 flat
    
    [16.10,  15.10,  4.25, 	3.25,  5.2,  -.8, -0.6,     0,    -4,    -0,   2,   3,    .10,      2,     .10,      2,     2,       2], //Levee Corner R2
    [16.10,  15.10,  4.25, 	3.25,  5.2,  -.8,  0.6,     0,    -4,    -0,   2,   3,    .10,      2,     .10,      2,     2,       2], //Levee Corner R3
    
    //Chicago 4 rows system  15~18
    [17.26,  17.26,     7, 	   4,  5.8,    0,   .0,     7,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R1
    [17.26,  17.26,     7, 	   4,  4.7,    0,   .0,     3,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2    
    [17.26,  17.26,     7, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 flat
    [17.26,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R4
    [17.26,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R5
    //Chicago 4 rows system 1.25 19~22
    [21.86,  17.26,     7, 	   4,  5.8,    0,   .0,     7,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R1
    [21.86,  17.26,     7, 	   4,  4.7,    0,   .0,     3,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2    
    [21.86,  17.26,     7, 	   4,  4.5,    0,   .0,     0,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 flat
    [21.86,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R4
    [21.86,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R5
    //Chicago 4 rows system 1.5 23~26
    [26.66,  17.26,     7, 	   4,  5.8,    0,   .0,     7,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R1
    [26.66,  17.26,     7, 	   4,  4.7,    0,   .0,     3,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2    
    [26.66,  17.26,     7, 	   4,  4.5,    0,   .0,    .1,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 flat
    [26.66,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R4
    [26.66,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R5
    //Chicago 4 rows system 2.0 27~31
    [35.96,  17.26,     7, 	   4,  5.8,    0,   .0,     7,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R1
    [35.96,  17.26,     7, 	   4,  4.7,    0,   .0,     3,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R2    
    [35.96,  17.26,     7, 	   4,  4.5,    0,   .0,    .1,    -0,    -0,   2,   3,      1,      3,      1,      4,     2,       2], //Chicago Steno R3 flat
    [35.96,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R4
    [35.96,  17.26,     7, 	   4,  5.5,    0,   .0,    -5,    -0,    -0,   2,   3,      1,      1,      1,      4,     2,       2], //Chicago Steno R5
];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  //Column 0
  [   6,    4,    7,  -50,      5,    1.0,   15,    25,     2,        6,    4,    2,   -35,   15,    19,     2], //Phat Fingers
  [   6,    4,    7,  -50,      8,    1.8,   11,    17,     2,        6,    4,    2,   -35,   11,    15,     2], //Chicago Steno R2/R4
  [   6,    4,    5,  -40,      8,    1.8,   11,    15,     2,        6,    4,    5,   -40,   11,    15,     2], //Chicago Steno R3 flat
  [ 5.5,    4,   10,  -40,      8,    1.8,   11,    15,     2,       5.5,    4,   10,   -40,   11,    15,     2], //Chicago Steno R3 deep
  
  [14.3,  4.5,    3,  -40,      8,    1.8,   12,    17,     2,     14.3,    4,    2,   -35,   12,    15,     2], //Chicago T0 R1 2u 
  [   6,    4,    7,  -50,      8,    1.8,   12,    17,     2,        6,    4,    2,   -35,   12,    15,     2], //Chicago T0 R2 1u
  [14.3,  4.5,    3,  -40,      8,    1.8,   12,    17,     2,     14.3,    4,    2,   -35,   12,    15,     2], //Chicago T1 R2 2u
  [   6,    4,    2,  -35,      8,    1.8,   20,    24,     2,        6,    4,    7,   -45,   20,    23,     2], //Chicago T2 R1 1.25
  [   6,    4,    2,  -35,      8,    1.8,   15,    17,     2,        6,    4,    7,   -45,   15,    15,     2], //Chicago T3 R1 1.25
  //Gergo 1.5 mods 
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno mod R2/R4
  [   6,    4,    5,  -40,      8,    1.8,   22,    25,     2,        6,    4,    5,   -40,   22,    25,     2], //Chicago Steno mod R3 flat
     //Phat Fingers Uniform 
  [   6,  3.5,    7,  -50,      5,    1.0,   16,    23,     2,        6,  3.5,    7,   -50,   16,    23,     2], //Phat Uniform
  
  //Levee: Chicago in choc Dimension 
  [ 4.5,    4,    7,  -50,      8,    1.8,   11,    17,     2,      4.5,    4,    2,   -35,   11,    15,     2], //Chicago Steno R2/R4
  [ 4.5,    4,    5,  -40,      8,    1.8,   11,    15,     2,      4.5,    4,    5,   -40,   11,    15,     2], //Chicago Steno R3 flat
  
  [   6,  3.5,    7,  -50,      5,    1.0,   16,    23,     2,        6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R2/R4
  [   6,  3.5,    7,  -50,      5,    1.0,   16,    23,     2,        6,  3.5,    7,   -50,   16,    23,     2], //Levee Steno R3/R3
  
  //Chicago 4 rows system 
  [   6,    4,    7,  -50,      8,    1.8,   11,    17,     2,        6,    4,    2,   -35,   11,    15,     2], //Chicago Steno R1
  [   6,    4,    7,  -50,      8,    1.8,   11,    17,     2,        6,    4,    2,   -35,   11,    15,     2], //Chicago Steno R2
  [   6,    4,    5,  -40,      8,    1.8,   11,    15,     2,        6,    4,    5,   -40,   11,    15,     2], //Chicago Steno R3 flat
  [   6,    4,    7,  -50,      8,    1.8,   11,    17,     2,        6,    4,    2,   -35,   11,    15,     2], //Chicago Steno R2/R4
  
  //Chicago 4 rows system 1.25
  [   6,    4,    7,  -50,      8,    1.8,   16,    25,     2,        6,    4,    2,   -35,   16,    22,     2], //Chicago Steno R1
  [   6,    4,    7,  -50,      8,    1.8,   16,    25,     2,        6,    4,    2,   -35,   16,    22,     2], //Chicago Steno R2
  [   6,    4,    5,  -40,      8,    1.8,   16,    25,     2,        6,    4,    5,   -40,   16,    22,     2], //Chicago Steno R3 flat
  [   6,    4,    7,  -50,      8,    1.8,   16,    25,     2,        6,    4,    2,   -35,   16,    22,     2], //Chicago Steno R2/R4
  //Chicago 4 rows system 1.5
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R1
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R2
  [   6,    4,    5,  -40,      8,    1.8,   22,    25,     2,        6,    4,    5,   -40,   22,    25,     2], //Chicago Steno R3 flat
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R2/R4
  //Chicago 4 rows system 2.0
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R1
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R2
  [   6,    4,    5,  -40,      8,    1.8,   22,    25,     2,        6,    4,    5,   -40,   22,    25,     2], //Chicago Steno R3 flat
  [   6,    4,    7,  -50,      8,    1.8,   22,    25,     2,        6,    4,    2,   -35,   22,    25,     2], //Chicago Steno R2/R4
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
//    ((1-t)/stemLayers*XAngleSkew(keyID)),   //X shift
//    ((1-t)/stemLayers*YAngleSkew(keyID)),   //Y shift
//    ((1-t)/stemLayers*ZAngleSkew(keyID))    //Z shift
0,0,0
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent 


///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, crossSection = false, Dish = true, Stem = false, homeDot = false, Stab = 0, Legends = false) {
  
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
        rotate([0,0,stemRot])choc_stem(draftAng = draftAngle); // generate mx cherry stem, not compatible with box
        if (Stab != 0){
          translate([Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
          translate([-Stab/2,0,0])rotate([0,0,stemRot])cherry_stem(KeyHeight(keyID), slop);
        }
        translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), rounded_rectangle_profile(StemTransform(i, keyID),fn=fn,r=StemRadius(i, keyID)))]); //outer shell
          
        
      }
    //cut for fonts and extra pattern for light?
    }
    
    //Cuts
    
    //Fonts
    if(cutLen != 0){
      translate([0,sign(cutLen)*(BottomLength(keyID)+CapRound0i(keyID)+abs(cutLen))/2,0])
        cube([BottomWidth(keyID)+CapRound1i(keyID)+1,BottomLength(keyID)+CapRound0i(keyID),50], center = true);
    }
    if(Legends ==  true){
      #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-1,-5,KeyHeight(keyID)-2.5])linear_extrude(height = 1)text( text = "ver2", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
      translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } else {
      #translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)]) rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } 
   }
     if(crossSection == true) {
       translate([0,-25,-.1])cube([15,50,15]); 
     }
       //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = 1);
  }

}

//------------------stems 
$fn = fn;

function outer_cherry_stem(slop) = [ stemWid - slop * 2, stemLen - slop * 2];
function outer_cherry_stabilizer_stem(slop) = [4.85 - slop * 2, 6.05 - slop * 2];
function outer_box_cherry_stem(slop) = [6 - slop, 6 - slop];

// .005 purely for aesthetics, to get rid of that ugly crosshatch
function stem_cross(slop, extra_vertical = 0) = [
  // horizontal tine
  [4.0 + slop, 1.0 + slop / 3],
  // vertical tine
  [1.00 + slop / 3, 4.0 + extra_vertical + slop / 3 + .005],
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
    linear_extrude(height = depth) {
      offset(r=1){
        square(outer_cherry_stem(slop) - [2,2], center=true);
      }
    }
    inside_cherry_cross(slop);
  }
}


module choc_stem(draftAng = 2) {
  stemHeinght = 3.4;
  
  module Stem() {
    difference(){
      hull(){
        translate([0,0,-stemHeinght/2])cube([1.25-sin(draftAng)*stemHeinght,3-sin(draftAng)*stemHeinght,.001], center= true);
        translate([0,0,stemHeinght/2])cube([1.25,3,.001], center= true);
      }
      //cuts
      translate([3.9,0])cylinder(d1=7+sin(draftAng)*stemHeinght, d2=7,3.5, center = true);
      translate([-3.9,0])cylinder(d1=7+sin(draftAng)*stemHeinght,d2=7,3.5, center = true);
    }
  }

  translate([5.7/2,0,-3.4/2+2])Stem();
  translate([-5.7/2,0,-3.4/2+2])Stem();

  
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
