
final int TOTAL = 2400;
CosmicOrbitalParticle[] particles = new CosmicOrbitalParticle[TOTAL];
float time;
float posterW, posterH;
float xOffset, yOffset;

final int BG_DARK = color(10, 10, 25);
final int BORDER_COLOR = color(30, 30, 55);
final int TEXT_NEON = color(100, 255, 220);
final int TEXT_HIGHLIGHT = color(255, 180, 255);

void setup() {
  size(800,1000);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();

  float screenRatio = (float)width / height;
  float targetRatio = 3.0 / 4.0;
  if (screenRatio > targetRatio) {
    posterH = height * 0.95;
    posterW = posterH * targetRatio;
  } else {
    posterW = width * 0.95;
    posterH = posterW / targetRatio;
  }
  xOffset = (width - posterW) / 2;
  yOffset = (height - posterH) / 2;

  for (int i = 0; i < TOTAL; i++) {
    particles[i] = new CosmicOrbitalParticle();
  }
}

void draw() {
  background(0);
  fill(BORDER_COLOR);
  rect(xOffset, yOffset, posterW, posterH, 8);
  fill(BG_DARK);
  rect(xOffset+8, yOffset+8, posterW-16, posterH-16, 6);

  drawTopHeader();
  drawAnimationSection();
  drawBottomSplitSection();
  drawBottomFooter();
}


void drawTopHeader() {
  float headerH = posterH * 0.08;
  fill(BORDER_COLOR);
  rect(xOffset+12, yOffset+12, posterW-24, headerH, 4);
  fill(TEXT_NEON);
  textAlign(CENTER, CENTER);
  textSize(40);
  String headerText = "        Dreamy Star River        ";
  text(headerText, xOffset+12, yOffset+12, posterW-24, headerH);
}




void drawAnimationSection() {
  float headerH = posterH * 0.08;
  
  // FIXED SIZE
  float areaW = 700;
  float areaH = 400;

  float areaX = xOffset + (posterW - areaW) / 2;
  float areaY = yOffset + headerH + 20;

  fill(BG_DARK);
  rect(areaX, areaY, areaW, areaH);

  pushMatrix();
  translate(areaX + areaW/2, areaY + areaH/2);

  fill(0, 0, 0, 5);
  rect(-areaW/2, -areaH/2, areaW, areaH);
  
  time += 0.0085;
  drawParticleRing();
  
  for (CosmicOrbitalParticle p : particles) {
    p.update();
    p.display();
    p.orbitMouse();    
    p.galaxyMotion();
  }
  popMatrix();
}


void drawBottomSplitSection() {
  float headerH = posterH * 0.08;
  float footerH = posterH * 0.08;
  float sectionY = yOffset + headerH + 400 + 40;
  float sectionH = posterH - headerH - 400 - footerH - 60;
  float halfW = (posterW - 36) / 2;

  fill(BORDER_COLOR);
  rect(xOffset+12, sectionY, halfW, sectionH, 4);
  fill(TEXT_NEON);
  textAlign(LEFT, TOP);
  textSize(16);
  String coreCode =
    "Core Code:\n"
    + "class CosmicOrbitalParticle {\n"
    + "float x, y, vx, vy, size, hue, orbitSpeed, orbitRange;\n"
    + "CosmicOrbitalParticle() {\n"
    + "x = random(-350,350);y = random(-200,200);\n"
    + "vx = random(-0.45,0.45);vy = random(-0.45,0.45);\n"
    + "size = random(1,10.5);\n"
    + "orbitRange = random(70,560);\n"
    + "orbitSpeed = random(0.01,0.15);\n"
    + "hue = random(30,60);\n"
    + "}\n"
    + "void update() {\n"
    + " x += vx; y += vy; vx *= 0.94; vy *= 0.94;\n"
    + "if(x>350)x=-350; if(x<-350)x=350;\n"
    + " if(y>200)y=-200; if(y<-200)y=200;\n"
    + "}\n";
  text(coreCode, xOffset+20, sectionY+12, halfW-16, sectionH-24);

  fill(BORDER_COLOR);
  rect(xOffset+24+halfW, sectionY, halfW, sectionH, 4);
  fill(TEXT_HIGHLIGHT);
  String concept =
    "Design Concept:\n"
    + "This work is named Dreamy Star River.\n"
    + "I used a particle system to simulate a flowing, colorful galaxy.\n"
    + "Particles move continuously and form a dynamic nebula effect.\n"
    + "A rotating glowing ring is added in the center to enhance the cyber-space atmosphere.\n"
    + "The particles respond to the mouse position, attracting and orbiting around it,\n"
    + "which enhances the sense of interaction and immersion.\n"
    + "Colors change gradually over time to create a neon cyber effect.\n"
    + "Through layered motion and speed control,\n"
    + "the work expresses a romantic, technological, and dreamy cosmic vision.";
  
  text(concept, xOffset+32+halfW, sectionY+12, halfW-16, sectionH-24);
}


