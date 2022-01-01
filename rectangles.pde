import processing.pdf.*;
import grab.*;
Grab grab = new Grab(this);

import interfascia.*;

GUIController c;
IFButton b1, b2, b3, b4, b5;

Circle circle;
Rectangle r;
boolean rainbow = false;
color bg;

void setup() {
  size(800, 800);
  pixelDensity(2);
  colorMode(HSB);
  bg = color(230);

  circle = new Circle();
  r = new Rectangle(90, 90, 650, 650);

  c = new GUIController (this);
  
  IFLabel row1 = new IFLabel("Background color", 10, 10);

  IFButton bg1 = new IFButton ("Green", 20, 20, 40, 17);
  IFButton bg2 = new IFButton ("Blue", 60, 20, 40, 17);
  IFButton bg3 = new IFButton ("Red", 100, 20, 40, 17);
  IFButton bg4 = new IFButton ("White", 140, 20, 40, 17);

  bg1.addActionListener(this);
  bg2.addActionListener(this);
  bg3.addActionListener(this);
  bg4.addActionListener(this);
  
  IFLookAndFeel greenLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  greenLook.baseColor = color(100, 180, 100);
  greenLook.highlightColor = color(70, 135, 70);
  greenLook.textColor = color(70, 135, 255);


  c.setLookAndFeel(greenLook);

  c.add(row1);
  c.add(bg1);
  c.add(bg2);
  c.add(bg3);
  c.add(bg4);
}


void draw() {
  background(bg);

  Vertex centroid = r.centroid();
  Vertex[] vertices = new Vertex[0];
  Line[] sides = new Line[4];
  sides[0] = r.leftSide();
  sides[0] = new Line(sides[0].v2, sides[0].v1);
  sides[1] = r.topSide();
  sides[2] = r.rightSide();
  sides[3] = r.bottomSide();
  sides[3] = new Line(sides[3].v2, sides[3].v1);
  for (int i = 0; i < sides.length; i++) {
    Line side = sides[i];
    Line[] splits = side.split(5);
    for (int j = 0; j < splits.length; j++) {
      vertices = (Vertex[])append(vertices, splits[j].v1);
      if (j == splits.length-1) {
        vertices = (Vertex[])append(vertices, splits[j].v2);
      }
    }
  }

  strokeWeight(0.5);
  for (int i = 0; i < vertices.length; i++) {
    Line cL = new Line(centroid, vertices[i]);
    if (rainbow) {
      stroke(i, 200, 200, 255);
    }
    cL.stroke();
  }
  
  r.stroke();

  // cascade rectangles
  int numCascades = 10;
  Line ctl = new Line(r.centroid(), r.topLeft());
  float cascadeStep = ctl.length()/numCascades/2;
  for(int i = 1; i < numCascades+2; i++){
    float cascadeDist = cascadeStep*i;
    Rectangle rec = new Rectangle(90+cascadeDist, 90+cascadeDist, 650-cascadeDist*2, 650-cascadeDist*2);
    rec.stroke();
  }
  
  PImage img;
  img = loadImage("me2.jpeg");
  image(img, 89*3, 89*3, 652-89*4, 652-89*4);
}


void actionPerformed (GUIEvent e) {
  String label = ((IFButton)e.getSource()).getLabel();
  if (label == "Blue") {
    bg = color(#646482);
    stroke(#649B64);
    tint(#0099CC, 240);
  } else if (label == "Green") {
    bg = color(#649B64);
    stroke(#646482);
    tint(#CC5252, 240); // red
  } else if (label == "White") {
    bg = color(230);
    stroke(0);
    tint(#0099CC, 240);  // Tint blue and set transparency
  } else if (label == "Red") {
    bg = color(#CC5252);
    stroke(0);
        tint(#0099CC, 240);  // Tint blue and set transparency

  }
}
