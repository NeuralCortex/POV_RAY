#include "colors.inc"                                   
#include "textures.inc" 
#include "glass.inc"
#include "shapes.inc"

#declare kugel=sphere {
    <0,0,0>, 0.12
}  

camera {
    location <10, 10, -15>
    look_at  <0, 0,  0>  
    right 16/9*x
} 

background{color Blue}

light_source { <2, 5, -20> color White}   
light_source { <2, 20, -20> color White}       

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
 

    #declare w=2;
    #declare h=10;
    #declare stepping=0.5;
    #declare turns=5; 

    #declare spiral=union{
    #for(phi,0,(360*turns)-stepping,stepping)
        #declare x1=w*cos(radians(phi));
        #declare y1=phi*h/(360*turns);
        #declare z1=w*sin(radians(phi));  
        
        #declare percent=phi/(360*turns)*100;    

        object{kugel scale 2 translate <x1,y1,z1> pigment{color cs(percent)}} 
    #end              
    }


object{spiral rotate z*-90 translate <-5,0,0>}





       
