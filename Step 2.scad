// Customizable Fractal Tree
// 
// By steveweber314
// 
// 5/12/2015

//
// BEGIN CUSTOMIZER

/* [Tree Parameters] */


//depth of recursion (warning: each iteration will take exponentially more time to process)
number_of_iterations = 5; // [1:10]

//starting height of the first branch
height = 45; //[1:100]


//control the amount of taper on each branch segment
width_ratio_bottom = 0.25; //[0.01:0.99]
width_ratio_top = 0.20; //[0.01:0.99]

//size of the "knuckles" between segments
knuckle_size = 0.25; //[0.01:0.99]

//smaller numbers will be more bush-like, larger numbers more tree-like
rate_of_decay = 0.75; //[0.25:1.0]

//number of faces on the cylinders
level_of_smoothness = 16; // [4:100]

//number of faces on the spheres
leaf_smoothness = 16; // [4:100]

//number of faces on the base/stand
base_smoothness = 60; //[20:200]


use <write/Write.scad>

module trunk(size, depth)
{
 
    branch_one(size*.9, depth);          
    
}

module branch_one(size, depth)
{

	color([1,1,0]) 
	{
		//create the branch by tapering a cylinder from one radius to another
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	//move to the tip of the branch
	translate([0,0,size])
	{
		//check for stop condition
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([0,30,0])
                {
                    trunk(size*.9, depth-1);
                }
                rotate([0,30,180])
                {
                    trunk(size*.9, depth-1);
                }
            }  
		}
	}
}



//build the tree
trunk(height, number_of_iterations, $fn=level_of_smoothness);




