public interface ITexture {
 void apply(PShape object); 
}

public class TexColor implements ITexture {
  color couleur;
  int opacity;
  
  public TexColor(color couleur, int opacity) {
    this.couleur = couleur;
    this.opacity = opacity;
  }
  
  public TexColor(color couleur) {
    this(couleur, 255);
  }
  
  public void apply(PShape object) {
    object.texture(white);
    object.tint(couleur, opacity);
  }
}

public class TexImage implements ITexture {
  PImage image;
  
  public TexImage(PImage image) {
    this.image = image;
  }
  
  public void apply(PShape object) {
    object.texture(image); 
  }
}
