class manager{
    /*
    states;
    0 = playState
    ...
    */
    state_play cState_play = new state_play();
    //...

    ArrayList<Integer> cStates = new ArrayList<Integer>();

    manager(){
        cStates.add(0);
    }

    void display(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.display();
            }
            //...
        }
    }
    void calc(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.calc();
            }
            //...
        }
    }
    void keyPressed_Manager(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.keyPressed_Manager();
            }
            //...
        }
    }
    void keyReleased_Manager(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.keyReleased_Manager();
            }
            //...
        }
    }
    void mousePressed_Manager(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.mousePressed_Manager();
            }
            //...
        }
    }
    void mouseReleased_Manager(){
        for(int i=0; i<cStates.size(); i++){
            if(cStates.get(i) == 0){
                cState_play.mouseReleased_Manager();
            }
            //...
        }
    }
}