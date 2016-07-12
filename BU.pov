#include "textures.inc"
#include "colors.inc"
#include "shapes3.inc"
 
camera {
    fisheye 
    location <-1, 3.1, -21> 
    look_at  <-0.9, 3.3, -16>
    angle 55
} 

//------------------------- 
//---------- chão ---------
//-------------------------
plane { <0, 1, 0>, -1 
    pigment {
        cells scale 1.5
        color_map { [0.0 color rgb <1,1,.9>]
                    [1 color rgb <.9,.85,.7>]
        } // end of color_map
    } // end of pigment
    finish {ambient .3 diffuse .2}
}

//------------------------- 
//---------- teto ---------
//-------------------------
#declare placa_saida = object{ 
    union{
        box {<0,0,0> <10,6,1.5> 
            texture{ pigment{ color Red }
            } // end of texture
        }
        box {<1,0.5,-0.01> <9,5,0> 
            texture{ pigment{ color Gray30 }
            } // end of texture
        }
        text { ttf "arial.ttf", "SAIDA", 0.02, 0.0 // thickness, offset
            texture{ pigment{ color rgb Red} 
                finish { phong 0.1 }
            } // end of texture
            scale 2.5
            translate <1.2,2,-0.02>
        } // end of text object 
    } // end of union
    rotate<0,60,0>
    scale 0.1
} // end of object

object {
    union {
        plane { <0, 1, 0>,5.1
            pigment{
                pavement  //  pavement pattern in the xz plane 
                number_of_sides 3 //  3 triangle,  4 quadrat, 6 hexagon
                number_of_tiles 4 //  (1 to 5 or 6): the number of basic tiles to combine together  to make one real tile
                pattern 1 // maximum depends from  number_of_sides and  number_of_tiles
                exterior 0 //  0, 1 or 2; Not used for hexagon.  
                interior 0  // 0, 1 or 2  
                form 0//  0, 1 or 2, (3 for square only) copies the look of interior for some additional variations. 
                color_map{
                    [ 0.95 color rgb<1, 0.9, 0.80> ] 
                    [ 0.95 color rgb<0.85, 0.75, 0.75> ] 
                } // end color_map
                scale 1.4
                rotate 60*y
                translate -0.65*x
                translate -0.2*z
            } // end pigment
            finish {ambient .4 diffuse .3}
        } // end plane
        object {placa_saida translate <-5,4.5,0>}
    } // end union
}// end object


//------------------------- 
//--------- fundo ---------
//-------------------------
plane { <0, 0, 1>, 35
    rotate -50*y
    texture{ pigment{ color rgb<1,1,1> }
        normal { pigment_pattern{
            average pigment_map{[1, gradient z sine_wave]
                [1, gradient y scallop_wave]
                [3, bumps  ]}
            translate 0.02 scale 0.5}
            rotate< 0,0,0> scale 0.15
        } // end normal
    finish { phong 1 reflection{ 0.2 } }
    } // end of texture
}
    
//------------------------- 
//------ prateleiras ------
//-------------------------
#declare plaquinha = object {
    union {
        box {<0, 3.2, -0.01> <1.3, 3.5,-0.01>
            texture { pigment {color Blue}
                finish {diffuse .2}
            } //end of texture
        } //end of box
        box {<0, 2, -0.01> <1.3, 3.2,-0.01>
            texture { Polished_Chrome
            } //end of texture
        } //end of box
        box {<0.1, 2.3, -0.01> <0.6, 3.2,-0.011>
            texture { pigment {color White}
            } //end of texture
        } //end of box
        box {<0.7, 2.3, -0.01> <1.2, 3.2,-0.011>
            texture { pigment {color White}
            } //end of texture
        } //end of box
    }//end of union
} //end of object

#declare prateleira = object {
    union{
        //for (Identifier, Start, End [, Step])
        //vertical
        #for(I,0,24, 4)
            box { <0, -1, 0+I> <1.3, 4.2, 0.3+I>
            
            } //end of box
        #end
        //horizontal
        #for(I,0,5, 1)
            box { <0.1, -1+I, 0.1> <1.2, -0.85+I, 23>
                texture{ Chrome_Metal
                    finish {ambient .1 diffuse .8 phong .1}
                } //end of texture
            } //end of box
        #end
        object {plaquinha}
        //buracos
        #for(I, 1, 5)
            #for(J, 0, 3)
                box { <0+J/3, -0.5+I/2.5, -0.01> <0.2+J/3, -0.43+I/2.5,-0.011>
                texture { pigment {color rgb< 0.75, 0.5, 0.30>*0.15 } // very dark brow
                } //end of texture
            } //end of box
            #end
        #end
    }//end of union
} //end of object

