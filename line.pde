class Line {
  Vertex v1, v2;
  Line(Vertex v1, Vertex v2) {
    this.v1 = v1;
    this.v2 = v2;
  }
  
  float length() {
    return dist(v1.x, v1.y, v2.x, v2.y);  
  }

  Line[] splitHalf() {
    Line[] res = new Line[2];

    float midx = this.v1.x + (this.v2.x - this.v1.x)/2;
    float midy = this.v1.y + (this.v2.y - this.v1.y)/2;

    Vertex midVertex = new Vertex(midx, midy);

    res[0] = new Line(v1, midVertex);
    res[1] = new Line(midVertex, v2);
    return res;
  }
  
  Line[] split(int times) {
   if(times == 0) {
     Line[] res = new Line[1];
     res[0] = new Line(this.v1, this.v2);
     return res;
   }
   Line[] halves = splitHalf();
   Line[] splitLeft = halves[0].split(times-1);
   Line[] splitRight = halves[1].split(times-1);
   return (Line[])concat(splitLeft, splitRight);
  }
  
  void _stroke() {
    line(v1.x, v1.y, v2.x, v2.y);
  }
  
  void puts() {
    println("v1.x=" + v1.x + " v1.y=" + v1.y + " v2.x=" + v2.x + " v2.y=" + v2.y);
  }
}
