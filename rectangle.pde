class Rectangle {
  float x, y, width, height;
  Rectangle(float x, float y, float wd, float ht) {
    this.x = x;
    this.y = y;
    this.width = wd;
    this.height = ht;
  }

  Vertex topLeft() {
    return new Vertex(this.x, this.y);
  }

  Vertex topRight() {
    return new Vertex(this.x + this.width, this.y);
  }

  Vertex bottomLeft() {
    return new Vertex(this.x, this.y + this.height);
  }

  Vertex bottomRight() {
    return new Vertex(this.x + this.width, this.y + this.height);
  }

  Vertex[] vertices() {
    Vertex[] res = new Vertex[4];
    res[0] = topLeft(); // top-left
    res[1] = topRight(); // top-right
    res[2] = bottomLeft(); // bottom-left
    res[3] = bottomRight(); //bottom-right
    return res;
  }

  Vertex centroid() {
    float x  = this.x + this.width/2;
    float y = this.y + this.height/2;
    return new Vertex(x, y);
  }
  
  Line topSide() {
    return new Line(topLeft(), topRight());
  }
  
  Line rightSide() {
    return new Line(topRight(), bottomRight());
  }
  
  Line bottomSide() {
    return new Line(bottomLeft(), bottomRight());
  }
  
  Line leftSide() {
    return new Line(topLeft(), bottomLeft());
  }
  
  Line[] sides() {
    Line[] res = new Line[4];
    res[0] = topSide();
    res[1] = rightSide();
    res[2] = bottomSide();
    res[3] = leftSide();
    return res;
  }
  
  void stroke(){
    Line[] rSides = sides(); 
    for (int i = 0; i < 4; i++) {
       rSides[i].stroke();
    }
  }
}
