class TShape {
    int t, f_clr, s_clr, mx_h, mx_w;
    float x, y, h, w;
    JSONObject shObj; 
    ArrayList<TBlock> blocks = new ArrayList<TBlock>();
    boolean docked = false;

    TShape(int _t){
        this.t = constrain(_t, 0, 6);
        shObj = TSHAPES_CFG.getJSONObject(this.t);

        this.f_clr = unhex(this.shObj.getJSONObject("color").getString("fill"));
        this.s_clr = unhex(this.shObj.getJSONObject("color").getString("stroke"));
        this.h = (BLK_SIZE * this.shObj.getJSONObject("size").getInt("height"));
        this.w = (BLK_SIZE * this.shObj.getJSONObject("size").getInt("width"));
        this.mx_h = this.shObj.getJSONObject("size").getInt("height");
        this.mx_w = this.shObj.getJSONObject("size").getInt("width");

        this.x = (NXT_X + (NXT_W / 2)) - (this.w / 2);
        this.y = (NXT_Y + (NXT_H / 2)) - (this.h / 2);

        for(int bi = 0; bi < this.shObj.getJSONArray("blocks").size(); ++bi){
            this.blocks.add(new TBlock(this.x, this.y, this.f_clr, this.s_clr, this.shObj.getJSONArray("blocks").getJSONArray(bi)));
        }
    }

    void setActive(){
        this.x = BRD_X + (BLK_SIZE * (BRD_COLS / 2));
        this.y = BRD_Y;

        for(int i = 0; i < this.blocks.size(); ++i){
            this.blocks.get(i).setPxPy(this.x, this.y);
        }
    }

    void rotateShape(){
        float sy = this.y;
        float sx = this.x;

        float sw = this.w;
        float sh = this.h;

        this.y = (this.y + this.h) - this.w;
        this.x = (this.x + this.w) - this.h;

        this.w += this.h;
        this.h = (this.w - this.h);
        this.w -= this.h; 

        boolean ok = true;

        for(int i = 0; i < this.blocks.size(); ++i){
            this.blocks.get(i).setPxPy(this.x, this.y);
            ok = this.blocks.get(i).checkRotate();

            if (!ok){
                break;
            }
        }

        if (ok){
            for(int i = 0; i < this.blocks.size(); ++i){
                this.blocks.get(i).rotateBlock();
            }
        }
        else {
            this.w = sw;
            this.h = sh;
            this.y = sy;
            this.x = sx;

            for(int i = 0; i < this.blocks.size(); ++i){
                this.blocks.get(i).setPxPy(this.x, this.y);
            }
        }
    }

    void moveLeft() {
        boolean ok = true;

        for(int i = 0; i < this.blocks.size(); ++i){
            ok = this.blocks.get(i).checkMoveLeft();

            if (!ok){
                break;
            }
        }

        if (ok){
            this.x -= BLK_SIZE;

            for(int i = 0; i < this.blocks.size(); ++i){
                this.blocks.get(i).setPxPy(this.x, this.y);
            }
        }
    }

    void moveRight() {
        boolean ok = true;

        for(int i = 0; i < this.blocks.size(); ++i){
            ok = this.blocks.get(i).checkMoveRight();

            if (!ok){
                break;
            }
        }

        if (ok){
            this.x += BLK_SIZE;

            for(int i = 0; i < this.blocks.size(); ++i){
                this.blocks.get(i).setPxPy(this.x, this.y);
            }
        }
    }

    void fallDown() {
        if (!this.isDocked()){
            boolean ok = true;

            for(int i = 0; i < this.blocks.size(); ++i){
                ok = this.blocks.get(i).checkFall();

                if (!ok){
                    break;
                }
            }

            if (ok){
                this.y += BLK_SIZE;

                for(int i = 0; i < this.blocks.size(); ++i){
                    this.blocks.get(i).setPxPy(this.x, this.y);
                }
            }
        }
    }

    boolean isDocked(){
        if (!this.docked){
            for(int i = 0; i < this.blocks.size(); ++i){
                this.blocks.get(i).setPxPy(this.x, this.y);
                this.docked = this.blocks.get(i).isDocked();

                if (this.docked){
                    break;
                }
            }
        }

        return this.docked;
    }

    void draw() {
        for(int i=0; i < this.blocks.size(); ++i){
            this.blocks.get(i).setPxPy(this.x, this.y);
            this.blocks.get(i).draw();
        }
    }
}