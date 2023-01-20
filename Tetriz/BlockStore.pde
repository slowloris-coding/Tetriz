class BlockStore {
    TBlock[][] matrix = new TBlock[BRD_ROWS][BRD_COLS];

    BlockStore(){
        for(int ri=0; ri < BRD_ROWS; ++ri){
            for(int ci=0; ci < BRD_COLS; ++ci){
                this.matrix[ri][ci] = null;
            }
        }
    }

    TBlock getBlock(int _r, int _c){
        return this.matrix[_r][_c];
    }

    void storeBlock(TBlock _blk){
        if(this.matrix[_blk.row][_blk.col] == null){
            this.matrix[_blk.row][_blk.col] = _blk;
        }
    }

    void storeShape(ArrayList<TBlock> _blks){
        for(int i=0; i < _blks.size(); ++i){
            this.storeBlock(_blks.get(i));
        }
    }

    void removeRow(int _ri){
        for(int ci = 0; ci < BRD_COLS; ++ci){
            this.matrix[_ri][ci] = null;
        }

        for(int ri = _ri; ri > 0; ri -= 1){
            for (int ci = 0; ci < BRD_COLS; ++ci){
                this.matrix[ri][ci] = this.matrix[ri - 1][ci];

                if(this.matrix[ri][ci] != null){
                    this.matrix[ri][ci].y += BLK_SIZE;
                    this.matrix[ri][ci].row += 1;
                }
            }
        }

        for(int ci = 0; ci < BRD_COLS; ++ci){
            this.matrix[0][ci] = null;
        }
    }

    boolean rowIsFull(int _ri){
        boolean full = false;

        for(int ci = 0; ci < BRD_COLS; ++ci){
            full = (this.matrix[_ri][ci] != null);

            if (!full){
                break;
            }
        }

        return full;
    }

    boolean isFree(int _ri, int _ci){
        if (_ri >= 0 && _ri < BRD_ROWS && _ci >= 0 && _ci < BRD_COLS){
            if (this.matrix[_ri][_ci] == null) {
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    }

    boolean isDocked(int _ri, int _ci) {
        if (_ri >= (BRD_ROWS - 1)) {
            return true;
        }
        else if (this.matrix[_ri + 1][_ci] != null) {
            return true;
        }
        else {
            return false;
        }
    }

    void draw() {
        for(int ri=0; ri < BRD_ROWS; ++ri){
            for(int ci=0; ci < BRD_COLS; ++ci){
                if (this.matrix[ri][ci] != null){
                    this.matrix[ri][ci].draw();
                }
            }
        }
    }
}