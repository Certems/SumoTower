class board{
    ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
    float tileSize = 30.0;
    PVector centreOffset;

    float tileSF = 0.9; //Display scale factor

    board(PVector dimensions){
        generateBoard(dimensions);
        populateBoardPreset(-1);
        centreOffset = calcBoardCentreOffset();
    }

    void generateBoard(PVector dim){
        /*
        Generates a blank board of given size
        */
        tiles.clear();
        for(int j=0; j<dim.y; j++){
            tiles.add(new ArrayList<tile>());
            for(int i=0; i<dim.x; i++){
                tile newTile = new tile(false);
                tiles.get(j).add(newTile);
            }
        }
    }
    void populateBoardPreset(int preset){
        /*
        Adds walls into the board according to a preset pattern
        */
        if(preset == -1){
            int gHeight = floor(tiles.size()/2.0);
            for(int i=0; i<tiles.get(0).size(); i++){
                if(i % 3 == 0){
                    tiles.get(gHeight).get(i).collideable = true;
                }
            }
        }
    }
    PVector calcBoardCentreOffset(){
        /*
        Calculates the offset required such that the given centre position is the 
        actual centre of the board
        */
        return new PVector(-tileSize*tiles.get(0).size()/2.0, -tileSize*tiles.size()/2.0);
    }
}