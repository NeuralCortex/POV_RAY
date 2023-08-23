#include "colors.inc"                                   
#include "textures.inc"

#declare hor_res=1920;
#declare ver_res=1080;
             
#declare stepping=5;             
#declare basis=7.0;
#declare r=7;      
#declare cyl_rad=0.02;  
#declare cyl_color=color White;
#declare d=r*2.0;

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
     
#for(i,0,360-stepping,stepping)
    #for(j,0,180-stepping,stepping)
        #declare x1=r*sin(radians(j))*cos(radians(i));
        #declare y1=r*sin(radians(j))*sin(radians(i));
        #declare z1=r*cos(radians(j));
        
        #declare x2=r*sin(radians(j+stepping))*cos(radians(i));
        #declare y2=r*sin(radians(j+stepping))*sin(radians(i));
        #declare z2=r*cos(radians(j+stepping));  
        
        #declare x3=r*sin(radians(j))*cos(radians(i+stepping));
        #declare y3=r*sin(radians(j))*sin(radians(i+stepping));
        #declare z3=r*cos(radians(j));  
        
        cylinder{
            <x1,y1,z1>,
            <x2,y2,z2>,
            cyl_rad
            pigment {cyl_color}
        }
          
        #if(j!=0)
            cylinder{
                <x1,y1,z1>,
                <x3,y3,z3>,
                cyl_rad
                pigment {cyl_color}
            }        
        #end
    #end
#end 

#for(i,0,360,stepping)
    #for(j,0,180,stepping)
        #declare x1=r*sin(radians(j))*cos(radians(i));
        #declare y1=r*sin(radians(j))*sin(radians(i));
        #declare z1=r*cos(radians(j));
        object{ kugel translate <x1,y1,z1>     
            
            texture{      
                pigment{
                    color cs((1-(j/180))*100)
                }
            }
        }
    #end    
#end
} 

object{sp translate <0,0,0>}