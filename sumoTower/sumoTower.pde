manager cManager;

void setup(){
    size(450,800, P2D);
    load_All();
    cManager = new manager();
}
void draw(){
    cManager.calc();
    cManager.display();
}

void keyPressed(){
    cManager.keyPressed_Manager();}
void keyReleased(){
    cManager.keyReleased_Manager();}
void mousePressed(){
    cManager.mousePressed_Manager();}
void mouseReleased(){
    cManager.mouseReleased_Manager();}