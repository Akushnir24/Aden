import java.util.*; 
int interval= 100;
int currentIterations = 0;
int lastRecordedTime  = 0;

int[][] grid;
int gridSize = 40;

int aircraftCarrier = 5;
int battleship= 4;
int submarine= 3;
int cruiser= 3;
int destroyer= 2;
int shipNumb=0;

boolean gameOver= false;
int shotsTaken = 0;
int shotsLanded= 0;

boolean mousePressed=false;
int x=0;

String currentMode;
boolean targetMode= false;
int targetModeAttempts= 4;
int lastShotX= 0;
int lastShotY= 0;
 
color ship= color(150, 156, 163);
color hit = color(247, 57, 57);
color miss= color(247, 114, 57);

final int SHIP=  1;
final int HIT= -1;
final int MISS= -2;

void settings() {
    size(641, 361);  
}
void setup(){
    stroke(50);
    grid = new int[width/gridSize][height/gridSize];
    for(int x=0; x < width/gridSize; x++) {
        for(int y=0; y< height/gridSize; y++) {
            grid[x][y] = 0;
        }
    }
    
    placeShips();
}

void draw() { 
  //placeShips();
    background(color(50, 57, 66));
    for (int x=0; x < width/gridSize; x++) {
        for (int y=0; y < height/gridSize; y++) {
           if(grid[x][y] == SHIP) {
             fill(ship);  
           } else if (grid[x][y] == HIT) { 
             fill(hit);
           } else if (grid[x][y] == MISS) { 
             fill(miss);
           }
           rect(x*gridSize, y*gridSize, gridSize, gridSize);
           noFill();
       } 
   } 
   
   if (targetMode) {
       currentMode = "target";    
   } else {
        currentMode = "hunt";   
   }
   
   surface.setTitle("Battleships - Mode " + currentMode + " - Fired: " + 
                    parseInt(shotsTaken) + " Hits " + parseInt(shotsLanded));
    
   if (gameOver) {
       textSize(50);
       fill(255);
       text("GAME OVER!", width/4, height/2); 
       noFill();
   }
   if(millis()-lastRecordedTime>interval) { 
     
     iteration();
     currentIterations++;
     lastRecordedTime = millis();
   }
}

boolean allShipsDestroyed() {
     for(int x=0; x < width/gridSize; x++) {
        for(int y=0; y< height/gridSize; y++) {
            if (grid[x][y] == SHIP) {
                return false;
            }
        }
    }
    gameOver = true;
    return true;
}

ArrayList<PVector> findTargets(int fromX, int fromY) {    
    ArrayList<PVector> coords = new ArrayList<PVector>();
    coords.add(new PVector(fromX+1, fromY));
    coords.add(new PVector(fromX-1, fromY));
    coords.add(new PVector(fromX, fromY+1));
    coords.add(new PVector(fromX, fromY-1));
    return coords;
}

void iteration() {
    if (allShipsDestroyed()) {
        return;   
    }
    
    int x = 0;
    int y = 0;
    
    if (targetMode) {
        targetModeAttempts = targetModeAttempts - 1;
        ArrayList<PVector> tg = findTargets(lastShotX, lastShotY);
        PVector p = tg.get(targetModeAttempts);
        x = int(p.x);
        y = int(p.y);
        if (targetModeAttempts == 0) {                
            targetMode = false;
            targetModeAttempts = 4;    
        } 
    } else {
        x = int(random(width/gridSize));
        y = int(random(height/gridSize));
    }
    
    if (grid[x][y] == SHIP) {
        grid[x][y] = HIT;    
        targetMode = true;
        lastShotX = x;
        lastShotY = y;  
        shotsLanded++;
    } else if (grid[x][y] != HIT && grid[x][y] != SHIP) {
        grid[x][y] = MISS; 
    } 
    
    shotsTaken++;
}

