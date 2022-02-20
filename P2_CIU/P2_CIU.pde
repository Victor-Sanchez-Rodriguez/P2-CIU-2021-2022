PShape current_shape, previous_shape;
float fx1,fz1,fx2,fz2;
boolean enter_pressed, space_pressed, drawing_initiated;
ArrayList<PVector> coordinates;

void setup(){
  size(800,800,P3D);
  previous_shape=null;
  enter_pressed=false;
  space_pressed=false;
  drawing_initiated=false;
  reset_shape();
}

void draw(){
  if(drawing_initiated){
    if(!enter_pressed){
      draw_previous_revolution();
    }else{
      if(space_pressed){
        draw_revolution();
      }else{
        draw_shape();
      }
    }
    draw_text();
  }else{
    draw_presentation();
  } 
}

void draw_presentation(){
  textAlign(CENTER);
  text("Programa para dibujar figuras de revolucion",width/2,height/8); 
  text("Controles",width/2,height/3);
  text("ENTER: empezar a dibujar, o ver figura anterior",width/2,height/2.4);
  text("ESPACIO: Terminar dibujo y crear figura, o crear el siguiente dibujo",width/2,height/2.2);  
  text("Q: Volver a la pantalla de inicio",width/2,height/2);
  text("R: reiniciar el dibujo actual",width/2,height/1.5);
}

void draw_text(){
  textAlign(CENTER);
  text("Enter:ver figura anterior",100,height/8); 
  text("Espacio: acabar figura",100,height/7);
  text("R: reiniciar dibujo", 100,height/6);
  text("Q: Volver a inicio", 100,height/5);
}

void draw_revolution(){
  background(0);
  translate(mouseX,mouseY);
  stroke(255, 0, 0);
  shape(current_shape);   
}

void draw_shape(){
  background(0);
  stroke(255, 0, 0);
  for(int i=0;i<coordinates.size();i++){
    if(coordinates.size() > 1 && i > 0){
      draw_line(coordinates.get(i-1),coordinates.get(i));
    }
  }
}

void draw_previous_revolution(){
  background(0);
  if(previous_shape!=null){
    translate(mouseX,mouseY);
    stroke(255, 0, 0);
    shape(previous_shape);
  }else{
    textAlign(CENTER);
    text("no hay forma almacenada",width/2,height/2);
  }
}

void reset_shape(){
  coordinates = new ArrayList();
  background(0);
  stroke(255, 0, 0);
}

void draw_line(PVector v1, PVector v2){
  line(v1.x,v1.y,v2.x,v2.y);
}

void finish_revolution(){
  current_shape=createShape();
  current_shape.beginShape();
  current_shape.noFill();
  for(PVector x : coordinates){
    fx1=x.x;
    fz1=0;
    fx2=0;
    fz2=0;
    for(int i = 0;i < 37;i++){
      current_shape.vertex(fx1/2,(x.y-300)/2,fz1/2);
      fx2 = fx1*cos(radians(10))-fz1*sin(radians(10));
      fz2 = fx1*sin(radians(10))+fz1*cos(radians(10));
      fx1 = fx2;
      fz1 = fz2;
    }
  }
  for(int i = 0;i< 37;i++){  
    for(PVector x : coordinates){  
      fx1=0;
      fz1=0;
      fx1 = x.x*cos(radians(i*10))-fz1*sin(radians(i*10));
      fz1 = x.x*sin(radians(i*10))+fz1*cos(radians(i*10));
      current_shape.vertex(fx1/2,(x.y-300)/2,fz1/2);
    }
  }
  current_shape.endShape();
}


void keyPressed(){
  if (keyCode == ENTER){
    if (enter_pressed){
      enter_pressed=false;
      background(0);
      stroke(255, 0, 0);
    } else {
      if(!space_pressed){
        enter_pressed=true;
        background(0);
        stroke(255, 0, 0);
        reset_shape();
        if(!drawing_initiated){
          drawing_initiated=true;
        }
      }
    }
  }
  if (key == ' '){
    if(enter_pressed && drawing_initiated){
      if(space_pressed){
        space_pressed=false;
        previous_shape=current_shape;
        reset_shape();
      }else{
        space_pressed=true;
        finish_revolution();
      }
    }
  }
  if (key == 'q' || key == 'Q'){
    if(drawing_initiated){
      drawing_initiated=false;
      enter_pressed=false;
    }
  }
  if (key == 'r' || key == 'R'){
    if(drawing_initiated){
      reset_shape();
    }
  }
}

void mousePressed() {
  if(drawing_initiated && enter_pressed && !space_pressed){
     coordinates.add (new PVector (mouseX, mouseY));
  }
}
