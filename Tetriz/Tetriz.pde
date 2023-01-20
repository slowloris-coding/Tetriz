JSONArray TSHAPES_CFG;

float BRD_H = 0.0;
float BRD_W = 0.0;
float BRD_X = 0.0;
float BRD_Y = 0.0;
float BRD_STROKE = 4;
int BRD_ROWS = 25;
int BRD_COLS = 15;

float BLK_SIZE = 0.0;

GBoard BRD;
BlockStore BLK_STORE;
Manager MGR;
Player PLAYER;

void setup() {
    fullScreen();
    frameRate(60);

    TSHAPES_CFG = loadJSONArray("shapes.config.json");
    BRD = new GBoard();
    BLK_STORE = new BlockStore();
    MGR = new Manager();
    PLAYER = new Player();
}

void draw() {
    background(0);

    if (MGR.gameOver){
        textSize(256);
        fill(0xFFFF0000);
        text("GAME OVER", (width / 5), ((height / 2) - 128));
        textSize(64);
        fill(0xFFFFFFFF);
        text("Press ESC...", (width / 4), (height / 2));
    }
    else{
        BRD.draw();
        BLK_STORE.draw();
        MGR.update();
        PLAYER.display();
    }
}

void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
            MGR.active_shape.rotateShape();
        }
        else if(keyCode == LEFT) {
            MGR.active_shape.moveLeft();
        }
        else if (keyCode == RIGHT) {
            MGR.active_shape.moveRight();
        }
        else if (keyCode == DOWN) {
            if (!MGR.active_shape.isDocked()){
                MGR.active_shape.fallDown();
            }
        }
    }
}