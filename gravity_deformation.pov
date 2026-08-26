#version 3.7;

#include "colors.inc"    
#include "golds.inc"

#include "textures.inc"

plane{<0,1,0>,1 
    hollow  
    texture{
        pigment{
            bozo turbulence 0.85 scale 1.0 translate<5,0,0>
            color_map{
                 [0.5 rgb <0.20, 0.20, 1.0>]
                 [0.6 rgb <1,1,1>]
                 [1.0 rgb <0.5,0.5,0.5>]
            }
        }
        finish {ambient 1 diffuse 0} }      
        scale 10000
}  

camera {
    location  <25.0, 18.0, -25.0>
    look_at   <0.0, -2.0, 0.0>
    right     x*image_width/image_height
    angle     45
}

light_source { <2, 5, -20> color White}     

#declare TileNormal=normal{
    gradient x 2 
    slope_map{
        [0 <0, 1>] 
        [.05 <1, 0>] 
        [.95 <1, 0>] 
        [1 <0, -1>]
    }
} 

plane { <0, 1, 0>, -10
    pigment{ 
        checker
        pigment { granite color_map { [0 rgb 1][1 rgb .9] } }
        pigment { granite color_map { [0 rgb .9][1 rgb .7] } }
    }
    finish { specular 1 }
    normal{
        average normal_map{
            [1 TileNormal]
            [1 TileNormal rotate y*90]
        }
    }
} 

#declare cs = function{ 
  spline { 
    000, <1,0,0>   
    025, <1,1,0>
    050, <0,1,0>
    075, <0,1,1>
    100, <0,0,1>
  }
  }

//--- Simulation Parameters -----------------------------------------
#declare GridSize = 20;       // Total width/length of the grid
#declare Resolution = 40;     // Number of subdivisions (lines = Resolution + 1)
#declare Step = GridSize / Resolution;
#declare HalfSize = GridSize / 2;

// Gravity/Mass properties
#declare MassX = 0.0;         // Center of gravity X
#declare MassZ = 0.0;         // Center of gravity Z
#declare MaxSag = 4.5;        // How deep the grid sinks
#declare SagRadius = 8.0;     // How far the deformation spreads (Sigma)

#declare WireRadius = 0.03;   // Thickness of the grid lines

#macro GetDeformation(X, Z)
    // Distance from the center of mass
    #local Dist = sqrt(pow(X - MassX, 2) + pow(Z - MassZ, 2));
    
    // Smooth boundary clamping so the edges stay perfectly anchored at Y=0
    #local EdgeFactorX = cos((X / HalfSize) * (pi / 2));
    #local EdgeFactorZ = cos((Z / HalfSize) * (pi / 2));
    #local AnchorClamp = EdgeFactorX * EdgeFactorZ;

    // Gaussian gravity well profile multiplied by anchoring constraints
    #local Sag = -MaxSag * exp(-pow(Dist, 2) / (2 * pow(SagRadius, 2))) * AnchorClamp;
    
    Sag
#end

union {
    #declare Z_idx = 0;
    #while (Z_idx <= Resolution)
        #declare CurrentZ = -HalfSize + (Z_idx * Step);
        
        #declare X_idx = 0;
        #while (X_idx < Resolution)
            #declare X1 = -HalfSize + (X_idx * Step);
            #declare X2 = X1 + Step;
            
            #declare Y1 = GetDeformation(X1, CurrentZ);
            #declare Y2 = GetDeformation(X2, CurrentZ);   
            
            #debug str(Y1/MaxSag*100,3,1)  
            
            #declare percent=abs(MaxSag+Y1)/MaxSag*100;
            
            cylinder { <X1, Y1, CurrentZ>, <X2, Y2, CurrentZ>, WireRadius pigment{color cs(percent)}}
            sphere { <X1, Y1, CurrentZ>, WireRadius pigment{color cs(percent)}} // Smooth joints
            
            #declare X_idx = X_idx + 1;
        #end
        
        #local ys=GetDeformation(HalfSize, CurrentZ);
        sphere { <HalfSize, ys, CurrentZ>, WireRadius pigment{color cs(percent)} }
        
        #declare Z_idx = Z_idx + 1;
    #end

    
    #declare X_idx = 0;
    #while (X_idx <= Resolution)
        #declare CurrentX = -HalfSize + (X_idx * Step);
        
    
        #declare Z_idx = 0;
        #while (Z_idx < Resolution)
            #declare Z1 = -HalfSize + (Z_idx * Step);
            #declare Z2 = Z1 + Step;
            
            #declare Y1 = GetDeformation(CurrentX, Z1);
            #declare Y2 = GetDeformation(CurrentX, Z2);  
            
            #declare percent=abs(MaxSag+Y1)/MaxSag*100;
            
            cylinder { <CurrentX, Y1, Z1>, <CurrentX, Y2, Z2>, WireRadius pigment{color cs(percent)}}
            
            #declare Z_idx = Z_idx + 1;
        #end
        
        #declare X_idx = X_idx + 1;
    #end
}

sphere {
    <MassX, GetDeformation(MassX, MassZ) + 2, MassZ>, 2
           texture { Polished_Chrome
                   pigment{ color rgb<1,0,0> } 
                   normal { bumps 0.5 scale 0.6 }
                   finish { phong 1 }
                 } 

}