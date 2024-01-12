// Global Variables

PImage image;
PGraphics nebula;
int radius = 0;
int maxRadius = 0;
float r;
float g;
float b;
int loopFlag = 1;

void setup() {
  //size(800, 800);
  fullScreen();
  //background(255,255,255,10); // WHITE
  //background(0, 0, 0);    // BLACK
  //background(0,10,30);    // BLUE-BLACK
  //background(15,0,0);     // RED-BLACK
  background(0,5,0);     // GREEN-BLACK
  //background(2,22,49);    // NAVY
   //background(15, 0, 25);  // DARK PURPLE
  blendMode(ADD);
  noFill();
  maxRadius = width/3;
  radius = width/2;
  
  nebula = createGraphics(width, height);
  drawNebulaBackground();
  drawStars();
  image(nebula, 0, 0);
}

void draw() {
  drawCircleNoise();
}

void drawCircleNoise() {
  int center_x, center_y;
  float noiseFactor, x, y;
  center_x = width/2;
  center_y = height/2;
  stroke(r, g, b, 2);
  
  beginShape();

  for (int i = 0; i < 365; i++) {
    noiseFactor = noise(i * 0.02, frameCount / 140.0);
    x = center_x + radius * cos(radians(i)) * noiseFactor;
    y = center_y + radius * sin(radians(i)) * noiseFactor;

    // Color based on the noise factor
    float colorIntensity = map(noiseFactor, 0, 1, 0, 255);
    
    // RED
    //float r = 220;
    //float g = max(0, 200 - colorIntensity);
    //float b = max(0, 200 - colorIntensity);
    
    // BLUE
    //float r = max(0, 200 - colorIntensity);
    //float g = max(0, 200 - colorIntensity);
    //float b = 230;
    
    // PURPLE
    //float r = 200;
    //float g = max(0, 200 - colorIntensity);
    //float b = 200;
    
    //// YELLOW
    //float r = 255;
    //float g = 195;
    //float b = 0;
    
    // GREEN
    float r = max(0, 200 - colorIntensity);
    float g = 180;
    float b = max(0, 200 - colorIntensity);
    
    // WHITE
    //float r = 255;
    //float g = 255;
    //float b = 255;
    
    stroke(r, g, b, 15);
    strokeWeight(0.2);
    curveVertex(x, y);
  }

  endShape();
  radius--;

  if (abs(radius) > maxRadius)
    radius = maxRadius;
}

// Function to draw the star field
void drawStars() {
  nebula.beginDraw();
  for (int i = 0; i < 2000; i++) {
    float starX = random(width);
    float starY = random(height);
    
    float starRadius1;
    float starRadius2;
    float brightness;
    float randomval = random(0, 200);
    if (randomval > 199) {
      starRadius1 = 5;
      starRadius2 = 1;
      brightness = 230;
      
      nebula.noStroke();
      nebula.fill(brightness);
      float angle = TWO_PI / 4;
      float halfAngle = angle/2.0;
      nebula.beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = starX + cos(a) * starRadius1;
        float sy = starY + sin(a) * starRadius1;
        nebula.vertex(sx, sy);
        sx = starX + cos(a+halfAngle) * starRadius2;
        sy = starY + sin(a+halfAngle) * starRadius2;
        nebula.vertex(sx, sy);
      }
      nebula.endShape(CLOSE);
    } else {
      starRadius1 = 1.5;
      brightness = random(100, 200);
      nebula.noStroke();
      nebula.fill(brightness);
      nebula.circle(starX, starY, starRadius1);
    }
    
    
  }
  nebula.endDraw();
}

