//Vecteurs dimension
PVector dimensionTable = new PVector(70, 160, 5);
PVector dimensionPiedTable = new PVector(5, 5, 65);

PVector dimensionDossier = new PVector(1.8, 50, 20);
PVector dimensionDessous = new PVector(50, 50, 1.8);
PVector dimensionCoteDossier = new PVector(2, 2, 50);
PVector dimensionCoteDessous = new PVector(50, 2, 2);
PVector dimensionPiedChaise = new PVector(2, 2, 30);

//Espaces entre objets 
float espaceTable = 0.99; // Distance entre la table et le mur, on retire 0.01 car sinon la table traverse le mur
float espacePied = 0.88; // Espace entre les bords de la table et les pieds

float distanceMurRangee1 = 250;
float distanceRangees = 100;

//Elements
PShape rangees;
PShape tableProf;
PShape tableFond;

void initRangees() {
  tableProf = creerTable();
  tableFond = creerTable();
  
  rangees = createShape(GROUP);
  
  PShape table1 = creerTableEleve();
  PShape table2 = creerTableEleve();
  PShape table3 = creerTableEleve();
  
  float largTranslate = espaceTable * dimensionSalle.y/2 - dimensionTable.y/2;
  float hautTranslate = dimensionSalle.z/2 - dimensionPiedTable.z/2;
  table1.translate(largTranslate, hautTranslate);
   
  largTranslate -= dimensionTable.y;
  table2.translate(largTranslate, hautTranslate);

  largTranslate -= dimensionTable.y;
  table3.translate(largTranslate, hautTranslate);
  
  rangees.addChild(table1);
  rangees.addChild(table2);
  rangees.addChild(table3);
}

void placerRangees() {
  
  float profTranslate = -dimensionSalle.x/2 + distanceMurRangee1;
  
  //Table professeur
  pushMatrix();
    float hautTranslate = dimensionSalle.z/2 - dimensionPiedTable.z /2;
    translate(0, hautTranslate, profTranslate - dimensionTable.x);
    rotateY(PI);
    shape(tableProf);
  popMatrix();
  
  pushMatrix();
    //float zTranslate = -490;
    translate(0, 0, profTranslate);
    shape(rangees);
    
    translate(0, 0, distanceRangees + dimensionTable.x);
    shape(rangees);
    
    translate(0, 0, distanceRangees + dimensionTable.x);
    shape(rangees);
    
    translate(0, 0, distanceRangees + dimensionTable.x);
    shape(rangees);
    
  popMatrix();
  
  pushMatrix();
    translate(0, hautTranslate, 489-(dimensionTable.x/2));
    shape(tableFond);
  popMatrix();
}

//Création d'une table avec deux ordinateurs
PShape creerTableEleve() {
  PShape table = creerTable();
 
  PShape pcGauche = creerBureau(true);
  PShape pcDroit = creerBureau(false);
  
  PShape chaiseGauche = creerChaise();
  PShape chaiseDroite = creerChaise();
  
  float translateHauteurBureau = -getHauteurTable()/2 - getHauteurBureau()/2 -dimensionTable.z/2; 
  float largeurPC = getLargeurBureau();
  pcGauche.translate(-largeurPC/2 - 1, translateHauteurBureau, -12);
  pcDroit.translate(largeurPC/2 + 1, translateHauteurBureau, -12);
  
  float translateProfondeurChaise =  dimensionTable.x/4 + dimensionDessous.x/4;
  chaiseGauche.translate(-largeurPC/2 - 1, 0, translateProfondeurChaise);
  chaiseDroite.translate(largeurPC/2 + 1, 0, translateProfondeurChaise);
  
  table.addChild(pcGauche);
  table.addChild(pcDroit);
  table.addChild(chaiseGauche);
  table.addChild(chaiseDroite);
  
  return table;
}

//Création d'une table
private PShape creerTable() {
  PShape table = createShape(GROUP);
  
  PShape plateau = plateauTable();
  PShape[] pieds = new PShape[4];
  for ( int i = 0; i < 4; i++ ) {
   pieds[i] = piedTable();
  }
  
  plateau.translate(0, -dimensionPiedTable.z/2 - dimensionTable.z/2, 0);
  
  float profondeur = dimensionTable.x;
  float largeur = dimensionTable.y;
  
  pieds[0].translate(espacePied * (-largeur/2),  -0.01, espacePied * (-profondeur/2));
  pieds[1].translate(espacePied * (largeur/2),  -0.01, espacePied * (-profondeur/2));
  pieds[2].translate(espacePied * (largeur/2), -0.01, espacePied * (profondeur/2));
  pieds[3].translate(espacePied * (-largeur/2),  -0.01, espacePied * (profondeur/2));
  
  table.addChild(plateau);
  for ( int i = 0; i < 4; i++ ) {
   table.addChild(pieds[i]);
  }

  return table;
}
 
