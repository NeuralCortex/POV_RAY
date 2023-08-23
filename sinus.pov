#include "colors.inc"                                   
#include "textures.inc"

#declare kugel=sphere {
    <0,0,0>, 0.12     
}  


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
    location <10, 10, -15>
    look_at  <0, 0,  0>  
    //right hor_res/ver_res*x
    right 16/9*x
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

#declare sp=union{ 
    #local siz=360;
    #local step=5; 
    #local w=10;
                          
    #for(i,0,siz-step,step)
         
        #local x1=i/360*w; 
        #local h1=2*sin(radians(i));
        
        #for(j,0,siz-step,step)    
            #local h2=2*cos(radians(j));
                 
            #local percent=(j)/(siz-step)*100;
         
                
            #local z1=j/360*w;
                
            object{kugel translate <x1,h1*h2,z1> pigment{color cs(percent)}}   
        #end 
    #end  
}

object{sp translate <-w/2,0,-w/2>}