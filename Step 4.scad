// Customizable Fractal Tree
// 
// By steveweber314
// 
// 5/12/2015


//depth of recursion (warning: each iteration will take exponentially more time to process)
number_of_iterations = 5; // [1:10]

//starting height of the first branch
height = 45; //[1:100]

//maximum size of a leaf relative to the branch
leaf_scale = 3.5; //[0.1:10.0]

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


module trunk(size, depth)
{
    //create an array of random numbers
    operation = rands(1,4,1);

    //automatically stop if the size gets too small so we dont waste computation time on tiny little twigs
    if (size > 5)
    {
        //choose a module based on that array
        if (operation[0] < 1)
        {
            branch_one(size*.9, depth);          
        }
        if (operation[0] < 2)
        {
            branch_two(size*.9, depth);          
        }
        else if (operation[0] < 3)
        {
            branch_three(size*.9, depth);          
        }
        else if (operation[0] < 4)
        {
            branch_four(size*.9, depth);          
        }
    }
    
}

module branch_one(size, depth)
{
    sizemod = rands(rate_of_decay,1.15,10);
	entropy = rands(0.5,leaf_scale,1)[0];
	rotations = rands(-20,20,10);

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
                //create a "knuckle"
                sphere(size*knuckle_size);
                rotate([0+rotations[0],0+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1);
                }
            
            }   
		}
		else
		{
            //create the leaves
			color([0,1,0]) {
				sphere(size*.5*entropy, $fn=leaf_smoothness);
			}
		}
	}
}

module branch_two(size, depth)
{
    sizemod = rands(rate_of_decay,1.15,10);
	entropy = rands(0.5,leaf_scale,1)[0];
	rotations = rands(-20,20,10);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	translate([0,0,size])
	{
		
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1);
                }
                rotate([0+rotations[3],30+rotations[4],180+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1);
                }
            }   
		}
		else
		{
			color([0,1,0]) {
				sphere(size*.5*entropy, $fn=leaf_smoothness);
			}
		}
	}
}


module branch_three(size, depth)
{   
    sizemod = rands(rate_of_decay,1.15,10);
	entropy = rands(0.5,leaf_scale,1)[0];
	rotations = rands(-20,20,10);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	translate([0,0,size])
	{
		
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1);
                }
                rotate([0+rotations[3],30+rotations[4],120+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1);
                }
                rotate([0+rotations[6],30+rotations[7],240+rotations[8]])
                {
                    trunk(size*.9*sizemod[2], depth-1);
                }
            }   
		}
		else
		{
			color([0,1,0]) {
				sphere(size*.5*entropy, $fn=leaf_smoothness);
			}
		}
	}
}

module branch_four(size, depth)
{
    sizemod = rands(rate_of_decay,1.15,10);    
	entropy = rands(0.5,leaf_scale,1)[0];
	rotations = rands(-20,20,12);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}


	translate([0,0,size])
	{
	
		if (depth > 0)
		{
            union()
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1);
                }
                rotate([0+rotations[3],30+rotations[4],90+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1);
                }
                rotate([0+rotations[6],30+rotations[7],180+rotations[8]])
                {
                    trunk(size*.9*sizemod[2], depth-1);
                }
                rotate([0+rotations[9],30+rotations[10],270+rotations[11]])
                {
                    trunk(size*.9*sizemod[2], depth-1);
                }                
            }
		}
		else
		{
			color([0,1,0]) {
				sphere(size*.5*entropy, $fn=leaf_smoothness);
			}
		}
	}

}



    //build the tree
    trunk(height, number_of_iterations, $fn=level_of_smoothness);




