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
        text("SCORE: " + this.score, ((width / 100) * 3), ((height / 100) * 10));
        text("LEVEL: " + this.level, ((width / 100) * 3), ((height / 100) * 10) + 64);
    }
}