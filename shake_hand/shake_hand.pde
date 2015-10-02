import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;

Target ball;
PVector currentHand, previousHand,previousHand0;

void setup(){
  size(500,1000, OPENGL);
  ball= new Target();
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand");
  previousHand0=new PVector();
  previousHand=new PVector();
  currentHand=new PVector();
  }

void draw (){
  kinect.update();
  if (ball.fits()){
    background(255-ball.c, 255-ball.c, 255-ball.c);    
  }
  else{
    background(255);
    noStroke();
    fill(200);
    ellipse(width/2,height-50,98,98);
    line(0, height, 0, width/2);
    ball.update(previousHand0,currentHand);
  }
  ball.display();

}



void onCreateHands(int handId, PVector position, float time){
  println("vrika");
  kinect.convertRealWorldToProjective(position, position);
  previousHand0=position.get();
  previousHand=position.get();
  currentHand=position.get();
}

void onUpdateHands(int handId, PVector position, float time){
  kinect.convertRealWorldToProjective(position, position);
  previousHand0=previousHand.get();
  previousHand=currentHand.get();
  currentHand=position.get();
}

void onDestroyHands(int handId, float time){

  println("byebye");
  kinect.addGesture("RaiseHand");
    previousHand0=new PVector();
  previousHand=new PVector();
  currentHand=new PVector();
}

void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition){
  kinect.startTrackingHands(endPosition);
  kinect.removeGesture("RaiseHand");
}