void placeShips() {
  float x1= random(1,3);
  float y1= random(1,3);
  int shipx1= (int)x1;
  int shipy1= (int)y1;
  int spacing =0;
  int shipLength=5;
  int t=0;
  while (shipNumb<6){

    while( t <= shipLength){
      grid[shipx1][shipy1+t]= SHIP;
      t++;    
    }
  float spacing1= random(1,3);
  spacing= (int)spacing1;
  shipx1=shipx1+spacing;
  shipy1=shipy1+spacing-1;
  shipNumb++;
  t=t-t;
  float shipLengthf= random(0,4);
  shipLength=(int)shipLengthf;
  }
   /* System.out.println("The flowing numbers you put in will choose your ship locations(The grid is 16 by 9 where 0 is the first row/col)");  
    Scanner ship1xx = new Scanner(System.in);
    System.out.println("What X coordinate would you like your first ship to start at(this ship goes down is 5 blocks long between 0 and 15): ");
    int ship1x= ship1xx.nextInt();
    ship1xx.close();
    Scanner ship1yy = new Scanner(System.in);
    System.out.println("What Y coordinate would you like your first ship to start at(between o and 4): ");
    int ship1y= ship1yy.nextInt();
    ship1yy.close();
    grid[ship1x][ship1y] = SHIP;
    grid[ship1x][ship1y+1] = SHIP;
    grid[ship1x][ship1y+2] = SHIP;
    grid[ship1x][ship1y+3] = SHIP;
    grid[ship1x][ship1y+4] = SHIP;
     
    Scanner ship2xx = new Scanner(System.in);
    System.out.println("What X coordinate would you like your second ship to start at(this ship goes across is 4 blocks long between 0 and 12): ");
    int ship2x= ship2xx.nextInt();
    ship2xx.close();
    Scanner ship2yy = new Scanner(System.in);
    System.out.println("What Y coordinate would you like your second ship to start at(between 0 and 8): ");
    int ship2y= ship2yy.nextInt();
    ship2yy.close();
    grid[ship2x][ship2y] = SHIP;
    grid[ship2x+1][ship2y] = SHIP;
    grid[ship2x+2][ship2y] = SHIP;
    grid[ship2x+3][ship2y] = SHIP;
 
    Scanner ship3xx = new Scanner(System.in);
    System.out.println("What X coordinate would you like your third ship to start at(this ship goes down is 3 blocks long between 0 and 15): ");
    int ship3x= ship3xx.nextInt();
    ship3xx.close();
    Scanner ship3yy = new Scanner(System.in);
    System.out.println("What Y coordinate would you like your third ship to start at(between 0 and 6): ");
    int ship3y= ship3yy.nextInt();
    ship3yy.close();    
    grid[ship3x][ship3y] = SHIP;
    grid[ship3x][ship3y+1] = SHIP;
    grid[ship3x][ship3y+2] = SHIP;
    
    Scanner ship4xx = new Scanner(System.in);
    System.out.println("What X coordinate would you like your fourth ship to start at(this ship goes arcoss is 2 blocks long between 0 and 14): ");
    int ship4x= ship4xx.nextInt();
    ship4xx.close();
    Scanner ship4yy = new Scanner(System.in);
    System.out.println("What Y coordinate would you like your fourth ship to start at(between 0 and 8): ");
    int ship4y= ship4yy.nextInt();
    ship4yy.close();     
    grid[ship4x][ship4y] = SHIP;
    grid[ship4x+1][ship4y] = SHIP;   
    
    Scanner ship5xx = new Scanner(System.in);
    System.out.println("What X coordinate would you like your fifth ship to start at(this ship goes across is 3 blocks long between 0 and 13): ");
    int ship5x= ship5xx.nextInt();
    ship5xx.close();
    Scanner ship5yy = new Scanner(System.in);
    System.out.println("What Y coordinate would you like your fifth ship to start at(between 0 and 8): ");
    int ship5y= ship4yy.nextInt();
    ship5yy.close();    
    grid[ship5x][ship5y] = SHIP;
    grid[ship5x+1][ship5y] = SHIP;
    grid[ship5x+2][ship5y] = SHIP;
    
    
    
    
    
    
    
    
    
    
    /*System.out.println("Where you click will spawn a boat. DO NOT PUT A BOAT ON THE EDGE!");
    
    while(x==0){
    System.out.println("as");
    }
    System.out.println("mouse");
    while (shipNumb<=4){
     
          if(shipNumb==0){
 
            System.out.println("This boat goes down 5 units");
            int shipx1= mouseX/40;
            int shipy1=mouseY/40;
            grid[shipx1][shipy1] = SHIP;
            grid[shipx1][shipy1+1] = SHIP;
            grid[shipx1][shipy1+2] = SHIP;
            grid[shipx1][shipy1+3] = SHIP;
            grid[shipx1][shipy1+4] = SHIP; 
            }
          
          if(shipNumb==1){
            System.out.println("This boat goes to the right 4 units");
            int shipx2= mouseX/40;
            int shipy2=mouseY/40;
            grid[shipx2][shipy2] = SHIP;
            grid[shipx2+1][shipy2] = SHIP;
            grid[shipx2+2][shipy2] = SHIP;
            grid[shipx2+3][shipy2] = SHIP;
          }
          if(shipNumb==2){
            System.out.println("This boat goes down 3 units");
            int shipx3= mouseX/40;
            int shipy3=mouseY/40;
            grid[shipx3][shipy3] = SHIP;
            grid[shipx3][shipy3+1] = SHIP;
            grid[shipx3][shipy3+2] = SHIP;
          }
          if(shipNumb==3){
            System.out.println("This boat goes to the right 2 units");
            int shipx4= mouseX/40;
            int shipy4=mouseY/40;
            grid[shipx4][shipy4] = SHIP;
            grid[shipx4+1][shipy4] = SHIP; 
          }
          if(shipNumb==4){
            System.out.println("This boat goes to the right 3 units");
            int shipx5= mouseX/40;
            int shipy5=mouseY/40;
            grid[shipx5][shipy5] = SHIP;
            grid[shipx5+1][shipy5] = SHIP;
            grid[shipx5+2][shipy5] = SHIP;
          }
          shipNumb++;
         }
    }


   // }*/
   }
   
