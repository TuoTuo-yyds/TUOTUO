final int TOTAL = 2400;
CosmicOrbitalParticle[] particles = new CosmicOrbitalParticle[TOTAL];
float time;

void setup() {
  fullScreen(P2D);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  for (int i=0; i<TOTAL; i++) {
    particles[i] = new CosmicOrbitalParticle();
  }
}

void draw() {
  
  fill(0, 0, 0, 7);
  rect(0,0,width,height);
  
  time += 0.0085;
  translate(width/2, height/2);
  
  drawParticleRing();
  
  for (CosmicOrbitalParticle p : particles) {
    p.update();
    p.display();
    p.orbitMouse();    
    p.galaxyMotion();  
  }
}

void drawParticleRing() {
  float baseRadius = map(sin(time * 1.6), -1, 1, 130, 250);
  float ringHue = (time * 45) % 360;
  
  pushMatrix();
  rotate(time * 0.9);
  
  for (int angle=0; angle<360; angle+=10) {
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
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    vx = random(-0.45, 0.45);
    vy = random(-0.45, 0.45);
    
    int layer = int(random(4));
    if (layer == 0) {
      size = random(1.0, 2.0);  
      orbitSpeed = random(0.10, 0.15);
      orbitRange = random(70, 170);
      particleType = 0;
    } 
    else if (layer == 1) {
      size = random(2.3, 4.2);   
      orbitSpeed = random(0.06, 0.11);
      orbitRange = random(170, 290);
      particleType = 1;
    } 
    else if (layer == 2) {
      size = random(4.5, 7.0);   
      orbitSpeed = random(0.03, 0.08);
      orbitRange = random(290, 410);
      particleType = 2;
    } 
    else {
      size = random(7.2, 10.5);  
      orbitSpeed = random(0.01, 0.05);
      orbitRange = random(410, 560);
      particleType = 3;
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
    
    if(x>width/2) x=-width/2;
    if(x<-width/2) x=width/2;
    if(y>height/2) y=-height/2;
    if(y<-height/2) y=height/2;
  }

  void galaxyMotion() {
    float waveX = cos(time + x*0.007 + offset) * 0.12;
    float waveY = sin(time + y*0.007 + offset) * 0.12;
    vx += waveX;
    vy += waveY;
    
    float force = map(dist(x,y,0,0), 0, width/2, 0.02, 0);
    vx -= x * force;
    vy -= y * force;
  }

  void orbitMouse() {
    float mx = mouseX - width/2;
    float my = mouseY - height/2;
    float dx = mx - x;
    float dy = my - y;
    float dis = sqrt(dx*dx+dy*dy);
    
    if(dis < orbitRange){
      float rotX = -dy * orbitSpeed * orbitDir;
      float rotY = dx * orbitSpeed * orbitDir;
      vx += dx/dis * 0.16 + rotX;
      vy += dy/dis * 0.16 + rotY;
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
