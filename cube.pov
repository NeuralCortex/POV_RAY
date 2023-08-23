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
    #local step=1; 
    #local rad=0.02;
    #local siz=10;
        
    #for(i,0,siz-step,step)
        #for(j,0,siz-step,step)    
            #for(k,0,siz-step,step)
                #if(j<=siz-2)
                cylinder{
                    <i,k,j>,<i,k,j+step>,rad
                    pigment{color Black}
                }
                #end
                
                #if(i<=siz-2)
                cylinder{
                    <i,k,j>,<i+step,k,j>,rad
                    pigment{color Black}
                }
                #end
                
                #if(k<=siz-2)
                cylinder{
                    <i,k,j>,<i,k+step,j>,rad
                    pigment{color Black}
                }
                #end
                
                   
                #local percent=(j)/(siz-step)*100;
                
                
                object{kugel translate <i,k,j> pigment{color cs(percent)}}   
            #end
        #end 
    #end  
} 

object{sp translate <-siz/2,-4,-siz/2>}