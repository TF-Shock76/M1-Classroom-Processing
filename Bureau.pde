//Vecteurs dimension
PVector dimensionEcran = new PVector(2, 55, 30); 
PVector dimensionPiedEcran = new PVector(5, 5, 10);
PVector dimensionSocleEcran = new PVector(10, 10, 1);
PVector dimensionSouris = new PVector(10, 5, 1.3);
PVector dimensionClavier = new PVector(15, 35, 1);
PVector dimensionTour = new PVector(30, 10, 30);

//Images
PImage imgClavier;
PImage imgSouris;
PImage avantTour;
PImage arriereTour;
PImage fondEcranOrdi;

//Espaces entre éléments
float espaceTourEcran = 5;
float espaceEcranClavierSouris = 10;
float espaceClavierSouris = 7;

//Création d'un bureau comprenant l'écran, le clavier, la tour, la souris
PShape creerBureau(boolean estPosteGauche) {  
  PShape bureau = createShape(GROUP);
  
  PShape pc = creerPC();
  PShape tour = creerTour();
  PShape clavier = creerClavier();
  PShape souris = creerSouris();
  
  float xTranslate;
  if (estPosteGauche) {
    xTranslate = -dimensionEcran.y/2 - dimensionTour.y/2 - espaceTourEcran;
  } else {
    xTranslate = dimensionEcran.y/2 + dimensionTour.y/2 + espaceTourEcran;
  }
  
  tour.translate(xTranslate, getHauteurBureau()/2 - dimensionTour.z/2, 0);
  pc.translate(0, getHauteurBureau()/2 - getHauteurPC()/2, 0);
  clavier.translate(0, getHauteurBureau()/2 - dimensionClavier.z/2, dimensionSocleEcran.x/2 + dimensionClavier.x/2 + espaceEcranClavierSouris);
  souris.translate(dimensionClavier.y/2 + dimensionSouris.y/2 + espaceClavierSouris, getHauteurBureau()/2 - dimensionSouris.z/2, dimensionSocleEcran.x/2 + dimensionSouris.x/2 + espaceEcranClavierSouris);
  
  bureau.addChild(pc);
  bureau.addChild(tour);
  bureau.addChild(clavier);
  bureau.addChild(souris);
  
  return bureau;
}

//Création de la tour
private PShape creerTour() {
  avantTour = loadImage("avant_tour.png");
  arriereTour = loadImage("arriere_tour.png");
  color couleurTour = color(45, 45, 45);
  
  boolean estNormaleInterieur = false;
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurTour));
  textures.put(Cote.BAS, new TexColor(couleurTour));
  textures.put(Cote.GAUCHE, new TexColor(couleurTour));
  textures.put(Cote.DROIT, new TexColor(couleurTour));
  textures.put(Cote.AVANT, new TexImage(avantTour));
  textures.put(Cote.ARRIERE, new TexImage(arriereTour));
  
  return creerElement(textures, dimensionTour, estNormaleInterieur);
}

//Création du clavier
private PShape creerClavier() {
  imgClavier = loadImage("clavierTex.jpg");
  color couleurClavier = color(45, 45, 45);
  
  boolean estNormaleInterieur = false;
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexImage(imgClavier));
  textures.put(Cote.BAS, new TexColor(couleurClavier));
  textures.put(Cote.GAUCHE, new TexColor(couleurClavier));
  textures.put(Cote.DROIT, new TexColor(couleurClavier));
  textures.put(Cote.AVANT, new TexColor(couleurClavier));
  textures.put(Cote.ARRIERE, new TexColor(couleurClavier));
  
  return creerElement(textures, dimensionClavier, estNormaleInterieur);
}

//Création de l'écran (avec le pied, le socle et l'écran
private PShape creerPC() {
  fondEcranOrdi = loadImage("fond_ecran.jpg");
  
  PShape pc = createShape(GROUP);
  PShape ecran = creerEcran();
  PShape pied = creerPiedEcran();
  PShape socle = creerSocleEcran();
  
  ecran.translate(0, getHauteurPC()/2 - (dimensionSocleEcran.z + dimensionPiedEcran.z + dimensionEcran.z/2), 0);
  pied.translate(0, getHauteurPC()/2 - (dimensionSocleEcran.z + dimensionPiedEcran.z/2), 0);
  socle.translate(0, getHauteurPC()/2 - dimensionSocleEcran.z/2, 0);
  
  pc.addChild(ecran);
  pc.addChild(pied);
  pc.addChild(socle);
  
  return pc;
}

//Création de la souris
private PShape creerSouris() {
  imgSouris = loadImage("sourisTex.png");
  color couleurSouris = color(45, 45, 45);
  
  boolean estNormaleInterieur = false;
  
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexImage(imgSouris));
  textures.put(Cote.BAS, new TexColor(couleurSouris));
  textures.put(Cote.GAUCHE, new TexColor(couleurSouris));
  textures.put(Cote.DROIT, new TexColor(couleurSouris));
  textures.put(Cote.AVANT, new TexColor(couleurSouris));
  textures.put(Cote.ARRIERE, new TexColor(couleurSouris));
  
  return creerElement(textures, dimensionSouris, estNormaleInterieur);
}

//Création de l'écran
private PShape creerEcran() {  
  boolean estNormaleInterieur = false;
  color couleurEcran = color(0, 0, 0);
  HashMap<Cote, ITexture> textures = new HashMap<>();
  textures.put(Cote.HAUT, new TexColor(couleurEcran));
  textures.put(Cote.BAS, new TexColor(couleurEcran));
  textures.put(Cote.GAUCHE, new TexColor(couleurEcran));
  textures.put(Cote.DROIT, new TexColor(couleurEcran));
  textures.put(Cote.AVANT, new TexImage(fondEcranOrdi));
  textures.put(Cote.ARRIERE, new TexColor(couleurEcran));
  
  return creerElement(textures, dimensionEcran, estNormaleInterieur);
  
}
 
 //Création du pied de l'écran
 private PShape creerPiedEcran() {
   boolean estNormaleInterieur = false;
   color couleurPied = color(0, 0, 0);
   HashMap<Cote, ITexture> textures = new HashMap<>();
  for ( Cote cote : Cote.values() ) {
    textures.put(cote, new TexColor(couleurPied));
  }
  
  return creerElement(textures, dimensionPiedEcran, estNormaleInterieur);
 }
 
 //Création du socle de l'écran
 private PShape creerSocleEcran() {
   boolean estNormaleInterieur = false;
   color couleursocle = color(0, 0, 0);
   HashMap<Cote, ITexture> textures = new HashMap<>();
  for ( Cote cote : Cote.values() ) {
    textures.put(cote, new TexColor(couleursocle));
  }
  
  return creerElement(textures, dimensionSocleEcran, estNormaleInterieur);
 }

// fonctions getter
float getLongueurPC() {
  return dimensionEcran.x; 
}

float getLargeurEcran() {
 return dimensionSocleEcran.y; 
}

float getHauteurPC() {
  return dimensionEcran.z + dimensionPiedEcran.z + dimensionSocleEcran.z;
}

float getLargeurBureau() {
  return dimensionEcran.y + dimensionTour.y; 
}

float getHauteurBureau() {
  float hauteurPC = getHauteurPC();
  float hauteurTour = dimensionTour.z;
  if ( hauteurTour > hauteurPC ) return hauteurTour;
  return hauteurPC;
}
