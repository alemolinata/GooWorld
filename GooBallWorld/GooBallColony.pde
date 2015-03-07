import teilchen.force.Spring;
import teilchen.behavior.Wander;
import teilchen.behavior.Motor;
import teilchen.behavior.Wander;

import teilchen.util.CollisionManager;

int idCounter = 0;
int frameCounter = 0;

int radius = 25;
int maxConnections = 3;

class GooBallColony {

  ArrayList<GooBall> gooBalls = new ArrayList<GooBall>(); 
  ArrayList<Spring> connectors = new ArrayList<Spring>();
  
  CollisionManager collision;

  Physics physics;

  Wander wander;
  
  public GooBallColony( Physics p, CollisionManager c ) {
    gooBalls = new ArrayList<GooBall>();
    physics = p;
    collision = c;
  }

  public void add(GooBall gb) {

    GooBall g = gb;
    GooBall h = g;
    
    for(int i = 0; i < gooBalls.size(); i++) {
      h = gooBalls.get(i);
      
      if(dist( h.position().x, h.position().y, g.position().x, g.position().y ) < radius*6){
        if( g.id != h.id && g.isConnected(h.getId()) == false &&
            g.countConnections() <= maxConnections && h.countConnections() <= maxConnections ){
          Spring spring = physics.makeSpring(g, h, 10.0, 0.1, radius*3);
          connectors.add(spring);
          h.addConnections(g.id);
          g.addConnections(h.id);
        }
      }
    }

    physics.add(g);
    collision.collision().add(g);
    gooBalls.add(g);    
  }

  public void draw(){
    if(frameCounter % 30 == 0) update();

    for(int i = 0; i < connectors.size(); i++) {
      Spring connector = connectors.get(i);
      stroke(255, 80);
      strokeWeight(2);
      line( connector.a().position().x, connector.a().position().y,  connector.b().position().x, connector.b().position().y );
    }
    for(int i = 0; i < gooBalls.size(); i++) {
      Creature g = gooBalls.get(i);
      g.display();
    }
    frameCounter ++;
  }

  public void remove(Creature c) {
    // todo
  }
  
  public void update() {
    //println(gooBalls.size());    //connectors.clear();
    GooBall gb = new GooBall(0,0,0, 0);
    GooBall h = gb;

    println(gooBalls.size());
    for(int i = 0; i < gooBalls.size(); i++) {
      gb = gooBalls.get(i);

      // remove gooballs from the array that are more than 200 px away from the window edges in any x or y position.
      if (gb.position().x > width+200 || gb.position().x < -200 || gb.position().y > height+200 || gb.position().y < -200){
        gooBalls.remove(i);
      }

      for(int j = 0; j < gooBalls.size(); j++) {
        h = gooBalls.get(j);

        if(dist( h.position().x, h.position().y, gb.position().x, gb.position().y ) < radius*6){
          if( gb.id != h.id && gb.isConnected(h.getId()) == false && 
              gb.countConnections() < maxConnections && h.countConnections() < maxConnections ){
            
            Spring spring = physics.makeSpring(gb, h, 10.0, 0.1, radius*3);
            connectors.add(spring);
            h.addConnections(gb.id);
            gb.addConnections(h.id);
          }
        }
      }
    }
  } 

  public void event(int x, int y){
    int mx = x;
    int my = y;

    GooBall g = new GooBall(mx, my, radius, idCounter);
    idCounter ++;

    Wander wander = new Wander();
    g.behaviors().add(wander);      
    
    Motor motor = new Motor();
    motor.auto_update_direction(true);
    motor.strength(0.01f);
    g.behaviors().add(motor);
    
    physics.add(g);
    add(g);
  }

  public void event(int c){
    if( c == 'q' || c == 'Q' || c == ' ') {

      GooBall g = new GooBall((int)random(50, width-50), (int)random(50, height-50), radius, idCounter);
      idCounter ++;

      Wander wander = new Wander();
      g.behaviors().add(wander);      
      
      Motor motor = new Motor();
      motor.auto_update_direction(true);
      motor.strength(0.01f);
      g.behaviors().add(motor);
      
      physics.add(g);
      add(g);
    }
    if( c == 'x' || c == 'X' ) {
      maxConnections = 3;
      gooBalls.clear();
      connectors.clear();
    }
    if( c == 'p' ){
      if(maxConnections == 10){
        maxConnections = 3;
      } 
      else maxConnections = 10;
    }
  }
}