void drawBottomFooter() {
  float footerH = posterH * 0.08;
  fill(BORDER_COLOR);
  rect(xOffset+12, yOffset+posterH-footerH-12, posterW-24, footerH, 4);
  fill(TEXT_NEON);
  textAlign(CENTER, CENTER);
  textSize(30);
  String footerText = " Open Source Programming ";
  text(footerText, xOffset+12, yOffset+posterH-footerH-27, posterW-24, footerH);
   textSize(20);
    text("ID: 2024001114       Name: Yuan Shangheng       Teacher: Zhang Fan       2026-03-23 ", xOffset+12, yOffset+posterH-footerH+7, posterW-24, footerH);
}


void drawParticleRing() {
  float baseRadius = map(sin(time * 1.6), -1, 1, 130, 250);
  float ringHue = (time * 45) % 360;
  
  pushMatrix();
  rotate(time * 0.9);
  
  for (int angle = 0; angle < 360; angle += 10) {
    float px = cos(radians(angle)) * baseRadius;
    float py = sin(radians(angle)) * baseRadius;
    fill(ringHue + angle*0.7, 85, 100, 65);
    ellipse(px, py, 2.5, 2.5);
  }
  popMatrix();
}

class CosmicOrbitalParticle {
  float x, y, vx, vy;
  float size;
  float hue;
  float orbitSpeed;
  float orbitDir;
  float orbitRange;
  float offset;
  int particleType;

  CosmicOrbitalParticle() {
    x = random(-350, 350);
    y = random(-200, 200);
    vx = random(-0.45, 0.45);
    vy = random(-0.45, 0.45);
    
    int layer = int(random(4));
    if (layer == 0) {
      size = random(1.0, 2.0);
      orbitSpeed = random(0.10, 0.15);
      orbitRange = random(50, 120);
    } else if (layer == 1) {
      size = random(2.3, 4.2);
      orbitSpeed = random(0.06, 0.11);
      orbitRange = random(120, 220);
    } else if (layer == 2) {
      size = random(4.5, 7.0);
      orbitSpeed = random(0.03, 0.08);
      orbitRange = random(220, 320);
    } else {
      size = random(7.2, 10.5);
      orbitSpeed = random(0.01, 0.05);
      orbitRange = random(320, 400);
    }

    orbitDir = random(1) > 0.5 ? 1 : -1;
    hue = random(30, 60);
    offset = random(180);
  }

  void update() {
    x += vx;
    y += vy;
    vx *= 0.94;
    vy *= 0.94;
    
    
    if(x>350) x=-350;
    if(x<-350) x=350;
    if(y>200) y=-200;
    if(y<-200) y=200;
  }

  void galaxyMotion() {
    float waveX = cos(time + x*0.007 + offset) * 0.12;
    float waveY = sin(time + y*0.007 + offset) * 0.12;
    vx += waveX;
    vy += waveY;
    
    float force = map(dist(x,y,0,0), 0, 350, 0.02, 0);
    vx -= x * force;
    vy -= y * force;
  }

  
  void orbitMouse() {
    float headerH = posterH * 0.08;
    float areaW = 700;
    float areaH = 400;
    float areaX = xOffset + (posterW - areaW)/2;
    float areaY = yOffset + headerH + 20;

   
    if (mouseX < areaX || mouseX > areaX+areaW || mouseY < areaY || mouseY > areaY+areaH) {
      return;
    }

    float mx = mouseX - (areaX + areaW/2);
    float my = mouseY - (areaY + areaH/2);
    float dx = mx - x;
    float dy = my - y;
    float dis = sqrt(dx*dx + dy*dy);
    
   
    float maxInteractiveDistance = 110;
    if (dis > maxInteractiveDistance) return;

    if(dis < orbitRange){
      float rotX = -dy * orbitSpeed * orbitDir;
      float rotY = dx * orbitSpeed * orbitDir;
      vx += dx/dis * 0.10 + rotX;
      vy += dy/dis * 0.10+ rotY; 
    }
  }

  void display() {
    float dynamicHue = (hue + time*38 + dist(x,y,0,0)*0.5) % 360;
    float sat = map(size, 1, 10.5, 75, 95);
    
    fill(dynamicHue, sat, 100, 80);
    ellipse(x,y,size,size);
       
    if(size > 4){
      fill(dynamicHue, sat, 100, 28);
      ellipse(x,y,size*2.0,size*2.0);
    }
  }
}

void keyPressed() {
  if(key == ' '){
    for(int i=0; i<TOTAL; i++){
      particles[i] = new CosmicOrbitalParticle();
    }
  }
}
