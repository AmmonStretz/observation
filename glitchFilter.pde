class GlitchFilter implements Filter{
  int res = 4;
  GlitchType type;
  GlitchFilter(){
    this.type = new BrightnessGlitch();
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
abstract class GlitchType{
  void fillPixel(int x, int y){}
  color getPx(int x, int y){
    x = (cam.width + x) % cam.width;
    y = (cam.height + y) % cam.height;
    return cam.pixels[x + y*cam.width];
  }
}
class DirectionalGlitch extends GlitchType{
  float r_speed, g_speed, b_speed;
  DirectionalGlitch(){
    this.r_speed = random(0.05,0.2);
    this.g_speed = random(0.05,0.2);//random(1, 0.1);
    this.b_speed = random(0.05,0.2);//random(1, 0.1);
  }
  void fillPixel(int x, int y){
    color r = this.getPx(x,int(y+millis()*r_speed));
    color g = this.getPx(x,int(y+millis()*g_speed));
    color b = this.getPx(x,int(y+millis()*b_speed));
    fill(red(r),green(g), blue(b));
  }
}

class RandomGlitch extends GlitchType{
  void fillPixel(int x, int y){
    color r = this.getPx(int(x+noise(x/400.0, y/50.0, millis()/200.0)*100-50), y);
    color g = this.getPx(x, int(y+noise(x/400.0, y/50.0, millis()/200.0)*100-50));
    color b = this.getPx(x, y);
    fill(red(r),green(g), blue(b)+random(1)*50);
  }
}

class BrightnessGlitch extends GlitchType{
  void fillPixel(int x, int y){
    int bright = int(brightness(this.getPx(x, y))*0.2);
    color r = this.getPx(x+bright, y);
    color g = this.getPx(x-bright, y+bright);
    color b = this.getPx(x, y-bright);
    fill(red(r),green(g), blue(b)+random(1)*50);
  }
}
