  

import processing.video.*;

Capture cam;
Filter filter;
int start_time = millis();
int time = 0;
int min_duration = 5000;
int max_duration = 5000;
int current_duration = 1000;
int filter_id = 0;

float scale_x;
float scale_y;

void setup() {
  surface.setSize(640, 360);
  surface.setLocation(150,100);
  getCamera(52);
  background(0);
}
  
// Read image from the camera
void captureEvent(Capture cam) {  
  cam.read();
}

void draw() {
  cam.loadPixels(); 
  if(cam.pixels.length<100){
    return;
  }
  
  time = millis()-start_time;
  if(time > current_duration){
    setFilter();
  }
  
  filter.draw();
}

void getCamera(int id){
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i, cameras[i]);
    }
    cam = new Capture(this, cameras[id]);
    cam.start();     
  }     
}
void setFilter(){
  start_time = millis();
  current_duration = int(random(min_duration, max_duration));
  filter_id = int(random(0,3));
  filter_id = 2;
  //randomize
  switch(filter_id){
    case 0: filter = new RasterFilter();
    break;
    case 1: filter = new GlitchFilter();
    break;
    case 2: filter = new MorphFilter();
    break;
    default: filter = new NoFilter();
  }
}
