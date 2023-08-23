#include "colors.inc"                                   
#include "textures.inc" 
#include "golds.inc" 

#declare showTorus=false;

camera {
    location <10, 10, -15>
    look_at  <0, 0,  0>  
    right 16/9*x
}   

light_source { <2, 5, -20> color White}  

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

#declare TileNormal=normal{
    gradient x 2 
    slope_map{
        [0 <0, 1>] 
        [.05 <1, 0>] 
        [.95 <1, 0>] 
        [1 <0, -1>]
    }
} 

plane { <0, 1, 0>, -5.2
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

#declare kugel=sphere{
    <0,0,0>,0.2
}   

#declare torushelix=union{
    #local R=5;
    #local r=1;
    #local n=20;
    
    #local step=0.1;
    
    #for(i,0,360,step)
        #local x1=(R+r*cos(radians(n*i)))*cos(radians(i));
        #local y1=(R+r*cos(radians(n*i)))*sin(radians(i));
        #local z1=r*sin(radians(n*i));  
         
        
        #local percent=(i/360)*100;
        
        #if(i>=180)
            #local percent=(1-i/360)*100;
        #end
     
        object{kugel pigment{color cs(percent)} translate <x1,y1,z1>} 
    #end  
    
    #if(showTorus)
        torus{
            R,0.5
            texture{T_Gold_1A finish{phong 1}}  
            rotate x*90
        }
    #end
}

object{torushelix rotate x*90}