//Création du plateau de la table
private PShape plateauTable() {
  boolean estNormaleInterieur = false;
  PImage haut = loadImage("table.png");
  color otherColor = color(0, 0, 0);
  HashMap<Cote, ITexture> textures = new HashMap<>();
  for ( Cote cote : Cote.values() ) {
    if(cote == cote.HAUT) {
      textures.put(cote, new TexImage(haut));
    } else {
      textures.put(cote, new TexColor(otherColor));
    }
  }
  
  return creerElement(textures, dimensionTable, estNormaleInterieur);
 }
 
//Création d'une chaise
private PShape creerChaise() {
 PShape chaise = createShape(GROUP);
 boolean estNormaleInterieur = false;
  color couleurPlateau = color(245, 176, 5);
  color couleurPied = color(255, 0, 0);
  
 HashMap<Cote, ITexture> textures = new HashMap<>();
  for ( Cote cote : Cote.values() ) {
    textures.put(cote, new TexColor(couleurPlateau));
  }
  
  PShape dossier = creerElement(textures, dimensionDossier, estNormaleInterieur);
  PShape dessous = creerElement(textures, dimensionDessous, estNormaleInterieur);
 
   for ( Cote cote : Cote.values() ) {
    textures.put(cote, new TexColor(couleurPied));
  }
 
 PShape coteDossier1 = creerElement(textures, dimensionCoteDossier, estNormaleInterieur);
 PShape coteDossier2 = creerElement(textures, dimensionCoteDossier, estNormaleInterieur);
 PShape coteDessous1 = creerElement(textures, dimensionCoteDessous, estNormaleInterieur);
 PShape coteDessous2 = creerElement(textures, dimensionCoteDessous, estNormaleInterieur);
 PShape piedChaise1 = creerElement(textures, dimensionPiedChaise, estNormaleInterieur);
 PShape piedChaise2 = creerElement(textures, dimensionPiedChaise, estNormaleInterieur);
 PShape piedChaise3 = creerElement(textures, dimensionPiedChaise, estNormaleInterieur);
 PShape piedChaise4 = creerElement(textures, dimensionPiedChaise, estNormaleInterieur);

 coteDossier1.translate(-dimensionDossier.y/2 - dimensionCoteDossier.y/2, -dimensionCoteDossier.z/2 - dimensionCoteDessous.z/2, dimensionDessous.x/2 - dimensionCoteDossier.x/2);
 coteDossier2.translate(dimensionDossier.y/2 + dimensionCoteDossier.y/2, -dimensionCoteDossier.z/2 - dimensionCoteDessous.z/2, dimensionDessous.x/2 - dimensionCoteDossier.x/2);

 dossier.translate(0, -dimensionDossier.z/2 - (dimensionCoteDossier.z - dimensionDossier.z), dimensionDessous.x/2 - dimensionDossier.x/2);

 coteDessous1.translate(-dimensionDessous.y/2 - dimensionCoteDessous.y/2, 0, 0);
 coteDessous2.translate(dimensionDessous.y/2 + dimensionCoteDessous.y/2, 0, 0);
  
 piedChaise1.translate(-dimensionDessous.y/2 - dimensionCoteDessous.y + dimensionPiedChaise.y/2, dimensionPiedChaise.z/2 + dimensionCoteDessous.z/2 - 0.01, -dimensionDessous.x/2 + dimensionPiedChaise.x/2);
 piedChaise2.translate(dimensionDessous.y/2 + dimensionCoteDessous.y - dimensionPiedChaise.y/2, dimensionPiedChaise.z/2 + dimensionCoteDessous.z/2 - 0.01, -dimensionDessous.x/2 + dimensionPiedChaise.x/2);
 piedChaise3.translate(dimensionDessous.y/2 + dimensionCoteDessous.y - dimensionPiedChaise.y/2, dimensionPiedChaise.z/2 + dimensionCoteDessous.z/2 - 0.01, dimensionDessous.x/2 - dimensionPiedChaise.x/2);
 piedChaise4.translate(-dimensionDessous.y/2 - dimensionCoteDessous.y + dimensionPiedChaise.y/2, dimensionPiedChaise.z/2 + dimensionCoteDessous.z/2 - 0.01, dimensionDessous.x/2 - dimensionPiedChaise.x/2);

 chaise.addChild(dossier);
 chaise.addChild(coteDossier1);
 chaise.addChild(coteDossier2);
 chaise.addChild(dessous);
 chaise.addChild(coteDessous1);
 chaise.addChild(coteDessous2);
 chaise.addChild(piedChaise1);
 chaise.addChild(piedChaise2);
 chaise.addChild(piedChaise3);
 chaise.addChild(piedChaise4);
 
 return chaise;
}
 
//Création d'un pied de table
 private PShape piedTable() {
   boolean estNormaleInterieur = false;
   color colPied = color(0, 0, 0);
   HashMap<Cote, ITexture> textures = new HashMap<>();
  for ( Cote cote : Cote.values() ) {
    textures.put(cote, new TexColor(colPied));
  }
   return creerElement(textures, dimensionPiedTable, estNormaleInterieur);
 }
 
 float getHauteurTable() {
  return dimensionPiedTable.z + dimensionTable.z;
 }
 
 float getHauteurChaise() {
   return dimensionDossier.z + dimensionDessous.z + dimensionPiedChaise.z; 
 }