//13 primeiras prateleiras amarelas
#local Cntr = 0; 
#local espacamento = 2.2;
#local rotacao = 2;  
#while ( Cntr < 13 )
    object { prateleira
        rotate (-28 + Cntr * rotacao)*y                                     
        translate <(-11 + Cntr * espacamento),0, 3 + Cntr*3>
        texture{ pigment {color BrightGold}
            finish {ambient .3 diffuse .1}
        } //end of texture
    } //end of object
    #local Cntr = Cntr + 1; // next
#end

//5 últimas prateleiras amarelas
#while ( Cntr < 18 )
    object { prateleira
        rotate (-28 + Cntr * rotacao)*y
        translate <(-9 + Cntr * espacamento),0, 3 + Cntr*3>
        texture{ pigment {color BrightGold}
            finish {ambient .3 diffuse .1}
        } //end of texture
    } //end of object
    #local Cntr = Cntr + 1;
#end       
           
//4 últimas prateleiras pretas
#while ( Cntr < 22 )
    object { prateleira
        rotate (-28 + Cntr * rotacao)*y
        translate <(-7 + Cntr * espacamento),0, 3 + Cntr*3>
        texture{ pigment {color DarkSlateGray}
            finish {ambient .3 diffuse .1}
        } //end of texture
    }//end of object
    #local Cntr = Cntr + 1;
#end        

//------------------------- 
//--------- parede --------
//-------------------------
box { <5, -1, -6.8> <5, 7, -10> rotate -50*y
    texture { pigment {color Goldenrod}
        finish {ambient .5 diffuse .2}
    } //end of texture
} //end of box

//------------------------- 
//----  mesa da parede ----
//-------------------------
object{
    union{
        box { <5.5, -1, -6.8> <10, 0.65, -5.5>
            rotate -50*y
            
        } //end of box
        //parte de cima
        box { <5, 0.6, -6.8> <10, 0.65, -5.4>
            rotate -50*y
            
        } //end of box
    } //end of union
    texture {pigment {color NewTan}
                finish {ambient .5 diffuse .2}
            } //end of texture
} //end of object

//------------------------- 
//-------  extintor -------
//-------------------------
object {
    union{
        cylinder {<7.6, 2.5, -4.5> <7.6, 3.2, -4.5> 0.15
            texture {pigment {color Red}
            } //end of texture
        } //end of cylinder
        
        cone{ <7.6, 3.2, -4.5> ,0.15,<7.6, 3.4, -4.5>,0.05 
            texture {pigment {color Red}
            } //end of texture
        } // end of cone 

        //major radius, minor radius, height H, angle (in degrees)
        object{Segment_of_CylinderRing(0.16, 0.1, 0.4, 90)
            texture{ Pine_Wood
            } // end of texture 
            rotate 60*y
            translate<7.6,2.75,-4.5>      
        } // end of object
              
        object{ Round_Conic_Torus( 0.3, 0.2, 0.05, 0.02,0 )
            texture{ pigment{ color Black}
            } // end of texture
            rotate 60*x
            translate<7.6, 3.4, -4.5>
       }  // end of object
    } //end of union
} //end of object

//------------------------- 
//-------  lixeira --------
//-------------------------
object{
    union{
        cone { <0,-1,0>, 0.25
               <0,-0.85,0>, 0.27
            texture {pigment { color Flesh}
                finish {ambient .4 diffuse .3}
            } //end of texture
            translate <-4.9,0,-8.4>
        } //end of cone
        cone { <0,-0.85,0>, 0.27
               <0,-0.5,0>, 0.3
            texture {pigment {
                checker pigment{Feldspar} scale 0.05
                } //end of pigment
            } //end of texture
            translate <-4.9,0,-8.4>
        } //end of cone
        cone { <0,-0.5,0>, 0.3
               <0,-0.35,0>, 0.33
            open
            texture {pigment { color Black}
            } //end of texture
            translate <-4.9,0,-8.4>
        } //end of cone
        
        
    } //end of union
} //end of object

//------------------------- 
//-----  mesa redonda -----
//-------------------------      
#declare mesaredonda = object {
#local altura = 0.65; 
    union {
        object{
            Disk_Y // no open available!
            texture { pigment {color NewTan}
                finish {ambient .5 diffuse .3}
            } // end of texture
            scale <1.6, .05, 1>
            translate<8, altura, 6>
        } //end of object
        
        // pé central
        cylinder {<8, altura, 6> <8, -1, 6> 0.08 texture {pigment {color Black}}}
        
        // pés laterais
        #for (Cntr, 1, 5)
            cylinder {<8, -1, 6> <9, -1, 6> 0.08
            Rotate_Around_Trans(<0,72 * Cntr,0>, <8,-1,6>)
            texture {pigment {color Black}}
            } // end of texture
        #end
    } //end of union
} //end of object

