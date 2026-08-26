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

#declare cs2 = function{ 
  spline { 
    000, <1,0,0>   
    010, <1,1,0>
    020, <0,1,0>
    030, <0,1,1>
    050, <0,0,1>
    070, <0,1,1>
    080, <0,1,0>
    090, <1,1,0>
    100, <1,0,0>
  }
}   

#declare sp=sphere{
    <0,0,0>,0.05
}   


#declare R=8;
#declare w=6.5;

#macro mobius(U,V)
    #local X=(R+V*cos(U/2))*cos(U);
    #local Y=(R+V*cos(U/2))*sin(U);
    #local Z=V*sin(U/2);
    <X,Y,Z>
#end   

#macro lin(A,B,T)
    #local X=A.x+T*(B.x-A.x);
    #local Y=A.y+T*(B.y-A.y);
    #local Z=A.z+T*(B.z-A.z);
    <X,Y,Z>
#end
 
#declare mob = union {         
     #local prev = mobius(radians(5), w/3);                      
    #for (U, 0, 360-5, 5)
        #declare V = w / 2;        
        #declare p1 = mobius(radians(U),     V);                                                           
        #declare p2 = mobius(radians(U+360), V); 
        #for (L, 0, 1, 0.1)        
            #declare mid = lin(p1, p2, L);
            #declare mid2 = lin(p1, p2, L+0.1);
           
            sphere {
                mid, 0.05
                pigment { color cs(L*100.0) }
            }   
                      
                  
                  #if(L<1-0.1)
            cylinder {
                mid, mid2, 0.05
                pigment { color cs(L*100) }
            }         
                             #end
               
             #end  
        #end   
             #for (L, 0, 1, 0.2)
                #declare E=720;
                #if(L<0.2)
                    #declare E=360;
                #end        
               #for (U, 0, E-5, 5)
            #declare V = w / 2;                       
            #declare sf=L;
            
            #declare p1 = mobius(radians(U),     V*sf);   
            
                                                     
            #declare p2 = mobius(radians(U+5), V*sf);
    
            
    
             cylinder {
                p1, p2, 0.05
                pigment { color cs2(U/(L<0.2?360:720)*100) }
            }
               
             #end 
            
             
             #end
    
    } 

object{mob rotate x*90}