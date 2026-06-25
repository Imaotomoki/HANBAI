     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITFX
      * 説明: 為替レートの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FFXRATEP   O    E             DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @JPY
     C                   EXSR      @USD
     C                   EXSR      @EUR
     C                   EXSR      @CNY
     C                   EXSR      @KRW
     C                   EXSR      @SAME
     C                   EXSR      @END

      *=====================================================================
      * サブルーチン: @INZ - 初期処理
      *=====================================================================
     C     @INZ          BEGSR
     C                   TIME                    WTIMESTAMP
     C                   EVAL      WDATE8 = %DEC(%DATE(WTIMESTAMP):*ISO)
     C                   EVAL      WTIME6 = %DEC(%TIME(WTIMESTAMP):*HMS)
     C                   EVAL      W#CNTR = *ZERO
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @JPY - JPY基準の為替レート投入
      *=====================================================================
     C     @JPY          BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'JPY'
     C                   EVAL      TOCUR = 'USD'
     C                   EVAL      RATE = 0.006800
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'JPY'
     C                   EVAL      TOCUR = 'EUR'
     C                   EVAL      RATE = 0.006200
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'JPY'
     C                   EVAL      TOCUR = 'CNY'
     C                   EVAL      RATE = 0.049000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'JPY'
     C                   EVAL      TOCUR = 'KRW'
     C                   EVAL      RATE = 9.500000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @USD - USD基準の為替レート投入
      *=====================================================================
     C     @USD          BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'USD'
     C                   EVAL      TOCUR = 'JPY'
     C                   EVAL      RATE = 147.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'USD'
     C                   EVAL      TOCUR = 'EUR'
     C                   EVAL      RATE = 0.910000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'USD'
     C                   EVAL      TOCUR = 'CNY'
     C                   EVAL      RATE = 7.200000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'USD'
     C                   EVAL      TOCUR = 'KRW'
     C                   EVAL      RATE = 1397.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @EUR - EUR基準の為替レート投入
      *=====================================================================
     C     @EUR          BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'EUR'
     C                   EVAL      TOCUR = 'JPY'
     C                   EVAL      RATE = 161.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'EUR'
     C                   EVAL      TOCUR = 'USD'
     C                   EVAL      RATE = 1.100000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'EUR'
     C                   EVAL      TOCUR = 'CNY'
     C                   EVAL      RATE = 7.900000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'EUR'
     C                   EVAL      TOCUR = 'KRW'
     C                   EVAL      RATE = 1535.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @CNY - CNY基準の為替レート投入
      *=====================================================================
     C     @CNY          BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'CNY'
     C                   EVAL      TOCUR = 'JPY'
     C                   EVAL      RATE = 20.400000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'CNY'
     C                   EVAL      TOCUR = 'USD'
     C                   EVAL      RATE = 0.139000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'CNY'
     C                   EVAL      TOCUR = 'EUR'
     C                   EVAL      RATE = 0.127000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'CNY'
     C                   EVAL      TOCUR = 'KRW'
     C                   EVAL      RATE = 194.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @KRW - KRW基準の為替レート投入
      *=====================================================================
     C     @KRW          BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'KRW'
     C                   EVAL      TOCUR = 'JPY'
     C                   EVAL      RATE = 0.105000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'KRW'
     C                   EVAL      TOCUR = 'USD'
     C                   EVAL      RATE = 0.000716
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'KRW'
     C                   EVAL      TOCUR = 'EUR'
     C                   EVAL      RATE = 0.000651
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'KRW'
     C                   EVAL      TOCUR = 'CNY'
     C                   EVAL      RATE = 0.005150
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @SAME - 同一通貨のレート投入（1.0）
      *=====================================================================
     C     @SAME         BEGSR
     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'JPY'
     C                   EVAL      TOCUR = 'JPY'
     C                   EVAL      RATE = 1.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'USD'
     C                   EVAL      TOCUR = 'USD'
     C                   EVAL      RATE = 1.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'EUR'
     C                   EVAL      TOCUR = 'EUR'
     C                   EVAL      RATE = 1.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'CNY'
     C                   EVAL      TOCUR = 'CNY'
     C                   EVAL      RATE = 1.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR

     C                   EVAL      RATEDATE = WDATE8
     C                   EVAL      FROMCUR = 'KRW'
     C                   EVAL      TOCUR = 'KRW'
     C                   EVAL      RATE = 1.000000
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   WRITE     FXREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

