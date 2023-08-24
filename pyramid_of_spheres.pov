#include "colors.inc"                                   
#include "textures.inc"

#declare hor_res=1920;
#declare ver_res=1080;

#declare pol_red=texture { Polished_Chrome
    pigment{ color rgb<0.8,0,0.05> } 
    normal { bumps 0.5 scale 0.05 }              
} 
            
#declare l=8;
#declare tex=array[l]{Yellow_Pine,Sandalwood,Rosewood,Rust,Gold_Metal,pol_red,Polished_Chrome,Spun_Brass};  
#declare s = seed(12345);


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

#declare basis=7.0;
#declare r=0.5;
#declare d=r*2.0;
#declare aus=10;         
#declare anz=20;
#declare c=20;
 
#declare pyramid=union{ 
    #for(h,0,anz) 
    #declare percent=h/anz*100;
#declare plate=union{
      #for(i,0,h) 
        #for(j,0,h)  
           
              sphere{
                <0,20,0>,  d
                 texture{
                            /*tex[int(rand(s)*l)]*/   
                            pigment {color cs(percent)}   
                            /*
                            finish { phong 1}  
                            rotate z*int(rand(s)*360)
                            */
                 }    
                     translate <i*2*d,-h,j*2*d> 
              }     
             
        #end
      #end
}   
object{plate translate <-h,0,-h>}
#end
}

object{pyramid scale 0.3}                   
                                           

                 


                 



