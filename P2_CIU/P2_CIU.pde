float ball_posX, ball_posY, pos_p1, pos_p2, ball_speed, ball_dirX, ball_dirY;
int score1, score2;
boolean enter_pressed;
float mov_p1=0;
float mov_p2=0;

void setup(){
  enter_pressed=false;
  size(800,800);
}

void draw(){
  background(128);
  if(enter_pressed){
    
    textAlign(CENTER,CENTER);
    text(score1+"          "+score2,width/2,height/10);
    fill(0,128,0);
    circle(ball_posX,ball_posY,40);
    fill(128,0,0);
    rect(45,pos_p1,10,60);
    fill(0,0,128);
    rect(755,pos_p2,10,60);
    
    pos_p1=pos_p1+(mov_p1*2.5);
    if(pos_p1<0) pos_p1=0;
    if(pos_p1>740) pos_p1=740;
    pos_p2=pos_p2+(mov_p2*2.5);
    if(pos_p2<0) pos_p2=0;
    if(pos_p2>740) pos_p2=740;
    
    if(ball_posX < 70 && ball_posX > 45){
      if(ball_posY+8>pos_p1 && ball_posY-68<pos_p1){
        ball_dirX=1;
        if(ball_posY-45>pos_p1){
          ball_dirY=ball_dirY+0.2;
          ball_speed=ball_speed-0.2;
          if(ball_speed<1) ball_speed=1;
          if(ball_dirY>10) ball_dirY=10;
        } else if(ball_posY-25<pos_p1){
          ball_dirY=ball_dirY-0.2;
          ball_speed=ball_speed-0.2;
          if(ball_speed<1) ball_speed=1;
          if(ball_dirY<-10) ball_dirY=-10;
        } else{
          ball_speed=ball_speed+0.5;
          if(ball_speed>10)ball_speed=10;
        }
      }
    } else if(ball_posX > 730 && ball_posX < 755){
      if(ball_posY+8>pos_p2 && ball_posY-68<pos_p2){
        ball_dirX=-1;
        if(ball_posY-45>pos_p2){
          ball_dirY=ball_dirY+0.2;
          ball_speed=ball_speed-0.2;
          if(ball_speed<1) ball_speed=1;
          if(ball_dirY>10) ball_dirY=10;
        } else if(ball_posY-25<pos_p2){
          ball_dirY=ball_dirY-0.1;
          ball_speed=ball_speed-0.2;
          if(ball_speed<1) ball_speed=1;
          if(ball_dirY<-10) ball_dirY=-10;
        } else{
          ball_speed=ball_speed+0.5;
          if(ball_speed>10)ball_speed=10;
        }
      }
    } else if(ball_posX > 780){
      score1 = score1+1;
      resetGame();
    } else if(ball_posX < 20){
      score2 = score2+1;
      resetGame();
    }
    if(score1 == 10 || score2 ==10){
      noLoop();
      finishScreen();
    }
      
    if(ball_posY<20) ball_dirY=abs(ball_dirY);
    if(ball_posY>780) ball_dirY=-abs(ball_dirY);
    
    ball_posX=ball_posX+ball_dirX*ball_speed;
    ball_posY=ball_posY+ball_dirY*ball_speed;
    
  }else{
    textAlign(CENTER);
    text("Bienvenido al juego de PONG",width/2,height/8); 
    text("Controles",width/2,height/3);
    text("Teclas UP/DOWN:     Mover al jugador 2 (derecho)",width/2,height/2.4);
    text("Teclas W/S:     Mover al jugador 1 (izquierdo)",width/2,height/2.2);  
    text("Enter:     Iniciar / Volver a esta pantalla",width/2,height/2);
    text("Pulsa enter para iniciar\n",width/2,height/1.5);
  } 
}

void finishScreen(){
  background(128);
  textAlign(CENTER,CENTER);
  if(score1==10) text("¡Ha ganado el jugador 1!",width/2,height/6);
  if(score2==10) text("¡Ha ganado el jugador 2!",width/2,height/6);
  text("Para volver a jugar, pulse enter",width/2,height/3);
}

void resetScore(){
  score1=0;
  score2=0;
}

void resetGame(){
  ball_posX=400;
  ball_posY=400;
  pos_p1 = 400;
  pos_p2 = 400;
  ball_speed = 1;
  ball_dirX = 1;
  ball_dirY = 0;
  if(random(100)>50){
    ball_dirX=-1;
  }
}

void keyPressed(){
  if (keyCode == ENTER){
    if (enter_pressed){
      enter_pressed=false;
    } else {
      enter_pressed=true;
      loop();
      resetGame();
      resetScore();
    }
  }
  if (keyCode == UP) mov_p2=-1;
  if (keyCode == DOWN) mov_p2=1;
  if (key == 'w' || key == 'W') mov_p1=-1;
  if (key == 's' || key == 'S') mov_p1=1;
}

void keyReleased(){
  if (keyCode == UP || keyCode == DOWN) mov_p2 = 0;
  if (key == 'w' || key == 's') mov_p1 = 0;
}
