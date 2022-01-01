class Circle {
  void draw() {
    float cx = width/2;
    float cy = height/2;
    float r = 350;

    float angle = 0;
    float angleStep = PI/30;

    for (int i = 0; i < 30; i++) {
      float x1 = cx + (r * cos(angle));
      float y1 = cy + (r * sin(angle));
      float x2 = cx + (r * cos(angle+PI));
      float y2 = cy + (r * sin(angle+PI));
      line(x1, y1, x2, y2);
      angle = angle + angleStep;
    }
  }
}
