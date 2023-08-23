#include "colors.inc"                                   
#include "textures.inc" 
#include "golds.inc" 

#declare showSphere=false;

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

#declare loxo=union{
    #local r=5;
    #local n=85;
    #local k=1/tan(radians(n));
    
    #local step=0.005;
    
    #for(i,-90,90,step)
        #local x1=(r*cos(i))/cosh(k*i);
        #local y1=(r*sin(i))/cosh(k*i);
        #local z1=r*tanh(k*i); 
                                
        #local percent=abs(i*2)/90*100;
       
     
        object{kugel pigment{color cs(percent)} translate <x1,y1,z1>} 
    #end  
    
    #if(showSphere)
        sphere{
            <0,0,0>,r
            texture{T_Gold_1A finish{phong 1}}  
            //rotate x*90
        }
    #end
    
    rotate x*90 
}

object{loxo}



