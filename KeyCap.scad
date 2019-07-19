use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
key = 
//  BotWid, BotLen, TopWDif, TopLDif, height,  WShift, LShift  XAngSkew, YAngSkew, ZAngSkew LExpo, WExpo, CapRadIn, CapRadFn, CapRadExpd
    [18.16,  18.16,       3, 	     5,     10,        0,     0,        0,        0,        0,    5,     5,       .5,        4,          1];
//	[18.16,     18.16,  6,      4,      8.5,    -1,     1.75,     0,       1,       0,        0,        false],//C0R1 unusede 
//	[18.16,     18.16,  6.2,    4,      7.5,	  3,      1.75,     0,       1,       0,        0,        false],//C0R2 unused 
//  
//	[18.16,     18.16,  5.7,    4,      7.4,    -2,     -1.5,     1,       1.2,     0,        0,        false],//C1R0 clipped G20 like
//	[18.16,     18.16,  5.7,    5.7,    7.4,    0,      0,        1,       1.2,     0,        0,        false],//C1R1 clipped G20 DSA 
//  [18.16,     18.16,  5.7,    4,      7.4,    -5,      1.5,     1,       1.2,     0,        0,        false],//C1R2 clipped G20 like
//  
//	[18.4,      18.4,   3,      5.7,    7.4,    0,      0,        1,       2,       -3,        -2,        false],//C2R0 clipped tilted
//	[18.4,      18.4,   3,      5.7,    7.4,    0,      0,        1,       2,       -3,        0,        false],//C2R1 clipped tilted
//	[18.4,      18.4,   3,      5.7,    7.4,    -5,     1.5,      1,       2,       -3,        0,        false],//C2R2 clipped tilted
//  
//	[18.4,      18.4,   5.7,    5.7,    7.4,    -5,      -1,       1,      1.2,     0,        0,       false],//C3R0
//	[18.4,      18.4,   5.7,    5.7,    7.4,    0,      0,        1,       1.2,     0,        0,        false],//C3R1 Norm DSA
//	[18.16,     18.16,  5.7,    4,      7.5,    -5,     1.5,      0,       1,       0,        0,        false],//C3R2
//  
//  [18.4,      18.4,   5.7,    5.7,    7.4,    -5,      0,        1,       1.2,     0,        0,        false],//C4R0
//	[18.4,      18.4,   5.7,    5.7,    7.4,    0,      0,        1,       1.2,     0,        0,        false],//C4R1
//	[18.16,     18.16,  5.7,    3,      7.5,	  -5,     1.5,      0,       1,       0,        0,        false],//C4R2
//  
//	[18.16,     18.16,  5.7,    4,      6.2,    7,      1.75,     0,       1,       0,        0,        false],//C5R0
//	[18.4,      18.4,   5.7,    5.7,    7.4,    0,      0,        1,       1.2,     0,        0,        false],//C5R1
//  [18.16,     18.16,  5.7,    3,      7.5,	   -5,     1.5,      0,       1,       0,        0,        false],//C5R2
//  
//	[18.16,     18.16,  4,      6,      7.4,      6,     -1.5,      1,     1.2,     0,        0,       false],//C6R0
//	[18.16,     18.16,  4,      5.7,    7.4,      0,      0,        1,     .5,      0,        0,       false],//C6R1  true
//	[18.16,     18.16,  4,      3,      7.5,	   -4,      1.5,      1,     1,       1,        -1,        false] //C6R2 
//];

step = 1;
//function path(t) = [t, t, t];
function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (t = [rot1:step:rot2]) [a*cos(t), b*sin(t)*(1+d*cos(t))]]; //shape to 
//
//
function path(t) = [0,0,t];
//  
//module roundedRect(size = [0,0,0], radius= 1.5) { //simplified to single call using Morphology Util lib
//  linear_extrude(size[2])rounding(r=radius)square([size[0], size[1]], center = true);
//}  


function shape1 (a,b,c,d) = 
  concat(
   [[a,-c]],
    ellipse(a, b, d = 0, rot2 = 180),
   [[-a,-c]]
  );

function DishShape (a,b,c,d) = 
  concat(
   [[c,b]],
    ellipse(a, b, d = 0,rot1 = 90, rot2 = 270),
   [[c,-b]]
  );


//linear_extrude(5)polygon(shape1(1, 1, 1, d = 0));


function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , // 
 b*sin(phi),
]; 
  


path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];

