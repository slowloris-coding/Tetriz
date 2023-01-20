class GBoard {
    GBoard() {
        BRD_H = floor((height / 100) * 95);
        BLK_SIZE = (BRD_H / BRD_ROWS);
        BRD_W = (BLK_SIZE * BRD_COLS);
        BRD_X = ((width / 2) - (BRD_W / 2));
        BRD_Y = ((height / 2) - (BRD_H / 2));
    }

    void draw(){
        fill(0);
        stroke(255);
        strokeWeight(BRD_STROKE);
        rect(BRD_X, BRD_Y, BRD_W, BRD_H);
    }
}