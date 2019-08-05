use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
use <Switch.scad>
//TODO: Make Alias for key[n] 
wallthickness = 2.5;
topthickness = 3.0;
key = 
//[
//       BotWid, BotLen, TopWDif, TopLDif, height,  WShift, LShift  XAngSkew, YAngSkew, ZAngSkew LExpo, WExpo, CapRadIn, CapRadFn, CapRadExpd
    [18.16*1.25,  18.16,       5, 	    5,     13,       0,     0,        -6,        -5,        0,   2.5,  2.5,       .2,        3,          2];
//];

step = 2;
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

//------------Define the trajectory of the dish shsape cuts 
FrontTraj   = [
                trajectory(forward = 6, pitch =  12),
                trajectory(forward = 3, pitch = -50)
              ];

BackTraj   = [
                trajectory(forward = 6, pitch = 10),
                trajectory(forward = 4, pitch = -30),
//                trajectory(forward = 10, pitch = -20, roll = 0)
              ];

//quantized trajectory to be fed into transform
stepsize = 50;
fn=60;

FrontPath = quantize_trajectories(FrontTraj, steps = stepsize, loop=false, start_position= $t*4);
BackPath  = quantize_trajectories(BackTraj,  steps = stepsize, loop=false, start_position= $t*4);

FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(2.5, 12, 1, d = 0)) ];  
BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(2.5, 12, 1, d = 0)) ];

FrontCurve2 = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(2+2, 10+2, 2, d = 0)) ];  

//--------------For Cap 
layers = 50;

function CapTranslation(t) = 
  [
    ((1-t)/layers*key[5]),   //X shift
    ((1-t)/layers*key[6]),   //Y shift
    (t/layers*key[4])    //Z shift
  ];

function InnerTranslation(t) =
  [
    ((1-t)/layers*key[5]),   //X shift
    ((1-t)/layers*key[6]),   //Y shift
    (t/layers*(key[4]-topthickness))    //Z shift
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
  
function InnerTransform(t) = 
  [
    pow(t/layers, key[10])*(key[0]-key[2]-wallthickness) + (1-pow(t/layers, key[10]))*(key[0]-wallthickness),
    pow(t/layers, key[11])*(key[1]-key[3]-wallthickness) + (1-pow(t/layers, key[11]))*(key[1]-wallthickness)
  ];
  
function CapRadius(t) =  pow(t/layers, key[14])*key[13] + (1-pow(t/layers, key[14]))*key[12];


///KEY Build
difference(){
  union(){
    difference(){
      skin([for (i=[0:layers-1])transform(translation(CapTranslation(i)) * rotation(CapRotation(i)), rounded_rectangle_profile(CapTransform(i),fn=fn,r=CapRadius(i)))]);
        
      //use intersection with stem here?
      translate([0,0,-.001])skin([for (i=[0:layers-1])transform(translation(InnerTranslation(i)) * rotation(CapRotation(i)), rounded_rectangle_profile(InnerTransform(i),fn=fn,r=CapRadius(i)))]);
    }
    rotate([0,0,stemRot])cherry_stem(10, slop);

  //cut for fonts and extra pattern for light?
  }
//  #rotate([-key[7],key[8],key[9]])translate([0,4,key[4]-2.5])linear_extrude(height = 0.5)text( text = "Why?", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );

  translate([0,.00001,key[4]-1.5])rotate([0,-key[8],0])rotate([0,-90+key[7],90-key[9]])skin(FrontCurve);
  translate([0,0,key[4]-1.5])rotate([0,-key[8],0])rotate([0,-90-key[7],270-key[9]])skin(BackCurve);
  #translate([0,-6.6,7.8])rotate([72,0,0])Keyhole(.1, clipLength = -3, cutThickness = 0);
//  translate([0,0,-.1])cube([15,15,15]);

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