//Define the trajectory of the dish shsape cuts 
FrontTraj   = [
                trajectory(forward = 5, pitch = -10, roll = 5),
                trajectory(forward = 2, pitch = -60),
                trajectory(forward = 10, pitch = 10),
              ];

BackTraj   = [
                trajectory(forward = 5, pitch = 10 , roll = 5),
                trajectory(forward = 5, pitch = -90),
                trajectory(forward = 10, pitch = 10),
              ];

//quantized trajectory to be fed into transform
stepsize = 100;
fn=60;

FrontPath = quantize_trajectories(FrontTraj, steps = stepsize, loop=false, start_position= $t*4);
BackPath  = quantize_trajectories(BackTraj,  steps = stepsize, loop=false, start_position= $t*4);

FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(2, 10, 3, d = 0)) ];  
BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(2, 10, 3, d = 0)) ];

FrontCurve2 = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(2+2, 10+2, 2, d = 0)) ];  
  



//CapWall(capID,thickness_difference, depth_difference, )
layers = 40;

function CapTranslation(t) = 
  [
    ((1-t)/layers*key[5]),   //X shift
    ((1-t)/layers*key[6]),   //Y shift
    (t/layers*key[4])    //Z shift
  ];

function CapRotation(t) =
  [
    ((1-t)/layers*key[7]),   //X shift
    ((1-t)/layers*key[8]),   //Y shift
    ((1-t)/layers*key[9])    //Z shift
  ];

function CapTransform(t) = 
  [
    pow(t/layers, key[10])*(key[0]-key[2]) + (1-pow(t/layers, key[10]))*key[0],
    pow(t/layers, key[11])*(key[1]-key[3]) + (1-pow(t/layers, key[11]))*key[1]
  ];
  
function CapRadius(t) =  pow(t/layers, key[10])*(key[0]-key[2]) + (1-pow(t/layers, key[10]))*key[0],
difference(){
	skin([for (i=[0:layers-1])transform(translation(CapTranslation(i)) * rotation(CapRotation(i)), rounded_rectangle_profile(CapTransform(i),fn=fn,r=.5))]);
  
  //another skin morph with wall thickness
  //use intersection with stem here?
  //cut for fonts and extra pattern for light?
  
//#translate([0,0,26])rotate([-80,0,0])sweep(shape1(10, 10, 2, d = 0), path_trans2);

//#translate([0,0,key[4]+5])rotate([0,-90,90])skin(FrontCurve);
//#translate([0,0,key[4]+5])rotate([0,-90,270])skin(BackCurve);
}
//echo(morph(
//		profile1 = rounded_rectangle_profile([key[0],key[1]],fn=fn,r=.5),   
//		profile2 = transform(translation([0,0,key[4]+5]), rounded_rectangle_profile([key[0]-key[2],key[1]-key[3]],fn=fn,r=4)),
//		slices=10)
//	););
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

powExpo = 2; 
function interpolate_profile(profile1, profile2, t) = (1-pow(t,powExpo)) * profile1 + pow(t,powExpo)* profile2;
//function interpolate_arc_profile(profile1, profile2, t) = (1-sin(t*90)) * profile1 + sin(t*90) * profile2;

// Morph two profile
function morph(profile1, profile2, slices=1, fn=0) = morph0(
	augment_profile(to_3d(profile1),max(len(profile1),len(profile2),fn)),
	augment_profile(to_3d(profile2),max(len(profile1),len(profile2),fn)),
	slices
);

function morph0(profile1, profile2, slices=1) = [
	for(index = [0:slices-1])
		interpolate_profile(profile1, profile2, index/(slices-1))
];


// The area of a profile
//function area(p, index_=0) = index_ >= len(p) ? 0 :
function pseudo_centroid(p,index_=0) = index_ >= len(p) ? [0,0,0] :
	p[index_]/len(p) + pseudo_centroid(p,index_+1);


//// Nongeneric helper functions

function profile_distance(p1,p2) = norm(pseudo_centroid(p1) - pseudo_centroid(p2));

function rate(profiles) = [ 
	for (index = [0:len(profiles)-2]) [
		profile_length(profiles[index+1]) - profile_length(profiles[index]), 
     	profile_distance(profiles[index], profiles[index+1])
    ]
];

function profiles_lengths(profiles) = [ for (p = profiles) profile_length(p) ];

function profile_length(profile,i=0) = i >= len(profile) ? 0 :
	 profile_segment_length(profile, i) + profile_length(profile, i+1);

function expand_profile_vertices(profile,n=32) = len(profile) >= n ? profile : expand_profile_vertices_0(profile,profile_length(profile),n);
