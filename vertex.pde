class Vertex {
  float x, y;
  Vertex(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void stroke() {
    ellipse(x, y, 8, 8); 
  }
}
