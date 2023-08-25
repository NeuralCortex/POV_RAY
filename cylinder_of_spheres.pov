#include "colors.inc"                                   
#include "textures.inc"

camera {
    location <10, 10, -15>
    look_at  <0, 0,  0>  
    right 16/9*x
}   

light_source { <2, 5, -20> color White}   

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

#declare w=4;
#declare step=1;   
#declare h=5;
#declare hStep=0.1;

#declare cyl=union{
    #for(j,0,h,hStep)   
    #declare percent=(h-j)/h*100;
#declare ring=union{
    #for(i,0,360,step)
        #declare x1=w*sin(radians(i));
        #declare z1=w*cos(radians(i));
        
        object{kugel translate<x1,j,z1> pigment{color cs(percent)}}
    #end    
}
object{ring}
#end

}

object{cyl translate <1,0-2>}
            
                                           

                 


                 



