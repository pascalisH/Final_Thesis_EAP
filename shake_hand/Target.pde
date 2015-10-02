class Target {

  PVector position,velocity, acceleration, mouseForce, gravity;
  float mass;
  int size;
  float c;

  
  Target(){
    position=new PVector (width/2,height);
    velocity=new PVector (0,0);
    acceleration=new PVector (0,0);
    mouseForce=new PVector (0,0);
    gravity=new PVector (0,-0.7);
    mass=0.3;
    size=20;
    c = 255;
  }
  

   
  void update(PVector previous, PVector current){
    
    float distance= PVector.dist(previous, current);
    mouseForce.y=map(distance,0,50,0,2);
    println(gravity.y, size);
    mouseForce.y=constrain(mouseForce.y,0,4.8);
    gravity.y=constrain(gravity.y,-5,-0.5);
    acceleration.add(gravity);
    acceleration.add(mouseForce);
    velocity.add(acceleration);
    velocity.y=constrain(velocity.y,-10,20);
    position.y=constrain(position.y-velocity.y,0,height);
    
    //println(mouseForce.y,acceleration.y,velocity.y,position.y);
    acceleration.mult(0);
    

    
   
    
    if (position.y >= height-size/2) {
      velocity.y *= -0.4;
      position.y=height-size/2;
    }
    if (position.y == 0) {
      velocity.y *= -0.4;
      gravity.y-=mass;
      size+=13;
      mass+=0.2;
    }
   

}
  void display(){
    noStroke();
    fill(c,0,0);
    ellipse(position.x, position.y, size, size);
  }
    
  boolean fits(){
    boolean result = false;
    if ((size>=98)&& (position.y> height-55)){
      result = true;
      if (c>0)
        c -= 5;
    }
    return result;
  }

  
}
