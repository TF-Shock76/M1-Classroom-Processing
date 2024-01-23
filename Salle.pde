//Images
PImage sol;
PImage porteAvant;
PImage porteArriere;
PImage imgNeon;
PImage imgFenetre;
PImage imgRadiateur;
PImage imgPaysage;

//Elements
PShape salle;
PShape porte;
PShape tableau;
PShape tableauElec;
PShape neon;
PShape fenetre;
PShape radiateur;
PShape paysage;

//Espaces entre objets
float espaceTableau = 0.1;
float espacePorte = 10;
float espaceRadiateur = 140;
float espaceRadiateurSol = 10;
float espaceRadiateurMur = 0.1;
float espaceNeon = 200;

// Vecteurs dimensions
PVector dimensionSalle = new PVector(980, 620, 280);
PVector dimensionTableau = new PVector(0, 410, 140);
PVector dimensionNeon = new PVector(300, 80, 2);
PVector dimensionEcranTableauElec = new PVector(10, 150, 100);
PVector dimensionPiedTableauElec = new PVector(10, 10, 100);
PVector dimensionSocleTableauElec = new PVector(50, 100, 3);
PVector dimensionRouletteTableauElec = new PVector(5, 5, 5);
PVector dimensionPorte = new PVector(2, 95, 205);
PVector dimensionFenetre = new PVector(2, 750, 150);
PVector dimensionVitre = new PVector(0.25, 250, 150);
PVector dimensionRadiateur = new PVector(5, 200, 75);


void initSalle() {
 salle = creerSalle();
 porte = creerPorte();
 tableau = creerTableau();
 tableauElec = creerTableauElec();
 neon = creerNeon();
 fenetre = creerFenetre();
 radiateur = creerRadiateur();
 paysage = creerPaysage();
}

// Crée le néon sur le plafond
PShape creerNeon() {
  boolean estNormaleInterieur = false;
  imgNeon = loadImage("neon.png");
  color couleurNeon = color(255, 255, 255);
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurNeon));
  textures.put(Cote.BAS, new TexImage(imgNeon));
  textures.put(Cote.GAUCHE, new TexColor(couleurNeon));
  textures.put(Cote.DROIT, new TexColor(couleurNeon));
  textures.put(Cote.AVANT, new TexColor(couleurNeon));
  textures.put(Cote.ARRIERE, new TexColor(couleurNeon));
  
  return creerElement(textures, dimensionNeon, estNormaleInterieur);
}

//Initialise les valeurs de la salle avant de la créer
PShape creerSalle() {
  sol = loadImage("Sol_Salle.jpg");
  
  boolean estNormaleInterieur = true;
  color couleurMurs = color(236, 227, 196);
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurMurs));
  textures.put(Cote.BAS, new TexImage(sol));
  textures.put(Cote.GAUCHE, new TexColor(couleurMurs)); // mur fenêtre sur lequel je dois faire un trou
  textures.put(Cote.DROIT, new TexColor(couleurMurs));
  textures.put(Cote.AVANT, new TexColor(couleurMurs));
  textures.put(Cote.ARRIERE, new TexColor(couleurMurs));
  
  return creerSalle(textures, dimensionSalle, estNormaleInterieur);
}

//Crée un mur en dehors de la salle qui peut être vu depuis l'intérieur de la classe
PShape creerPaysage() {
  PImage img = loadImage("paysage.jpg");
  
  PShape paysage = createShape();
  
  paysage.beginShape();
  paysage.textureMode(NORMAL);
  paysage.texture(img);
  paysage.shininess(200.0);
  paysage.emissive(0,0,0);
  paysage.normal(0,0,1);
  paysage.vertex(-dimensionSalle.x, -dimensionSalle.z, 0, 0); //haut-gauche
  paysage.vertex(dimensionSalle.x, -dimensionSalle.z, 1, 0); //haut-droite
  paysage.vertex(dimensionSalle.x, dimensionSalle.z, 1, 1); //bas-droite
  paysage.vertex(-dimensionSalle.x, dimensionSalle.z, 0, 1); //bas-gauche
  paysage.endShape(CLOSE);
  
  return paysage;
}

