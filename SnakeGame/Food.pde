
class Food {
   Snake snake;
   PVector position = new PVector();
   float size;
   
//---------------------------------------
   Food(Snake snake) {
     this.snake = snake;
     this.size = snake.squareSize;
     this.placeRandom();
   }
//--------------------------------------
   void place(float posX, float posY) {
     this.position.x = posX;
     this.position.y = posY;
   }
   
//--------------------------------------------   
   
   void place(PVector pos) {
     this.position = pos.copy();  
   }
   
//-----------------------------------------
   void placeRandom() {
     
     PVector displacement = new PVector((int) random(-this.snake.environment.w/2, this.snake.environment.w/2)*this.size, (int) random(-this.snake.environment.h/2, this.snake.environment.h/2)*this.size); 
     PVector newPosition = this.position.copy();
     newPosition.add(displacement);
     if (this.snake.outOfBounds(newPosition)) {
       this.placeRandom();  
     } else {
       this.place(newPosition);  
     }
   }
   
   /*void placeRandom() {
     PVector displacement = new PVector(this.snake.environment.w + 2*this.size , this.snake.environment.h + this.size);
     PVector newPosition = this.position.copy();
     newPosition.add(displacement);
     if (this.snake.outOfBounds(newPosition)) {
       println("Ta fuera");
       this.place(newPosition);
     } else {
       println("Ta dentro");
       this.place(newPosition);
     }
   }*/
   
//------------------------------------------   
  
   
//------------------------------------------ 
   void display() {
     fill(255, 0, 0);
     rect(this.position.x, this.position.y, this.size, this.size); 
   }
  
}
