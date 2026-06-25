     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: CREATESORD
      * 説明: 受注登録プログラム（ヘッダ+明細の一括登録）
      * ライブラリ: DEMOAPP
      * 変更履歴:
      *   修正#3 @ALCINV - INVENTORYP のCHAINキーを W#WHID 単体から
      *          複合キー INVKEY(W#WHID+W#ITEMID) に変更
      *          理由: INVENTORYPの主キーはWHID+ITEMIDの複合キーのため
      *               W#WHID単体では同一倉庫の先頭商品が誤って引当てされる
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FSORDERHP  O    E             DISK
     FSORDERLP  O    E             DISK
     FINVENTORYPUF   E           K DISK
     FITEMP     IF   E           K DISK    PREFIX(ITM_)
     FCUSTOMERP IF   E           K DISK    PREFIX(CUST_)

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0
     D W#SOID          S             18P 0
     D W#LINENO        S              9P 0
     D W#TOTAMT        S             15P 2
     D W#LINEAMT       S             15P 2
     D W#FOUND         S               N
     D W#ERROR         S               N
     D W#ERRMSG        S             52A
      * テストデータ用変数
     D W#CUSTID        S              9P 0
     D W#WHID          S              4P 0
     D W#ITEMID        S              9P 0
     D W#ORDQTY        S             15P 3
     D W#UNITPRC       S             15P 4
     D W#TAXRATE       S              5P 3

      *---------------------------------------------------------------
      * キーリスト: 在庫複合キー（WHID + ITEMID）
      * [修正#3] @ALCINV で使用する複合キーを定義
      *---------------------------------------------------------------
     C     INVKEY        KLIST
     C                   KFLD                    W#WHID
     C                   KFLD                    W#ITEMID

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @VLDCUST
     C                   IF        W#ERROR
     C                   EXSR      @END
     C                   ENDIF
     C                   EXSR      @GENSOID
     C                   EXSR      @PRCHDR
     C                   EXSR      @PRCLN1
     C                   EXSR      @PRCLN2
     C                   EXSR      @PRCLN3
     C                   EXSR      @END

      *=====================================================================
      * サブルーチン: @INZ - 初期処理
      *=====================================================================
     C     @INZ          BEGSR
     C                   TIME                    WTIMESTAMP
     C                   EVAL      WDATE8 = %DEC(%DATE(WTIMESTAMP):*ISO)
     C                   EVAL      WTIME6 = %DEC(%TIME(WTIMESTAMP):*HMS)
     C                   EVAL      W#CNTR = *ZERO
     C                   EVAL      W#ERROR = *OFF
     C                   EVAL      W#TOTAMT = *ZERO
      * テストデータ設定
     C                   EVAL      W#CUSTID = 1
     C                   EVAL      W#WHID = 1
     C                   EVAL      W#TAXRATE = 0.100
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @VLDCUST - 顧客存在チェック
      *=====================================================================
     C     @VLDCUST      BEGSR
     C     W#CUSTID      CHAIN     CUSTOMERP
     C                   EVAL      W#FOUND = %FOUND(CUSTOMERP)
     C                   IF        NOT W#FOUND
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Customer not found'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @GENSOID - 受注ID採番
      *=====================================================================
     C     @GENSOID      BEGSR
      * タイムスタンプベースの採番（重複回避）
     C                   EVAL      W#SOID = (WDATE8 * 1000000) + WTIME6
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCHDR - ヘッダ処理
      *=====================================================================
     C     @PRCHDR       BEGSR
     C                   EVAL      SOID = W#SOID
     C                   EVAL      SONUM = 'SO-2025-0001'
     C                   EVAL      CUSTID = W#CUSTID
     C                   EVAL      ORDDATE = WDATE8
     C                   EVAL      REQDATE = WDATE8 + 10
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      PAYTERM = 'NET30'
     C                   EVAL      WHID = W#WHID
     C                   EVAL      STATUS = 'ALLOCATED'
     C                   EVAL      TOTAMT = *ZERO
     C                   EVAL      CRTUSER = 'SYSTEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'SYSTEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     SOHREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCLN1 - 明細1処理
      *=====================================================================
     C     @PRCLN1       BEGSR
     C                   EVAL      W#ITEMID = 1
     C                   EVAL      W#ORDQTY = 10.000
     C                   EVAL      W#UNITPRC = 1500.0000
     C                   EXSR      @VLDITEM
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @ALCINV
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @WRTLINE
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCLN2 - 明細2処理
      *=====================================================================
     C     @PRCLN2       BEGSR
     C                   EVAL      W#ITEMID = 2
     C                   EVAL      W#ORDQTY = 5.000
     C                   EVAL      W#UNITPRC = 2800.0000
     C                   EXSR      @VLDITEM
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @ALCINV
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @WRTLINE
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCLN3 - 明細3処理
      *=====================================================================
     C     @PRCLN3       BEGSR
     C                   EVAL      W#ITEMID = 3
     C                   EVAL      W#ORDQTY = 20.000
     C                   EVAL      W#UNITPRC = 850.0000
     C                   EXSR      @VLDITEM
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @ALCINV
     C                   IF        W#ERROR
     C                   RETURN
     C                   ENDIF
     C                   EXSR      @WRTLINE
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @VLDITEM - 商品存在チェック
      *=====================================================================
     C     @VLDITEM      BEGSR
     C     W#ITEMID      CHAIN     ITEMP
     C                   EVAL      W#FOUND = %FOUND(ITEMP)
     C                   IF        NOT W#FOUND
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Item not found'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @ALCINV - 在庫引当処理
      * [修正#3] W#WHID 単体のCHAINから INVKEY(W#WHID+W#ITEMID) に変更
      *   変更前: C     W#WHID  CHAIN  INVENTORYP  99
      *           → 同一倉庫の先頭レコード（異なる商品）を誤って引当てる危険
      *   変更後: C     INVKEY  CHAIN  INVENTORYP  99
      *           → 倉庫IDと商品IDの両方で特定し正しいレコードを引当てる
      *=====================================================================
     C     @ALCINV       BEGSR
     C     INVKEY        CHAIN     INVENTORYP                         99
     C                   IF        *IN99
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Inventory not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 引当可能数量チェック
     C                   IF        QTYAVL < W#ORDQTY
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Insufficient inventory'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 引当数量更新
     C                   EVAL      QTYALC = QTYALC + W#ORDQTY
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   UPDATE    INVREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WRTLINE - 明細書き込み
      *=====================================================================
     C     @WRTLINE      BEGSR
     C                   ADD       1             W#LINENO
     C                   EVAL      SOID = W#SOID
     C                   EVAL      LINENO = W#LINENO
     C                   EVAL      ITEMID = W#ITEMID
     C                   EVAL      ORDQTY = W#ORDQTY
     C                   EVAL      UNITPRC = W#UNITPRC
     C                   EVAL      TAXRATE = W#TAXRATE
      * 明細金額計算
     C                   EVAL      W#LINEAMT = W#ORDQTY * W#UNITPRC *
     C                               (1 + W#TAXRATE)
     C                   EVAL      LINEAMT = W#LINEAMT
     C                   EVAL      ALCQTY = W#ORDQTY
     C                   EVAL      SHPQTY = *ZERO
     C                   EVAL      STATUS = 'ALLOCATED'
     C                   WRITE     SOLREC
     C                   ADD       1             W#CNTR
      * 合計金額に加算
     C                   ADD       W#LINEAMT     W#TOTAMT
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   IF        NOT W#ERROR
     C                   EVAL      W#ERRMSG = 'Order created successfully'
     C                   DSPLY                   W#ERRMSG
     C                   DSPLY                   W#CNTR
     C                   ELSE
     C                   EVAL      W#ERRMSG = 'Order creation failed'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

