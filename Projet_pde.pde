PShader textureShader;

PImage white;

Camera camera;


PVector[] lightPos;

PVector[] lightColor;


void setup() {
  size(1400, 720, P3D);
  textureShader = loadShader("TextureFrag.glsl", "TextureVert.glsl");
  shader(textureShader);
  lightPos = new PVector[] { 
    new PVector(0, 0, 0),
    new PVector(-dimensionSalle.y/2, 0, -dimensionSalle.x/2),
    new PVector(dimensionSalle.y/2, 0, dimensionSalle.x/2)
  };
    
  lightColor = new PVector[] {
    new PVector(130, 130, 130),
    new PVector(130, 130, 130),
    new PVector(130, 130, 130)
  };
  
  white = loadImage("white.png");
  //Initialise la salle
  initSalle();
  //Initialise les rangées de tables
  initRangees();
  camera = new Camera();
  smooth(8);
}

void draw() {
  noStroke();
  background(0);
  
  ambientLight(20, 20, 20);
  
  for(int i=0; i<lightPos.length; i++) {
      lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
      pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
                 lightPos[i].x, lightPos[i].y, lightPos[i].z);
  }   
  //Déplace la caméra à en fonction de l'utilisateur
  camera.bougerCamera();
  //Affiche la salle
  renderSalle();
    
}
