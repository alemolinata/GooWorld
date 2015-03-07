class GooBall extends Creature {
  
  int gooBallFrameCounter = 0;
  public int id;
  ArrayList<Integer> connectedTo = new ArrayList<Integer>();
  //ArrayList<Spring> gooBallConnectors = ArrayList<Spring>();

  public GooBall(int x, int y, int r, int theId) {
    super(x, y, r);
    ellipseMode(RADIUS);
    id = theId;
  }  
  
  public void draw_shape(){
    fill(255, 80);
    strokeWeight(2);
    stroke(255);
    ellipse(0, 0, radius(), radius());
    if(gooBallFrameCounter >= 20){
      line(radius()/4*-1, radius()/3*-1, radius()/4*-1, radius()/2*-1);
      line(radius()/4*-1, radius()/3, radius()/4*-1, radius()/2);
    }
    else{
    	fill(255, 200); 
    	ellipse(radius()/4*-1, radius()/3*-1, radius()/5, radius()/5); 
    	ellipse(radius()/4*-1, radius()/3, radius()/5, radius()/5); 
    }
    gooBallFrameCounter++;
    if(gooBallFrameCounter >= 24){
    	gooBallFrameCounter = 0;
    }
  }
  
  public boolean inside(int mx, int my) {    
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
  
  public void addConnections(int connectedId){
    connectedTo.add(connectedId);
  }

  public boolean isConnected(int connectedId){
    for ( int i = 0; i < connectedTo.size(); i ++ ){
      if (connectedTo.get(i) == connectedId) return true;
    }
    return false;
  }

  public int countConnections(){
    return connectedTo.size();
  }

  public int getId(){
    return id;
  }
};
