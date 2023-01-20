class Manager {
    TShape active_shape;
    int interval = 60;
    boolean gameOver = false;

    Manager(){
        this.newShape();
    }

    void newShape() {
        this.active_shape = new TShape(round(random(0, 7)));
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