//Initialise les vitres avant de les créer
PShape creerFenetre() {
  imgPaysage = loadImage("FenetreTransp.png");
  imgFenetre = loadImage("fenetreTex.png");
  // La fenêtre est une boite dont laquelle j'ai collé sur l'une des faces une image. Il faut donc colorier les autres faces 
  color couleurFenetre = color(236, 227, 196);
  
  PShape fenetre = createShape(GROUP);
  // On rend les vitres transparentes
  tint(255,80);
  PShape facePaysage = creerFace(new TexImage(imgPaysage), dimensionFenetre.y, dimensionFenetre.z);
  noTint();
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurFenetre));
  textures.put(Cote.BAS, new TexColor(couleurFenetre));
  textures.put(Cote.GAUCHE, new TexColor(couleurFenetre));
  textures.put(Cote.DROIT, new TexColor(couleurFenetre));
  textures.put(Cote.AVANT, new TexImage(imgFenetre));
  textures.put(Cote.ARRIERE, new TexImage(imgFenetre));
  
  PShape vitreG = creerVitre(textures, dimensionVitre);
  PShape vitreM = creerVitre(textures, dimensionVitre);
  PShape vitreD = creerVitre(textures, dimensionVitre);
  
  facePaysage.translate(0, 0, dimensionFenetre.x/2-1);
  vitreG.translate(-dimensionVitre.y, 0, dimensionFenetre.x/2-1);
  vitreM.translate(0, 0, dimensionFenetre.x/2-1);
  vitreD.translate(dimensionVitre.y, 0, dimensionFenetre.x/2-1);
  fenetre.addChild(facePaysage);
  fenetre.addChild(vitreG);
  fenetre.addChild(vitreM);
  fenetre.addChild(vitreD);
  
  return fenetre;
}

//Crée la porte
PShape creerPorte() {
  boolean estNormaleInterieur = false;
  
  porteAvant = loadImage("porte_avant.jpg");
  porteArriere = loadImage("porte_arriere.jpg");
  
  color couleurPorte = color(173, 216, 230);
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurPorte));
  textures.put(Cote.BAS, new TexColor(couleurPorte));
  textures.put(Cote.GAUCHE, new TexColor(couleurPorte));
  textures.put(Cote.DROIT, new TexColor(couleurPorte));
  textures.put(Cote.AVANT, new TexImage(porteAvant));
  textures.put(Cote.ARRIERE, new TexImage(porteArriere));
  
  return creerElement(textures, dimensionPorte, estNormaleInterieur);
}

//Crée le tableau à craie
private PShape creerTableau() {
  PImage tab = loadImage("tableau.jpeg");
  
  float x = dimensionTableau.y;
  float y = dimensionTableau.z;
  
  PShape tableau = createShape();
  tableau.beginShape(QUAD);
      tableau.textureMode(NORMAL);
      tableau.texture(tab);
      tableau.shininess(200);
      tableau.emissive(0, 0, 0);
      tableau.normal(0, 0, 1);
      tableau.vertex(-x/2, -y/2, 0, 0); //haut-gauche
      tableau.vertex(x/2, -y/2, 1, 0); //haut-droite
      tableau.vertex(x/2, y/2, 1, 1); //bas-droite
      tableau.vertex(-x/2, y/2, 0, 1); //bas-gauche
    tableau.endShape();
    
  return tableau;
}

//Crée le tableau électrique
PShape creerTableauElec() {
  PShape tableauElec = createShape(GROUP);
  boolean estNormaleInterieur = false;
 
  color couleurEcran = color(0, 0, 0);
  color couleurTableauElec = color(45, 45, 45);
  //Ecran
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurTableauElec));
  textures.put(Cote.BAS, new TexColor(couleurTableauElec));
  textures.put(Cote.GAUCHE, new TexColor(couleurTableauElec));
  textures.put(Cote.DROIT, new TexColor(couleurTableauElec));
  textures.put(Cote.AVANT, new TexColor(couleurEcran));
  textures.put(Cote.ARRIERE, new TexColor(couleurTableauElec));
  
  PShape ecran = creerElement(textures, new PVector(dimensionEcranTableauElec.x, dimensionEcranTableauElec.y, dimensionEcranTableauElec.z), estNormaleInterieur);
  
  textures.put(Cote.AVANT, new TexColor(couleurTableauElec));
  
  PShape pied = creerElement(textures, dimensionPiedTableauElec, estNormaleInterieur);
  PShape socle = creerElement(textures, dimensionSocleTableauElec, estNormaleInterieur);
  PShape roulette1 = creerElement(textures, dimensionRouletteTableauElec, estNormaleInterieur);
  PShape roulette2 = creerElement(textures, dimensionRouletteTableauElec, estNormaleInterieur);
  PShape roulette3 = creerElement(textures, dimensionRouletteTableauElec, estNormaleInterieur);
  PShape roulette4 = creerElement(textures, dimensionRouletteTableauElec, estNormaleInterieur);
  
  float bottom = dimensionSalle.z/2 - dimensionRouletteTableauElec.z/2;
  roulette1.translate(0.6 * -dimensionSocleTableauElec.y/2, bottom - 0.01, 0.6 * -dimensionSocleTableauElec.x/2);
  roulette2.translate(0.6 * dimensionSocleTableauElec.y/2, bottom - 0.01, 0.6 * -dimensionSocleTableauElec.x/2);
  roulette3.translate(0.6 * dimensionSocleTableauElec.y/2, bottom - 0.01, 0.6 * dimensionSocleTableauElec.x/2);
  roulette4.translate(0.6 * -dimensionSocleTableauElec.y/2, bottom - 0.01, 0.6 * dimensionSocleTableauElec.x/2);
  
  socle.translate(0, bottom - dimensionRouletteTableauElec.z/2 - dimensionSocleTableauElec.z/2, 0);
  pied.translate(0, bottom - dimensionRouletteTableauElec.z/2 - dimensionSocleTableauElec.z - dimensionPiedTableauElec.z/2, 0);
  ecran.translate(0, bottom - dimensionRouletteTableauElec.z/2 - dimensionSocleTableauElec.z - dimensionPiedTableauElec.z - dimensionEcranTableauElec.z/2, 0);
  
  tableauElec.addChild(ecran);
  tableauElec.addChild(pied);
  tableauElec.addChild(socle);
  tableauElec.addChild(roulette1);
  tableauElec.addChild(roulette2);
  tableauElec.addChild(roulette3);
  tableauElec.addChild(roulette4);
  
  return tableauElec;
}

