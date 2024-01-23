enum Cote {
  DROIT,
  GAUCHE,
  HAUT,
  BAS,
  AVANT,
  ARRIERE;
}

//Pivote les faces
void pivot(PShape faceH, PShape faceB, PShape faceG, PShape faceD, PShape faceAv, PShape faceAr, boolean estNormaleInterieur) {
  if (estNormaleInterieur) {
    faceH.rotateX(-PI/2);
    faceB.rotateX(PI/2);
    faceG.rotateY(PI/2);
    faceD.rotateY(-PI/2);
    faceAv.rotateY(PI);
  } else {
    faceH.rotateX(PI/2);
    faceB.rotateX(-PI/2);
    faceG.rotateY(-PI/2);
    faceD.rotateY(PI/2);
    faceAr.rotateY(PI);
  }
}

//Déplace les faces
void deplacerFaces(PShape faceH, PShape faceB, PShape faceG, PShape faceD, PShape faceAv, PShape faceAr, float hauteur, float largeur, float profondeur) {
  faceH.translate(0, -hauteur/2, 0);
  faceB.translate(0, hauteur/2, 0);
  faceG.translate(-largeur/2, 0, 0);
  faceD.translate(largeur/2, 0, 0);
  faceAv.translate(0, 0, profondeur/2);
  faceAr.translate(0, 0, -profondeur/2);
}

//Création d'un élément
PShape creerElement(HashMap<Cote, ITexture> textures, PVector dimension, boolean estNormaleInterieur) {
  PShape box = createShape(GROUP);

  float largeur = dimension.y;
  float profondeur = dimension.x;
  float hauteur = dimension.z;

  PShape faceH  = creerFace(textures.get(Cote.HAUT), largeur, profondeur);
  PShape faceB  = creerFace(textures.get(Cote.BAS), largeur, profondeur);
  PShape faceG  = creerFace(textures.get(Cote.GAUCHE), profondeur, hauteur);
  PShape faceD  = creerFace(textures.get(Cote.DROIT), profondeur, hauteur);
  PShape faceAv = creerFace(textures.get(Cote.AVANT), largeur, hauteur);
  PShape faceAr = creerFace(textures.get(Cote.ARRIERE), largeur, hauteur);

  pivot(faceH, faceB, faceG, faceD, faceAv, faceAr, estNormaleInterieur);
  
  deplacerFaces(faceH, faceB, faceG, faceD, faceAv, faceAr, hauteur, largeur, profondeur);
  
  box.addChild(faceH);
  box.addChild(faceB);
  box.addChild(faceG);
  box.addChild(faceD);
  box.addChild(faceAv);
  box.addChild(faceAr);

  return box;
}

//Création d'un élément
PShape creerElement(color couleur, PVector dimension, boolean estNormaleInterieur) {
  PShape box = createShape(GROUP);

  float largeur    = dimension.y;
  float profondeur = dimension.x;
  float hauteur    = dimension.z;

  ITexture texColor = new TexColor(couleur);

  PShape faceH  = creerFace(texColor, largeur, profondeur);
  PShape faceB  = creerFace(texColor, largeur, profondeur);
  PShape faceG  = creerFace(texColor, profondeur, hauteur);
  PShape faceD  = creerFace(texColor, profondeur, hauteur);
  PShape faceAv = creerFace(texColor, largeur, hauteur);
  PShape faceAr = creerFace(texColor, largeur, hauteur);

  pivot(faceH, faceB, faceG, faceD, faceAv, faceAr, estNormaleInterieur);

  deplacerFaces(faceH, faceB, faceG, faceD, faceAv, faceAr, hauteur, largeur, profondeur);

  box.addChild(faceH);
  box.addChild(faceB);
  box.addChild(faceG);
  box.addChild(faceD);
  box.addChild(faceAv);
  box.addChild(faceAr);

  return box;
}

//Création d'un élément
PShape creerElement(PImage texture, PVector dimension, boolean estNormaleInterieur) {
  PShape box = createShape(GROUP);

  float largeur    = dimension.y;
  float profondeur = dimension.x;
  float hauteur    = dimension.z;

  ITexture texImage = new TexImage(texture);

  PShape faceH  = creerFace(texImage, largeur, profondeur);
  PShape faceB  = creerFace(texImage, largeur, profondeur);
  PShape faceG  = creerFace(texImage, profondeur, hauteur);
  PShape faceD  = creerFace(texImage, profondeur, hauteur);
  PShape faceAv = creerFace(texImage, largeur, hauteur);
  PShape faceAr = creerFace(texImage, largeur, hauteur);

  pivot(faceH, faceB, faceG, faceD, faceAv, faceAr, estNormaleInterieur);

  deplacerFaces(faceH, faceB, faceG, faceD, faceAv, faceAr, hauteur, largeur, profondeur);

  box.addChild(faceH);
  box.addChild(faceB);
  box.addChild(faceG);
  box.addChild(faceD);
  box.addChild(faceAv);
  box.addChild(faceAr);

  return box;
}

