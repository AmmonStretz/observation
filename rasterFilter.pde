class RasterFilter implements Filter {
  
int line_width;
int line_space;

  RasterFilter(){
    this.line_width = int(random(2,6));
    this.line_space = 8;
  }

void draw(){
  scale_x = width/cam.width;
  scale_y = height/cam.height;
  
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      color c = cam.pixels[x + y*cam.width];
      rasterFilterColor(c, x, y);
      noStroke();
      rect(x*scale_x, y*scale_y, scale_x, scale_y);    
    }  
  }
}

void rasterFilterColor(color c, int x, int y){
  int level = int(brightness(c)*4/255);
  int s = level%2==0?-1:1;
  int t = level%2==0?255:0;
  int index = (width+(x+s*y))%(line_width+line_space);
  if(index<line_width){
    fill(t);
  }else{
    fill(255-t);
  }
}
}
