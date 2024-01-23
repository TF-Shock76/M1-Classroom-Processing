public class Camera
{
  
  private ArrayList<Integer> touchesAppuyees;
  
  // Angle de la camera avec le sujet sur le plan XZ.
  private float theta;
  private float phi;
    
  private float vitesse = 10.0;
  
  private PVector position;
  private PVector direction;
  
  public Camera()
  {
    this.position = new PVector(0, 0, 0);
    this.theta = PI;
    this.phi = 0.0;
    
    this.direction = new PVector();
    this.chargerDirection();
    
    this.touchesAppuyees = new ArrayList<Integer>();
  }
  
  public void chargerDirection() {
    this.direction.x = sin(theta);
    this.direction.y = sin(phi);
    this.direction.z = cos(theta);
    this.direction.normalize();
  }
  
  public void bougerCamera()
  {
    PVector d = this.direction;
    PVector p = this.position;
    float mx, my;
    
    for(int k : touchesAppuyees)
    {     
      if(this.touchesAppuyees.contains(87)) p.add(new PVector(d.x, 0, d.z).normalize().mult(this.vitesse));
      else if(this.touchesAppuyees.contains(83)) p.add(new PVector(-d.x, 0, -d.z).normalize().mult(this.vitesse));
      else if(this.touchesAppuyees.contains(65)) p.add(new PVector(d.z, 0, -d.x).normalize().mult(this.vitesse));
      else if(this.touchesAppuyees.contains(68)) p.add(new PVector(-d.z, 0, d.x).normalize().mult(this.vitesse));
      else if(this.touchesAppuyees.contains(32)) p.add(new PVector(0, d.y, 0).normalize().mult(this.vitesse));  
      else if(this.touchesAppuyees.contains(16)) p.add(new PVector(0, -d.y, 0).normalize().mult(this.vitesse));  
    }
    
    float max = .05;
    mx = map(mouseX, 0, width, max, -max);
    my = map(mouseY, 0, height, -max, max);
    
    this.theta = (this.theta + mx) % TWO_PI;
    
    if (abs(this.phi + my) < PI / 2) this.phi += my; 
    
    this.chargerDirection();
    
    
    camera(
    p.x, p.y, p.z,
    p.x + d.x, p.y + d.y, p.z + d.z,
    0, 1, 0);
  }
}
  
void mouseWheel(MouseEvent event)
{
   PVector d = camera.direction;
   camera.position.add(new PVector(d.x, 0, d.z).normalize().mult(-event.getCount() * camera.vitesse));
}

void keyPressed()
{
  camera.touchesAppuyees.add(new Integer(keyCode));
}

void keyReleased()
{
  Integer keyInt = new Integer(keyCode);
  camera.touchesAppuyees.remove(keyInt);
}
