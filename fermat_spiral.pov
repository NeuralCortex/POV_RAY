#include "colors.inc"                                   
#include "textures.inc"
  
#declare pol_red=texture { Polished_Chrome
    pigment{ color rgb<0.8,0,0.05> } 
    normal { bumps 0.5 scale 0.05 }              
} 
            
#declare l=6;
#declare tex=array[l]{Yellow_Pine,Sandalwood,Rosewood,Rust,Gold_Metal,pol_red};  
#declare s = seed(12345);


plane{<0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.85 scale 1.0 translate<5,0,0>
                        color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                    [0.6 rgb <1,1,1>]
                                    [1.0 rgb <0.5,0.5,0.5>]}
                       }
               finish {ambient 1 diffuse 0} }      
       scale 10000}


camera {
    location <10, 10, -15>
    look_at  <0, 0,  0>  
    right 16/9*x
}   

light_source { <2, 5, -20> color White}   

#declare TileNormal =
    normal
    { gradient x 2
      slope_map
      { [0 <0, 1>] 
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

     normal
  { average normal_map
    { [1 TileNormal]
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

#declare fermat=union{
    #local turns=4; 
    #local stepping=0.1;       
    #local a=1.5;       
    
    #for(i,0,360*turns,stepping)
        #declare r1=a*sqrt(radians(i));
        #declare x1=r1*cos(radians(i));   
        #declare z1=r1*sin(radians(i));
        
        #declare percent=i/(360*turns)*100;                                                          
        
        object{kugel pigment{color cs(percent)} translate <x1,0,z1>}   
        
        #declare r2=-a*sqrt(radians(i));
        #declare x2=r2*cos(radians(i));   
        #declare z2=r2*sin(radians(i));    
        
        #declare percent=(i/(360*turns)*100);                                                          
                                      
        object{kugel pigment{color cs(percent)} translate <x2,0,z2>}                                 
    #end
}

object{fermat}



