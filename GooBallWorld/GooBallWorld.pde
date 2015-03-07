import teilchen.Physics;
import teilchen.util.CollisionManager;

float gooRadius = 25;

Physics physics;

GooBallColony gooBallColony;

CollisionManager collision;

PImage petriDish;

void setup() {  
  size(750, 750);
  background(23, 68, 250);
  frameRate(30);
  
  physics = new Physics();

  collision = new CollisionManager();
  collision.minimumDistance(50); 

  gooBallColony = new GooBallColony(physics, collision); 

  petriDish = loadImage("petriDish.png");
}

void draw() {
  collision.createCollisionResolvers();
  collision.loop(1.0 / frameRate);
  physics.step(1.0f / frameRate);
 
  background(23, 68, 250);

  //gooBallColony.update();
  gooBallColony.draw();
  collision.removeCollisionResolver(); 

  imageMode(CENTER);
  image(petriDish, width/2, height/2);

}

void mousePressed(){
  gooBallColony.event(mouseX, mouseY);
}

void keyPressed(){
  gooBallColony.event(key);

}
