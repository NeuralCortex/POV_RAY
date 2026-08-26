#include "colors.inc"                                   
#include "textures.inc"      
#include "functions.inc"


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

light_source { <2, 13, -20> color White}     

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
    000, <1,1,1>   
    030, <1,0.5,0>   
    055, <1,1,0>
    070, <0,1,0>
    085, <0,1,1>
    100, <0,0,1>
  }
}    

#declare GridSize = 20;      
#declare Resolution = 40;    
#declare step = 0.1;
#declare half = GridSize / 2;  


#declare half = 10;
#declare step = 0.2; 

#declare NoiseFunction = function {
  pigment {
    bozo    
    color_map {
      [0.0 color rgb 0]
      [1.0 color rgb 1]
    }
    scale 3  
  }
}
  

#declare Tex_Water_Minecraft = texture {
  pigment {
    color rgbf <0.12, 0.45, 0.85, 0.45> 
  }
  normal {
    ripples 0.15
    scale 0.5
    frequency 3.0
  }
  finish {
    ambient 0.25
    diffuse 0.6
    specular 0.4
    roughness 0.05
    reflection { 0.15, 0.3 falloff 2 }
  }
};      

#declare MinecraftTextures = array[3];

//Dirt
#declare MinecraftTextures[0] = texture {
  pigment {
    granite
    color_map {
      [0.00 color rgb <0.46, 0.30, 0.18>]
      [0.40 color rgb <0.36, 0.22, 0.12>]
      [0.80 color rgb <0.28, 0.16, 0.08>]
      [1.00 color rgb <0.20, 0.12, 0.05>]
    }
    scale 0.10
  }
  finish { diffuse 0.65 ambient 0.2 }
};

//Stone
#declare MinecraftTextures[1] = texture {
  pigment {
    bozo
    color_map {
      [0.00 color rgb <0.52, 0.52, 0.54>]
      [0.40 color rgb <0.42, 0.42, 0.44>]
      [0.80 color rgb <0.32, 0.32, 0.35>]
      [1.00 color rgb <0.22, 0.22, 0.25>]
    }
    scale 0.12
  }
  normal {
    bumps 0.45
    scale 0.05
  }
  finish { diffuse 0.75 ambient 0.15 }
};

//Bedrock
#declare MinecraftTextures[2] = texture {
  pigment {
    granite
    color_map {
      [0.00 color rgb <0.30, 0.30, 0.32>]
      [0.40 color rgb <0.15, 0.15, 0.17>]
      [0.80 color rgb <0.05, 0.05, 0.05>]
      [1.00 color rgb <0.00, 0.00, 0.00>]
    }
    scale 0.08
  }
  normal {
    dents 0.6
    scale 0.03
  }
  finish { diffuse 0.5 ambient 0.1 }
};


#declare GroundFloor = -2; 

#declare SeaLevel = 4 * step; 
#declare R = seed(12345);

#for(X, -half, half, step)
  #for(Z, -half, half, step)  
    
   
    #declare NoiseVal = NoiseFunction(X, 0, Z).gray; 
    
    #declare TerrainTopY = floor((NoiseVal * 10) + 1) * step; 
    #declare DirtDepth = 3 * step;
    
    
    #declare TopY = max(TerrainTopY, SeaLevel);

   
    #for(Y, TopY, GroundFloor, -step)
      
      box {
        <X, Y - step, Z>,
        <X + step, Y, Z + step>
        
        texture {
          #if (Y > TerrainTopY)
            
            pigment { 
              color rgbf <0.1, 0.4, 0.8, 0.6>
            }
            normal { ripples 0.2 scale 0.5 frequency 2 }
            finish { 
              reflection 0.2 
              specular 0.6 
              roughness 0.01 
              ambient 0.3 
            }
          #elseif (Y = TerrainTopY)
            #if (Y <= SeaLevel)
              Tex_Water_Minecraft
            #else
             
              pigment { color rgb <0.2 + (NoiseVal*0.1), 0.5 + (NoiseVal*0.3), 0.1> }
              finish { diffuse 0.7 ambient 0.2 }
            #end
          #elseif (Y >= TerrainTopY - DirtDepth)
           
            pigment { 
              granite
              color_map {
                [0.0 color rgb <0.40, 0.25, 0.15>]
                [1.0 color rgb <0.28, 0.18, 0.10>]
              }
              scale 0.2
            }
            finish { diffuse 0.6 ambient 0.2 }
          #else
                 #declare TexIdx = floor(rand(R) * 3);
                 MinecraftTextures[TexIdx]
          
          #end
        }
      }

    #end 

  #end 
#end 