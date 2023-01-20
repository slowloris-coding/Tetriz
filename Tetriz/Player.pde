class Player {
    int score = 0;
    int level = 1;

    Player(){}
    void addScore(){
        this.score += 1;

        if ((this.score % 15) == 0){
            this.addLevel();
        }
    }

    void addLevel(){
        this.level += 1;
        MGR.interval -= 5;
    }

    void display() {
        fill(255);
        textSize(64);
        text(this.score + "   points", ((BRD_X + BRD_W) + ((width / 100) * 3)), (BRD_Y + 32));
        text(this.level + "   level", ((BRD_X + BRD_W) + ((width / 100) * 3)), (BRD_Y + 96));
    }
}