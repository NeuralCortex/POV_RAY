#include "colors.inc"                                   
#include "textures.inc"  
#include "debug.inc"

#declare hor_res=1920;
#declare ver_res=1080;

#declare basis=6.0;
#declare r=0.1;
#declare d=r*2.0; 

#declare pol_red=texture { Polished_Chrome
    pigment{ color rgb<0.8,0,0.05> } 
    normal { bumps 0.5 scale 0.05 }              
} 
            
#declare l=6;
#declare tex=array[l]{Yellow_Pine,Sandalwood,Rosewood,Rust,Gold_Metal,pol_red};  
#declare s = seed(12345);


#declare kugel=sphere {
    <0,0,0>, d     
}  


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
       

#declare w=4;
#declare h=10;
#declare stepping=10;
#declare turns=2; 

#declare spiral=union{
    #for(phi,0,(360*turns)-stepping,stepping)   
        
        //Rechtsgängig
        #declare x1=w*cos(radians(phi));
        #declare y1=phi*h/(360*turns);
        #declare z1=w*sin(radians(phi));
                    
        //Linksgängig            
        #declare x2=w*cos(radians(phi-180));
        #declare y2=(phi)*h/(360*turns);
        #declare z2=w*sin(radians(phi-180));                         
        
        #declare percent=phi/(360*turns)*100;    
        
        cylinder{
            <x1,y1,z1>,<x2,y2,z2>,0.05
            pigment{color Grey}
        }
       
        object{kugel translate <x1,y1,z1> pigment {color cs(percent)}}  
        object{kugel translate <x2,y2,z2> pigment {color cs(percent)}}
          
        
       
    #end
}

object{spiral scale 0.9 translate y*-2}