void drawNebulaBackground() {
  nebula.beginDraw();
  nebula.loadPixels();
  
  // Define the radius where the nebula starts and ends
  float nebulaStartRadius = width * 0; // Nebula starts to appear at this radius
  float nebulaPeakRadius = width * 0.2;  // Nebula is densest at this radius
  float nebulaEndRadius = width * 0.4;   // Nebula starts to fade after this radius
  
  //float nebulaStartRadius = width * 0; // Nebula starts to appear at this radius
  //float nebulaPeakRadius = width * 0.2;  // Nebula is densest at this radius
  //float nebulaEndRadius = width * 0.6;   // Nebula starts to fade after this radius

  for (int x = 0; x < nebula.width; x++) {
    for (int y = 0; y < nebula.height; y++) {
      // Calculate the distance from the center of the canvas
      float distance = dist(x, y, nebula.width / 2, nebula.height / 2);
      
      // Calculate a factor that determines the density of the nebula gases
      float nebulaDensity;
      if (distance < nebulaStartRadius) {
        nebulaDensity = 0.1; // No nebula
      } else if (distance < nebulaPeakRadius) {
        // Gradually increase the density
        nebulaDensity = map(distance, nebulaStartRadius, nebulaPeakRadius, 0.1, 1);
      } else if (distance < nebulaEndRadius) {
        // After the peak, start decreasing the density
        nebulaDensity = map(distance, nebulaPeakRadius, nebulaEndRadius, 1, 0);
      } else {
        nebulaDensity = 0; // No nebula beyond the end radius
      }
      
      // Get Perlin noise value for current pixel
      float noiseValue = noise(x * 0.01, y * 0.01);

      float r, g, b;
      
      if (nebulaDensity > 0.5) {
        
        // RED
        //r = map(nebulaDensity, 0.5, 1, 128, 255); // Light red to pastel pink
        //g = map(nebulaDensity, 0.5, 1, 0, 120); // Adding some green to create the pastel pink
        //b = map(nebulaDensity, 0.5, 1, 0, 120); // Adding some blue to create the pastel pink
      
        // BLUE
        //r = map(nebulaDensity, 0.5, 1, 0, 20); 
        //g = map(nebulaDensity, 0.5, 1, 10, 130); 
        //b = map(nebulaDensity, 0.5, 1, 80, 255); 
        
        // PURPLE
        //r = map(nebulaDensity, 0.5, 1, 120, 245); 
        //g = map(nebulaDensity, 0.5, 1, 50, 150); 
        //b = map(nebulaDensity, 0.5, 1, 125, 200); 
        
        // YELLOW
        //r = map(nebulaDensity, 0.5, 1, 170, 255); 
        //g = map(nebulaDensity, 0.5, 1, 120, 200); 
        //b = map(nebulaDensity, 0.5, 1, 0, 20);
        
        // GREEN
        r = map(nebulaDensity, 0.5, 1, 0, 20); 
        g = map(nebulaDensity, 0.5, 1, 80, 255); 
        b = map(nebulaDensity, 0.5, 1, 30, 160); 
        
        // WHITE
        //r = map(nebulaDensity, 0.5, 1, 80, 255); 
        //g = map(nebulaDensity, 0.5, 1, 80, 255); 
        //b = map(nebulaDensity, 0.5, 1, 80, 255); 
        
      } else {
        
        // RED
        r = map(nebulaDensity, 0, 0.5, 0, 128); // Dark red
        g = 0;
        b = 0;
      
        // BLUE
        //r = 0;
        //g = map(nebulaDensity, 0, 0.5, 0, 10); // hint of green to lighten
        //b = map(nebulaDensity, 0, 0.5, 0, 80); // Dark blue
        
        // PURPLE
        //r = map(nebulaDensity, 0, 0.5, 0, 120); // 
        //g = map(nebulaDensity, 0, 0.5, 0, 50); //
        //b = map(nebulaDensity, 0, 0.5, 0, 125); //
        
        // YELLOW
        //r = map(nebulaDensity, 0.5, 1, 0, 170); 
        //g = map(nebulaDensity, 0.5, 1, 0, 120); 
        //b = 0;
        
        // GREEN
        r = 0;
        g = map(nebulaDensity, 0, 0.5, 0, 80); // Dark green
        b = map(nebulaDensity, 0, 0.5, 0, 30); // hint of blue to lighten 
        
        // WHITE
        //r = map(nebulaDensity, 0, 0.5, 0, 80);
        //g = map(nebulaDensity, 0, 0.5, 0, 80);
        //b = map(nebulaDensity, 0, 0.5, 0, 80);
      }
      
      
      // Apply an additional overall noise factor for texture
      float texture = noise(x * 0.01, y * 0.01);
      r *= texture;
      g *= texture;
      b *= texture;
      
      // Assign color to pixel with the calculated noise value for red and blue
      nebula.pixels[x + y * nebula.width] = color(r, g, b, 255 * noiseValue);
    }
  }
  nebula.updatePixels();
  nebula.endDraw();
}

void keyPressed() {
  
  if (key == 's'|| key == 'S') {
    saveFrame("nebula###.png");
  } else if (key == ENTER || key == RETURN) {
    if (loopFlag == 1) {
      noLoop();
    } else {
      loop();
    }
    loopFlag *= -1;
  }
}

///////////////////////////////////

//void star(float x, float y, float radius1, float radius2, int npoints) {
//  float angle = TWO_PI / npoints;
//  float halfAngle = angle/2.0;
//  nebula.beginShape();
//  for (float a = 0; a < TWO_PI; a += angle) {
//    float sx = x + cos(a) * radius2;
//    float sy = y + sin(a) * radius2;
//    nebula.vertex(sx, sy);
//    sx = x + cos(a+halfAngle) * radius1;
//    sy = y + sin(a+halfAngle) * radius1;
//    nebula.vertex(sx, sy);
//  }
//  nebula.endShape(CLOSE);
//}
