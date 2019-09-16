class MorphFilter implements Filter{
  int res = 4;
  MorphType type;
  MorphFilter(){
    this.type = new NoiseMorph();
  }
  void draw (){
    scale_x = width/cam.width;
    scale_y = height/cam.height;
  
    for (int x = 0; x < cam.width; x+=res) {
      for (int y = 0; y < cam.height; y+=res) {
        type.fillPixel(x,y);
        noStroke();
        rect(x*scale_x, y*scale_y, scale_x*res, res*scale_y);    
      }  
    }
  }
}
abstract class MorphType{
  void fillPixel(int x, int y){}
  color getPx(int x, int y){
    x = (cam.width + x) % cam.width;
    y = (cam.height + y) % cam.height;
    return cam.pixels[x + y*cam.width];
  }
}
class NoiseMorph extends MorphType{
  NoiseMorph(){}
  void fillPixel(int x, int y){
    color c = this.getPx(
      int(noise(x)*cam.width),
      int(noise(y)*cam.height)
    );
    fill(c);
  }
}