//Création de la salle (étant différent d'une box standard avec le mur gauche
PShape creerSalle(HashMap<Cote, ITexture> textures, PVector dimension, boolean estNormaleInterieur) {
  PShape box = createShape(GROUP);

  float largeur    = dimension.y;
  float profondeur = dimension.x;
  float hauteur    = dimension.z;

  PShape faceH  = creerFace(textures.get(Cote.HAUT), largeur, profondeur);
  PShape faceB  = creerFace(textures.get(Cote.BAS), largeur, profondeur);
  PShape faceG  = creerFenetre(textures.get(Cote.GAUCHE), profondeur, hauteur);
  PShape faceD  = creerFace(textures.get(Cote.DROIT), profondeur, hauteur);
  PShape faceAv = creerFace(textures.get(Cote.AVANT), largeur, hauteur);
  PShape faceAr = creerFace(textures.get(Cote.ARRIERE), largeur, hauteur);

  pivot(faceH, faceB, faceG, faceD, faceAv, faceAr, estNormaleInterieur);

  deplacerFaces(faceH, faceB, faceG, faceD, faceAv, faceAr, hauteur, largeur, profondeur);

  box.addChild(faceH);
  box.addChild(faceB);
  box.addChild(faceG);
  box.addChild(faceD);
  box.addChild(faceAv);
  box.addChild(faceAr);

  return box;
}

//Création d'un mur avec un trou au centre pour y mettre les vitres
private PShape creerFenetre(ITexture texture, float x, float y) {

  PShape fenetre = createShape(GROUP);
  noStroke();
  PShape murG = createShape();
  murG.beginShape();
    murG.textureMode(NORMAL);
    texture.apply(murG);
    murG.shininess(200);
    murG.emissive(0, 0, 0);
    murG.normal(0, 0, 1);
    murG.vertex(-x/2, -y/2, 0, 0); 
    murG.vertex(-x/2+115, -y/2, 1, 0); 
    murG.vertex(-x/2+115, y/2, 1, 1); 
    murG.vertex(-x/2, y/2, 0, 1);      
 murG.endShape(CLOSE);

 PShape murH = createShape();
  murH.beginShape();
    murH.textureMode(NORMAL);
    texture.apply(murH);
    murH.shininess(200);
    murH.emissive(0, 0, 0);
    murH.normal(0, 0, 1);
    murH.vertex(-x/2+115, -y/2, 0, 0); 
    murH.vertex(x/2-115, -y/2, 1, 0); 
    murH.vertex(x/2-115, -y/2+30, 1, 1); 
    murH.vertex(-x/2+115, -y/2+30, 0, 1);      
 murH.endShape(CLOSE);

 PShape murD = createShape();
  murD.beginShape();
    murD.textureMode(NORMAL);
    texture.apply(murD);
    murD.shininess(200);
    murD.emissive(0, 0, 0);
    murD.normal(0, 0, 1);
    murD.vertex(x/2-115, -y/2, 0, 0); 
    murD.vertex(x/2, -y/2, 1, 0); 
    murD.vertex(x/2, y/2, 1, 1); 
    murD.vertex(x/2-115, y/2, 0, 1);      
 murD.endShape(CLOSE);

 PShape murB = createShape();
  murB.beginShape();
    murB.textureMode(NORMAL);
    texture.apply(murB);
    murB.shininess(200);
    murB.emissive(0, 0, 0);
    murB.normal(0, 0, 1);
    murB.vertex(-x/2+115, y/2-108, 0, 0); 
    murB.vertex(x/2-115, y/2-108, 1, 0); 
    murB.vertex(x/2-115, y/2, 1, 1); 
    murB.vertex(-x/2+115, y/2, 0, 1);      
  murB.endShape(CLOSE);
 
 
  fenetre.addChild(murG);
  fenetre.addChild(murH);
  fenetre.addChild(murD);
  fenetre.addChild(murB);

  return fenetre;
}

//Création de la vitre
PShape creerVitre(HashMap<Cote, ITexture> textures, PVector dimension) {
  PShape box = createShape(GROUP);

  float largeur = dimension.y;
  float profondeur = dimension.x;
  float hauteur = dimension.z;

  PShape faceH  = creerFace(textures.get(Cote.HAUT), largeur, profondeur);
  PShape faceB  = creerFace(textures.get(Cote.BAS), largeur, profondeur);
  PShape faceG  = creerFace(textures.get(Cote.GAUCHE), profondeur, hauteur);
  PShape faceD  = creerFace(textures.get(Cote.DROIT), profondeur, hauteur);
  PShape faceAv = creerFace(textures.get(Cote.AVANT), largeur, hauteur);
  PShape faceAr = creerFace(textures.get(Cote.ARRIERE), largeur, hauteur);

  deplacerFaces(faceH, faceB, faceG, faceD, faceAv, faceAr, hauteur, largeur, profondeur);
  
 
  box.addChild(faceH);
  box.addChild(faceB);
  box.addChild(faceG);
  box.addChild(faceD);
  box.addChild(faceAv);
  box.addChild(faceAr);

  return box;
}

//Création de la face
private PShape creerFace(ITexture texture, float x, float y) {
  PShape face = createShape();
  face.beginShape(QUAD);
    face.textureMode(NORMAL);
    texture.apply(face);
    face.shininess(200);
    face.emissive(0, 0, 0);
    face.normal(0, 0, 1);
    face.vertex(-x/2, -y/2, 0, 0); //haut-gauche
    face.vertex(x/2, -y/2, 1, 0); //haut-droite
    face.vertex(x/2, y/2, 1, 1); //bas-droite
    face.vertex(-x/2, y/2, 0, 1); //bas-gauche
  face.endShape();

  return face;
}
