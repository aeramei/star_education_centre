class Shape{
  void draw(){}
}


class Circle implements Shape
{
  @override
  void draw() {
    print("Inside Circle::draw() method.");
  }

}


class Square implements Shape {
  @override
  void draw() {
    print("Inside Square::draw() method.");
    // TODO: implement draw
  }


}

class Rectangle implements Shape
{
  @override
  void draw() {
    print("Inside Rectangle::draw() method.");
  }

}

class ShapeFactory{
  static Shape getShape(String data){
    Shape s;
    if( data == 'circle'){
      s=new Circle();
    }
else if (data =='square'){
s=new Square();
}
  else{
  s= new Rectangle();
  }
return s;
  }
}

void main (){
  Shape s=ShapeFactory.getShape('retangle');
  s.draw();

  s=ShapeFactory.getShape('Circle');
  s.draw();
}

