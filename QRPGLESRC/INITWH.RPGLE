     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITWH
      * 説明: 倉庫マスタの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FWAREHOUSEPO    E             DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0
     D W#NXID          S              4S 0

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @WH
     C                   EXSR      @END

      *=====================================================================
      * サブルーチン: @INZ - 初期処理
      *=====================================================================
     C     @INZ          BEGSR
     C                   TIME                    WTIMESTAMP
     C                   EVAL      WDATE8 = %DEC(%DATE(WTIMESTAMP):*ISO)
     C                   EVAL      WTIME6 = %DEC(%TIME(WTIMESTAMP):*HMS)
     C                   EVAL      W#CNTR = *ZERO
     C                   EVAL      W#NXID = 1
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WH - 倉庫データ投入
      *=====================================================================
     C     @WH           BEGSR
      * 東京物流センター
     C                   EVAL      WHID = W#NXID
     C                   EVAL      WHCD = 'WH-TOKYO'
     C                   EVAL      WHNM = '東京物流センター'
     C                   EVAL      WHADR = '東京都江東区豊洲3-1-1'
     C                   EVAL      MGRNM = '山田太郎'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITWH'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITWH'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     WHREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      * 大阪物流センター
     C                   EVAL      WHID = W#NXID
     C                   EVAL      WHCD = 'WH-OSAKA'
     C                   EVAL      WHNM = '大阪物流センター'
     C                   EVAL      WHADR = '大阪府大阪市住之江区南港北1-1-1'
     C                   EVAL      MGRNM = '田中花子'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITWH'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITWH'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     WHREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      * 名古屋物流センター
     C                   EVAL      WHID = W#NXID
     C                   EVAL      WHCD = 'WH-NAGOYA'
     C                   EVAL      WHNM = '名古屋物流センター'
     C                   EVAL      WHADR = '愛知県名古屋市港区金城ふ頭2-1'
     C                   EVAL      MGRNM = '佐藤次郎'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITWH'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITWH'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     WHREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      * 福岡物流センター
     C                   EVAL      WHID = W#NXID
     C                   EVAL      WHCD = 'WH-FUKUOKA'
     C                   EVAL      WHNM = '福岡物流センター'
     C                   EVAL      WHADR = '福岡県福岡市東区箱崎ふ頭1-1-1'
     C                   EVAL      MGRNM = '鈴木一郎'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITWH'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITWH'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     WHREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      * 札幌物流センター（無効）
     C                   EVAL      WHID = W#NXID
     C                   EVAL      WHCD = 'WH-SAPPORO'
     C                   EVAL      WHNM = '札幌物流センター'
     C                   EVAL      WHADR = '北海道札幌市中央区北1条西1-1-1'
     C                   EVAL      MGRNM = '高橋三郎'
     C                   EVAL      STATUS = 'INACTIVE'
     C                   EVAL      CRTUSER = 'INITWH'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITWH'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     WHREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

