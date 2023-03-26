class sumo{
    PVector pos;    //Tile coordinate the sumo is currently at
    PVector dir;    //Direction the sumo is looking, keep as a UNIT vec

    ArrayList<action> actionSet = new ArrayList<action>();

    sumo(PVector initPos, PVector initDir){
        pos = initPos;
        dir = initDir;
    }

    //pass
}