object {mesaredonda translate <-3,0,2>}
object {mesaredonda translate <2,0,8>}

//------------------------- 
//----- mesa quadrada -----
//-------------------------  
#declare mesaquadrada = object {
#local altura = 0.65;  
union {
    box { <1, altura, -0.5> <5, altura+0.15, 3>
        texture {pigment {color NewTan}
            finish {ambient .5 diffuse .2}
        } //end of texture
        rotate -35*y
    } //end of box      
    cylinder {<2.2, -1, 1.3> <2.2, altura, 1.3> 0.08
        texture {pigment {color Black}}
        } //end of texture
    #for (Cntr, 1, 4)
        // pés laterais
        cylinder {<2.2, -1, 1.3> <3.6, -1, 1.3> 0.08
        Rotate_Around_Trans(<0, 90*Cntr, 0>, <2.2, 1, 1.3>)
        texture {pigment {color Black}}
        } //end of texture
    #end     
    } //end of union
} //end of object
  
 
#declare pilha_folhas = object {
    box {<-5.2, altura+0.1, -4> <-6.2, altura+0.14, -2.5>
        texture{ pigment {color White}
        } //end of texture
        rotate -35*y  
        
    } //end of box
} //end of object 

object {
    union{
        object { mesaquadrada
            translate <-5.5,0,-9.5>
        } //end of object
        #for(I, 0, 4)
            object { pilha_folhas
                finish {ambient I/10} 
                rotate I*y
                translate <0,0.01+(I/40),0>
            } //end of object
        #end
    } //end of union
} //end of object
    
     
//------------------------- 
//-------- luzes ----------
//-------------------------
#declare lampada = object {    
    union {
        //2 lampadas
        cylinder {<0, 0, 0> <2, 0, 0> 0.06}
        cylinder {<0, 0, 0.15> <2, 0, 0.15> 0.06}
        
        //acabamento frente
        cylinder {<2, 0, 0> <2.01, 0, 0> 0.05
            texture { Chrome_Metal
                finish {ambient 0.5}
            } //end of texture
        } //end of cylinder
        cylinder {<2, 0, 0.15> <2.01, 0, 0.15> 0.05
            texture { Chrome_Metal
                finish {ambient 0.5}
            } //end of texture
        } //end of cylinder
        
        //acabamento trás
        cylinder {<0, 0, 0> <0.01, 0, 0> 0.05
            texture { Chrome_Metal
                finish {ambient 0.5}
            } //end of texture
        } //end of cylinder
        cylinder {<0, 0, 0.15> <0.01, 0, 0.15> 0.05
            texture { Chrome_Metal
                finish {ambient 0.5}
            } //end of texture
        } //end of cylinder
        
        difference {
            object{ Column_N_AB( 6, <0,0,0>,<2,0,0>, 0.17 )  
            } // end of object
            box{ <-5,-2,-5>,<5,0,5>}
            texture { pigment {color Gray70}
                finish {ambient 0.5}
            } //end of texture
            translate -0.04*y
            translate 0.06*z
        }//end of difference              
                                           
        texture {pigment {color White}
            finish {ambient 1}
        } //end of texture
    } //end of union
    rotate 60*y
} //end of object

//3 luzes frente   
#for (Cntr, 0, 2)
    light_source { <-2.5, 5,-15> color White
        spotlight
        radius 1 
        translate Cntr*1.2*x
        translate (Cntr*2.2)*z
        area_light <1, 0, 0> <0, 0, 1>
        2,2 // numbers in directions
        looks_like {lampada }
    } //end of light_source
#end

//luz perdida no meio
light_source { <-0.5, 5,-8.3> color White
    spotlight
    radius 1 
    area_light <1, 0, 0> <0, 0, 1>
    2,2 // numbers in directions
    looks_like {lampada }
    Rotate_Around_Trans(<0, 62, 0>, <1, 5,-10>)
} //end of light_source

//luzes trás
#local CntrX = -8;
#local CntrY = 5;
#local CntrZ = -10;
#for (Cntr2, 0, 6)   
    #for ( Cntr, 0 ,3)        
        light_source { <CntrX, CntrY,CntrZ> color White     
        spotlight
        radius 1
        translate Cntr*-5.5*x
        translate Cntr*-0.7*z
        area_light <4, 0, 0> <0, 0, 4>
        4,4 // numbers in directions
        looks_like {lampada  
        Rotate_Around_Trans(<0, 72, 0>, <CntrX, CntrY,CntrZ>)} }   
     #end 
    #local CntrX = CntrX+3;
    #local CntrZ = CntrZ+6;
 #end          
          
