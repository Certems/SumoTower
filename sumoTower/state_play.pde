class state_play{
    board cBoard = new board(new PVector(10,8));
    ArrayList<sumo> sumos = new ArrayList<sumo>();  //Holds all sumos, 0th is player, rest are AI (Everything by Reference)

    state_play(){
        sumo newSumo1 = new sumo(new PVector(2,2), new PVector(1,0));
        sumo newSumo2 = new sumo(new PVector(6,6), new PVector(0,1));
        cBoard.tiles.get(2).get(2).cSumo = newSumo1;
        cBoard.tiles.get(6).get(6).cSumo = newSumo2;
        sumos.add(cBoard.tiles.get(2).get(2).cSumo);
        sumos.add(cBoard.tiles.get(6).get(6).cSumo);
    }

    void display(){
        displayBackground();
        displayBoard(new PVector(width/2.0, height/2.0), cBoard);
        displaySumos(new PVector(width/2.0, height/2.0), cBoard);
        displaySumoActionSet(sumos.get(0), new PVector(mouseX, mouseY));
    }
    void calc(){
        //pass
    }
    void keyPressed_Manager(){
        if(key == '1'){
            println("state_play; 1 Pressed");
            action newAction = new action(1);
            sumos.get(0).actionSet.add(newAction);
            //moveSumoFwd(sumos.get(0).pos, cBoard);
        }
        if(key == '2'){
            println("state_play; 2 Pressed");
            action newAction = new action(2);
            sumos.get(0).actionSet.add(newAction);
            //rotateSumo(sumos.get(0).pos, true, cBoard);
        }
        if(key == '3'){
            println("state_play; 3 Pressed");
            action newAction = new action(3);
            sumos.get(0).actionSet.add(newAction);
            //rotateSumo(sumos.get(0).pos, false, cBoard);
        }
    }
    void keyReleased_Manager(){
        //pass
    }
    void mousePressed_Manager(){
        //pass
    }
    void mouseReleased_Manager(){
        //pass
    }

    //**Graphics
    void displayBackground(){
        background(20,20,20);
    }
    void displayBoard(PVector centrePos, board givenBoard){
        pushMatrix();
        pushStyle();
        noStroke();
        rectMode(CENTER);
        translate(givenBoard.centreOffset.x, givenBoard.centreOffset.y);
        for(int j=0; j<givenBoard.tiles.size(); j++){
            for(int i=0; i<givenBoard.tiles.get(j).size(); i++){
                if(givenBoard.tiles.get(j).get(i).collideable){
                    fill(255,0,0);}
                else{
                    fill(255);}
                rect(centrePos.x +i*givenBoard.tileSize, centrePos.y +j*givenBoard.tileSize, givenBoard.tileSize*givenBoard.tileSF, givenBoard.tileSize*givenBoard.tileSF);
            }
        }
        popStyle();
        popMatrix();
    }
    void displaySumos(PVector centrePos, board givenBoard){
        pushMatrix();
        pushStyle();
        fill(255,0,0);
        stroke(255,0,0);
        strokeWeight(3);
        translate(givenBoard.centreOffset.x, givenBoard.centreOffset.y);
        for(int j=0; j<givenBoard.tiles.size(); j++){
            for(int i=0; i<givenBoard.tiles.get(j).size(); i++){
                if(givenBoard.tiles.get(j).get(i).cSumo != null){
                    ellipse(centrePos.x +i*givenBoard.tileSize, centrePos.y +j*givenBoard.tileSize, givenBoard.tileSize*givenBoard.tileSF, givenBoard.tileSize*givenBoard.tileSF);
                    line(centrePos.x +i*givenBoard.tileSize, centrePos.y +j*givenBoard.tileSize, centrePos.x +i*givenBoard.tileSize +1.1*givenBoard.tileSize*givenBoard.tileSF*givenBoard.tiles.get(j).get(i).cSumo.dir.x, centrePos.y +j*givenBoard.tileSize +1.1*givenBoard.tileSize*givenBoard.tileSF*givenBoard.tiles.get(j).get(i).cSumo.dir.y);
                }
            }
        }
        popStyle();
        popMatrix();
    }
    void displaySumoActionSet(sumo cSumo, PVector cPos){
        pushStyle();

        int dispMax       = 4;    //Max number of actions shown in a row
        int cRow          = 0;
        float dispSize    = 10.0;
        float dispSpacing = 1.1;

        fill(255);
        noStroke();
        rectMode(CENTER);

        for(int i=0; i<cSumo.actionSet.size(); i++){
            if(i % dispMax == 0){
                cRow++;}
            if(cSumo.actionSet.get(i).type == 1){
                fill(200,100,100);}
            if(cSumo.actionSet.get(i).type == 2){
                fill(100,200,100);}
            if(cSumo.actionSet.get(i).type == 3){
                fill(100,100,200);}
            rect(cPos.x +(i%dispMax)*dispSize*dispSpacing, cPos.y +cRow*dispSize*dispSpacing, dispSize, dispSize);
        }

        popStyle();
    }

    //**Calculations
    void moveSumo(PVector sPos, PVector move, board givenBoard){
        /*
        sPos        = sumo pos = target sumo to be moved's position
        move        = where to move them to, FROM their current position
        givenBoard  = board this occurs on

        Move the sumo at sPos by a vector move
        0. Check possible
        1. Copy sumo to target
        2. Remove old sumo
        3. Change sumo's remembered position
        */
        //####
        //## ALSO CHECK 'sPos' IS ON BOARD
        //####
        boolean withinX = (0 <= sPos.x +move.x ) && ( sPos.x +move.x < givenBoard.tiles.get(0).size() );
        boolean withinY = (0 <= sPos.y +move.y ) && ( sPos.y +move.y < givenBoard.tiles.size() );
        if(withinX && withinY){ //If not leaving board
            boolean targetWalkable = !givenBoard.tiles.get(int(sPos.y +move.y)).get(int(sPos.x +move.x)).collideable;
            if(targetWalkable){ //If target is not a wall
                boolean sumoAtInit   = givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo != null;
                boolean sumoAtTarget = givenBoard.tiles.get(int(sPos.y +move.y)).get(int(sPos.x +move.x)).cSumo != null;
                if(sumoAtInit && !sumoAtTarget){   //If sumo exists there
                    //Actually move the sumo
                    givenBoard.tiles.get(int(sPos.y +move.y)).get(int(sPos.x +move.x)).cSumo = givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo;  //(1)
                    givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo = null;    //(2)
                    givenBoard.tiles.get(int(sPos.y +move.y)).get(int(sPos.x +move.x)).cSumo.pos = new PVector(sPos.x +move.x, sPos.y +move.y); //(3)
                }
            }
        }
    }
    void rotateSumo(PVector sPos, boolean clockwise, board givenBoard){
        /*
        Rotates a sumo either 90deg. cw or ccw
        */
        boolean withinX = (0 <= sPos.x ) && ( sPos.x < givenBoard.tiles.get(0).size() );
        boolean withinY = (0 <= sPos.y ) && ( sPos.y < givenBoard.tiles.size() );
        if(withinX && withinY){ //If not leaving board
            boolean sumoAtInit   = givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo != null;
            if(sumoAtInit){     //If sumo exists there
                //Actually rotate sumo
                PVector newDir = new PVector(1,0);
                if(clockwise){      //CW
                    newDir = new PVector(-givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo.dir.y,  givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo.dir.x);}
                else{               //CCW
                    newDir = new PVector( givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo.dir.y, -givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo.dir.x);}
                givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo.dir = new PVector(newDir.x, newDir.y);
            }
        }
    }
    void moveSumoFwd(PVector sPos, board givenBoard){
        sumo givenSumo = givenBoard.tiles.get(int(sPos.y)).get(int(sPos.x)).cSumo;
        moveSumo(sPos, givenSumo.dir, givenBoard);
    }
    void performAction(sumo cSumo, action cAction, board givenBoard){
        if(cAction.type == 1){
            moveSumoFwd(cSumo, givenBoard);
        }
        if(cAction.type == 2){
            rotateSumo(cSumo.pos, true, givenBoard)
        }
        if(cAction.type == 3){
            rotateSumo(cSumo.pos, false, givenBoard)
        }
    }
}