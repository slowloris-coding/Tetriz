class Manager {
    TShape active_shape;
    TShape next_shape;

    int interval = 60;
    boolean gameOver = false;

    Manager(){
        NXT_W = (5 * BLK_SIZE);
        NXT_H = (6 * BLK_SIZE);

        NXT_X = ((BRD_X - NXT_W) - 20);
        NXT_Y = BRD_Y;

        this.active_shape = new TShape(round(random(0, 7)));
        this.active_shape.setActive();
        this.next_shape = new TShape(round(random(0, 7)));
    }

    void newShape() {
        this.active_shape = this.next_shape;
        this.active_shape.setActive();
        this.next_shape = new TShape(round(random(0, 7)));
    }

    void displayNext() {
        fill(0);
        stroke(255);
        strokeWeight(4);
        rect(NXT_X, NXT_Y, NXT_W, NXT_H);

        this.next_shape.draw();
    }

    void update() {
        if ((frameCount % this.interval) == 0) {
            if(!this.active_shape.isDocked()){
                if(keyPressed && keyCode != DOWN){
                    this.active_shape.fallDown();
                }else if(!keyPressed) {
                    this.active_shape.fallDown();
                }
            }
            else {
                if (this.active_shape.y == BRD_Y){
                    this.gameOver = true;
                }

                BLK_STORE.storeShape(this.active_shape.blocks);
                this.newShape();
            }
        }

        this.displayNext();
        this.active_shape.draw();

        if (!this.gameOver){
            for(int ri=0; ri < BRD_ROWS; ++ri){
                if (BLK_STORE.rowIsFull(ri)){
                    BLK_STORE.removeRow(ri);

                    PLAYER.addScore();
                }
            }
        }
    }
}