//------------------------- 
//-------- cadeira --------
//-------------------------
//baseado em http://www.f-lohmueller.de/pov_tut/objects/arc_int/Chair_s00demo.pov
#declare textura_cadeira =
    texture {
        pigment{color rgb< 0, 0, .8>}  
    finish {ambient 0.1 diffuse 0.1} 
} // end texture   

#declare cadeira = object{   
    #local altura_cadeira = 0.63; 
    #local altura_assento = 0.33;
    #local largura = 0.225;
    #local raio_pe = 0.015;
        
    #local CR = raio_pe;
    #local CW = largura - CR; 
    #local CH = altura_cadeira - CR; 
    #local SH = altura_assento - CR; 
    
    #local SW = largura; 
    #local ST = 2*CR;     
    
    union{ // total union
        union{
            // assento
            box { <-CW, 0.00, -CW>,< CW, 0, CW>  translate<0,SH,0> }  
            // arames dos pés da frente
            cylinder { <0,0,0>,<0,SH,0>, CR translate< CW,0,-CW> pigment {color Black}} 
            cylinder { <0,0,0>,<0,SH,0>, CR translate<-CW,0,-CW> pigment {color Black}}
            // arames do assento
            cylinder { <-CW,0,  0>,< CW,0, 0>, CR  pigment {color Black} translate<0,SH, CW> }
            cylinder { <-CW,0,  0>,< CW,0, 0>, CR  pigment {color Black} translate<0,SH,-CW> }
            cylinder { <  0,0,-CW>,<  0,0,CW>, CR  pigment {color Black} translate< CW,SH,0> }
            cylinder { <  0,0,-CW>,<  0,0,CW>, CR  pigment {color Black} translate<-CW,SH,0> }
            // arames dos pés de trás
            cylinder { <0,0,0>,<0,CH-CR*2,0>, CR pigment {color Black} translate< CW,0, CW> }
            cylinder { <0,0,0>,<0,CH-CR*2,0>, CR pigment {color Black} translate<-CW,0, CW> }
            //arames do chão
            cylinder { <  0,0,-CW>,<  0,0,CW>, CR  pigment {color Black} translate<CW,0,0> }
            cylinder { <  0,0,-CW>,<  0,0,CW>, CR  pigment {color Black} translate<-CW,0,0> }
        }// end of union    
        // encosto do capeta
        object{
            union{
                object{ Disk_Z // no open available!
                scale <CW, 0.12, CR>
                scale <.9, .9, 1.01>
                texture{ textura_cadeira} 
                translate<0, 0.55 ,0.2>}
            object{
                difference{
                    object{
                        Disk_Z
                        scale <CW, 0.12, CR>
                        
                        pigment {color Black}  
                        translate<0, 0.55 ,0.2>}
                    object{
                        Disk_Z
                        scale <CW, 0.12, CR>
                        scale <.9, .9, 1.01>
                        pigment {color White} 
                        translate<0, 0.55 ,0.2>}
                   }// end of difference
                }// end of object
            } // end of union
        } // end of disc 
    }// end of total union    
    texture{ textura_cadeira } 
    scale <3,2.8,2.6>        
} // end of cadeira           
            
//cadeiras mesa quadrada
#local Cntrx = 1.4;
#local Cntrz = 1;  
//cadeiras de trás     
object {cadeira
        rotate -30*y
        translate< -4.3,-1,-4.6>
}
object {cadeira
        rotate -30*y
        translate< -4.3-Cntrx,-1,-4.6-Cntrz>
}
//cadeiras da frente
object {cadeira
        rotate -220*y
        translate<-3.6,-1,-9.1>
}
object {cadeira
        rotate -220*y
        translate<-3.6+Cntrx,-1,-9.1+Cntrz>
}

//cadeiras primeira mesa redonda
object {cadeira
        rotate -220*y
        translate< 6,-1,6>
}
object {cadeira
        rotate -60*y
        translate< 4,-1,9>
}
object {cadeira
        rotate -180*y
        translate< 4.5,-1,6.5>
}
object {cadeira
        rotate 30*y
        translate<6,-1,10>
}

//cadeiras última mesa redonda
//frente  

object {cadeira
        rotate -130*y
        translate<8,-1,11>
} 
//trás
object {cadeira
        rotate 60*y
        translate<11.5,-1,16>
}
//esquerda
object {cadeira
        rotate -30*y
        translate<8.6,-1,14.5>
}   
//direita
object {cadeira
        rotate 160*y
        translate<10.5,-1,12.5>
}

//cadeiras mesa parede
object {cadeira
        rotate -50*y
        translate<8,-1,1.6>
}
object {cadeira
        rotate -50*y
        translate<9,-1,2.6>
}
object {cadeira
        rotate -50*y
        translate<11.7,-1,7>
}
object {cadeira
        rotate -50*y
        translate<13.1,-1,9>
}