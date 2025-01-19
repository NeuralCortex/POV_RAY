#include "colors.inc"                                   
#include "textures.inc"   
#include "stars.inc"

#declare hor_res=1920;
#declare ver_res=1080;
             
#declare stepping=10;             
#declare basis=7.0;
#declare r=7;      
#declare cyl_rad=0.02;  
#declare cyl_color=color White;
#declare d=r*2.0;
#declare w=10;
#declare h=3; 
#declare zero=r-h;

#declare s = seed(12345);

camera {
    location <10, 10, -25>
    look_at  <0, 0,  0>  
    right hor_res/ver_res*x
}   

light_source { <2, 5, -20> color White}   

//background {color Black}  

sky_sphere
{
    pigment
        {
                granite
                color_map
                {
                        [ 0.000  0.270 color rgb < 0, 0, 0> color rgb < 0, 0, 0>
]    // BLACK
                        [ 0.270  0.2701 color rgb <.5,.5,.4> color rgb
<.8,.8,.4> ]    // YELLOW STARS DIM TO BRIGHT (0.270-)
                        [ 0.2701  0.470 color rgb < 0, 0, 0> color rgb < 0, 0,
0> ]    // BLACK
                        [ 0.470  0.4701 color rgb <.4,.4,.5> color rgb
<.4,.4,.8> ]    // BLUE STARS DIM TO BRIGHT (0.470-)
                        [ 0.4701  0.680 color rgb < 0, 0, 0> color rgb < 0, 0,
0> ]    // BLACK
                        [ 0.680  0.6801 color rgb <.5,.4,.4> color rgb
<.8,.4,.4> ]    // RED STARS DIM TO BRIGHT (0.680-)
                        [ 0.6801  0.880 color rgb < 0, 0, 0> color rgb < 0, 0,
0> ]    // BLACK
                        [ 0.880  0.8801 color rgb <.5,.5,.5> color rgb < 1, 1,
1> ]    // WHITE STARS DIM TO BRIGHT (0.880-)
                        [ 0.8801  1.000 color rgb < 0, 0, 0> color rgb < 0, 0,
0> ]    // BLACK
                }
                turbulence 8
                sine_wave
                scale 10
        }
}

#declare earth=union{    
    
    sphere{
        <0,0,0>,6
        pigment{
            image_map{jpeg "world.jpg" map_type 1} 
        }
    }   
    
    sphere{
        <0,0,0>,6.5
         pigment {
            bozo
            turbulence 0.65
            octaves 6
            omega 0.7
            lambda 2
            color_map {
                [0.0 0.1 color rgb <0.85, 0.85, 0.85>
                         color rgb <0.75, 0.75, 0.75>]
                [0.1 0.5 color rgb <0.75, 0.75, 0.75>
                         color rgbt <1, 1, 1, 1>]
                [0.5 1.0 color rgbt <1, 1, 1, 1>
                         color rgbt <1, 1, 1, 1>]
            }
        }
    } 
     
    
    sphere{ 
        0,7 pigment { rgbt 1 } hollow
        interior{
             media{
                emission 0.1
                density{
                    spherical density_map{ 
                       [0 rgb<0,0,1> ]
                       [0.2 rgb <0,1,0>]
                       [0.8 rgb <1,0,0>]
                       [1 rgb 1]
                    }
                } 
                scale 7
            }
             media{
                //absorption 5
             }
        }  
        //scale 8
    }  
} 

object{earth rotate <0,-90,0> scale 1.3}