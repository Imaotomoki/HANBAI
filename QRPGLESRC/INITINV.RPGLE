     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITINV
      * 説明: 在庫データの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FINVENTORYPO    E             DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D W#CNTR          S              9S 0

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @WH1
     C                   EXSR      @WH2
     C                   EXSR      @WH3
     C                   EXSR      @WH4
     C                   EXSR      @END

      *=====================================================================
      * サブルーチン: @INZ - 初期処理
      *=====================================================================
     C     @INZ          BEGSR
     C                   TIME                    WTIMESTAMP
     C                   EVAL      W#CNTR = *ZERO
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WH1 - 東京倉庫の在庫投入
      *=====================================================================
     C     @WH1          BEGSR
      * ノートPC
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 1
     C                   EVAL      QTYOH = 100.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * デスクトップPC
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 2
     C                   EVAL      QTYOH = 50.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * モニター
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 3
     C                   EVAL      QTYOH = 200.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * キーボード
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 4
     C                   EVAL      QTYOH = 150.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * マウス
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 5
     C                   EVAL      QTYOH = 180.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * デスク
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 11
     C                   EVAL      QTYOH = 80.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * チェア
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 12
     C                   EVAL      QTYOH = 100.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * スーツ
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 21
     C                   EVAL      QTYOH = 50.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

      * ワイシャツ
     C                   EVAL      WHID = 1
     C                   EVAL      ITEMID = 22
     C                   EVAL      QTYOH = 200.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WH2 - 大阪倉庫の在庫投入
      *=====================================================================
     C     @WH2          BEGSR
     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 1
     C                   EVAL      QTYOH = 80.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 2
     C                   EVAL      QTYOH = 40.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 6
     C                   EVAL      QTYOH = 120.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 7
     C                   EVAL      QTYOH = 150.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 8
     C                   EVAL      QTYOH = 60.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 13
     C                   EVAL      QTYOH = 90.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 14
     C                   EVAL      QTYOH = 40.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 26
     C                   EVAL      QTYOH = 300.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 2
     C                   EVAL      ITEMID = 27
     C                   EVAL      QTYOH = 250.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WH3 - 名古屋倉庫の在庫投入
      *=====================================================================
     C     @WH3          BEGSR
     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 3
     C                   EVAL      QTYOH = 150.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 9
     C                   EVAL      QTYOH = 70.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 10
     C                   EVAL      QTYOH = 90.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 15
     C                   EVAL      QTYOH = 50.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 16
     C                   EVAL      QTYOH = 500.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 17
     C                   EVAL      QTYOH = 800.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 18
     C                   EVAL      QTYOH = 1000.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 31
     C                   EVAL      QTYOH = 200.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 3
     C                   EVAL      ITEMID = 32
     C                   EVAL      QTYOH = 300.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WH4 - 福岡倉庫の在庫投入
      *=====================================================================
     C     @WH4          BEGSR
     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 4
     C                   EVAL      QTYOH = 100.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 5
     C                   EVAL      QTYOH = 120.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 19
     C                   EVAL      QTYOH = 150.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 20
     C                   EVAL      QTYOH = 200.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 23
     C                   EVAL      QTYOH = 100.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 24
     C                   EVAL      QTYOH = 80.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 25
     C                   EVAL      QTYOH = 150.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 33
     C                   EVAL      QTYOH = 180.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 34
     C                   EVAL      QTYOH = 220.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR

     C                   EVAL      WHID = 4
     C                   EVAL      ITEMID = 35
     C                   EVAL      QTYOH = 250.000
     C                   EVAL      QTYALC = 0.000
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

