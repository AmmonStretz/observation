class NoFilter implements Filter{
  void draw (){
  scale_x = width/cam.width;
  scale_y = height/cam.height;
  
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      color c = cam.pixels[x + y*cam.width];
      fill(c);
      noStroke();
      rect(x*scale_x, y*scale_y, scale_x, scale_y);    
    }  
  }
}
}