//Création du radiateur
PShape creerRadiateur() {
  imgRadiateur = loadImage("radiateur.jpg");
  boolean estNormaleInterieur = false;
  PShape radiateur = creerElement(imgRadiateur, dimensionRadiateur, estNormaleInterieur);
  
  return radiateur;
}

//Dessine la salle
void renderSalle() {
  placerRangees();
  
 shape(salle);
 
 pushMatrix();
   translate(50, 0, -dimensionSalle.x/2 + espaceTableau);
   shape(tableau);
 popMatrix();
 
 pushMatrix();
   translate(-dimensionSalle.y/2 + dimensionEcranTableauElec.y/2, 0, -dimensionSalle.x/2 + dimensionSocleTableauElec.y);
   rotateY(PI/4);
   shape(tableauElec);
 popMatrix();
 
 pushMatrix();
   translate(dimensionSalle.y/2, dimensionSalle.z/2 - dimensionPorte.z/2, -dimensionSalle.x/2 + dimensionPorte.y/2 + espacePorte);
   rotateY(PI/2);
   shape(porte);
 popMatrix();
 
 pushMatrix();
   translate(-dimensionSalle.y/2 + dimensionPorte.y/2 + espacePorte, dimensionSalle.z/2 - dimensionPorte.z/2, dimensionSalle.x/2);
   shape(porte);
 popMatrix();
 
 pushMatrix();
   translate(-dimensionSalle.y/2 + dimensionPorte.y/2 + espacePorte, dimensionSalle.z/2 - dimensionPorte.z/2, -dimensionSalle.x/2);
   shape(porte);
 popMatrix();
 
 pushMatrix();
   translate(-dimensionSalle.y/2 + dimensionRadiateur.x/2 + espaceRadiateurMur, dimensionSalle.z/2 - dimensionRadiateur.z/2 - espaceRadiateurSol, 0);
   rotateY(PI/2);
   shape(radiateur);
   translate(dimensionRadiateur.y + espaceRadiateur, 0, 0);
   shape(radiateur);
   translate((-dimensionRadiateur.y - espaceRadiateur)*2, 0, 0);
   shape(radiateur);
 popMatrix();
 
 pushMatrix();
   translate(0, -getHauteurSalle()/2, 0);
   shape(neon);
 popMatrix();
 
 // On éloigne le tableau du paysage du mur pour qu'il soit en perspective
 pushMatrix();
   translate(-dimensionSalle.y/2 - 520, -dimensionFenetre.z * 0.25, 0);
   rotateY(PI/2);
   shape(paysage);
 popMatrix();
 
 // On dessine la fenêtre à la fin pour qu'elle puisse voir à travers tout ce qui a été dessiné plus tôt 
 pushMatrix();
   translate(-dimensionSalle.y/2, -dimensionFenetre.z * 0.25, 0);
   rotateY(PI/2);
   shape(fenetre);
 popMatrix();
}


float getProfondeurSalle() { return dimensionSalle.x; }
float getLargeurSalle() { return dimensionSalle.y; }
float getHauteurSalle() { return dimensionSalle.z; }

float getHauteurTableauElec() {
   return dimensionEcranTableauElec.z + dimensionPiedTableauElec.z + dimensionSocleTableauElec.z + dimensionRouletteTableauElec.z; 
} 
