class TBlock {
    int row, col;
    int f_clr, s_clr;
    float px, py, x, y;
    float[] dists = new float[4];

    TBlock(float _px, float _py, int _f_clr, int _s_clr, JSONArray _dists){
        for(int i=0; i < 4; ++i){
            this.dists[i] = (_dists.getInt(i) > 0 ? (BLK_SIZE * (_dists.getInt(i))): 0.0);
        }

        this.f_clr = _f_clr;
        this.s_clr = _s_clr;

        this.setPxPy(_px, _py);
    }

    void setPxPy(float _px, float _py){
        this.px = _px;
        this.py = _py;
        this.x = (this.px + this.dists[0]);
        this.y = (this.py + this.dists[1]);
        this.setRC();
    }

    void setRC(){
        this.col = floor(((this.px - BRD_X) + this.dists[0]) / BLK_SIZE);
        this.row = floor(((this.py - BRD_Y) + this.dists[1]) / BLK_SIZE);
    }

    void rotateBlock(){
        float[] tmp_d = new float[4];
        tmp_d[0] = this.dists[3];

        for(int i=0; i < 3; ++i){
            tmp_d[i + 1] = this.dists[i];
        }

        arrayCopy(tmp_d, this.dists);
    }

    boolean checkMoveLeft(){
        return BLK_STORE.isFree(this.row, this.col - 1);
    }

    boolean checkMoveRight(){
        return BLK_STORE.isFree(this.row, this.col + 1);
    }

    boolean checkFall() {
        return BLK_STORE.isFree(this.row + 1, this.col);
    }

    boolean checkRotate() {
        float[] tmp_d = new float[4];
        tmp_d[0] = this.dists[3];

        for(int i=0; i < 3; ++i){
            tmp_d[i + 1] = this.dists[i];
        }

        int c = floor(((this.px - BRD_X) + tmp_d[0]) / BLK_SIZE);
        int r = floor(((this.py - BRD_Y) + tmp_d[1]) / BLK_SIZE);

        return BLK_STORE.isFree(r, c);
    }

    boolean isDocked() {
        return BLK_STORE.isDocked(this.row, this.col);
    }

    void drawBlock(float x, float y, int _rgbHx) {
        int p = 40;
        float w = BLK_SIZE;
        float h = BLK_SIZE;

        color clr = _rgbHx;

        noStroke();
        colorMode(HSB, 360, 100, 100, 100);

        for(int i = 1; i <= p; i++){
            float tw = (w / p) * i;
            float th = (h / p) * i;
            float tx = x + ((w / 2) - (tw / 2));
            float ty = y + ((h / 2) - (th / 2));

            // fill(0, 90, 5, 100);
            fill(clr);
            noStroke();
            rect(tx, ty, tw, th, 5, 5, 5, 5);
        }

        colorMode(RGB, 255);
    }

    void draw(){
        //fill(this.f_clr);
        //stroke(this.s_clr);
        //rect(this.x, this.y, BLK_SIZE, BLK_SIZE);
        this.drawBlock(this.x, this.y, this.f_clr);
    }
}