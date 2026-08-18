     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INVTRIGGER
      * 説明: 在庫更新トリガープログラム
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FCHANGELOGPO    E             DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D W#CNTR          S              9S 0
     D W#LOGID         S             18P 0
     D W#WHID          S              4P 0
     D W#ITEMID        S              9P 0
     D W#QTYOH_OLD     S             15P 3
     D W#QTYOH_NEW     S             15P 3
     D W#QTYALC_OLD    S             15P 3
     D W#QTYALC_NEW    S             15P 3
     D W#QTYAVL_OLD    S             15P 3
     D W#QTYAVL_NEW    S             15P 3
     D W#EXPECTED      S             15P 3
     D W#RECKEY        S             30A
     D W#ALERT         S             52A
     D W#OLDVAL        S           1024A
     D W#NEWVAL        S           1024A

      *=====================================================================
      * メイン処理
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @CHKQOH
     C                   EXSR      @CHKALC
     C                   EXSR      @CHKAVL
     C                   EXSR      @CHKCONS
     C                   EXSR      @END

      *=====================================================================
      * サブルーチン: @INZ - 初期処理
      *=====================================================================
     C     @INZ          BEGSR
     C                   TIME                    WTIMESTAMP
     C                   EVAL      W#CNTR = *ZERO
      * タイムスタンプベースのログID生成
     C                   EVAL      W#LOGID = (%DEC(%DATE(WTIMESTAMP):*ISO)
     C                               * 1000000) +
     C                               %DEC(%TIME(WTIMESTAMP):*HMS)
      * テストデータ設定（実際はトリガーバッファから取得）
     C                   EVAL      W#WHID = 1
     C                   EVAL      W#ITEMID = 1
     C                   EVAL      W#QTYOH_OLD = 100.000
     C                   EVAL      W#QTYOH_NEW = 90.000
     C                   EVAL      W#QTYALC_OLD = 10.000
     C                   EVAL      W#QTYALC_NEW = 20.000
     C                   EVAL      W#QTYAVL_OLD = 90.000
     C                   EVAL      W#QTYAVL_NEW = 70.000
      * レコードキー生成
     C                   EVAL      W#RECKEY = 'WH=' + %CHAR(W#WHID) +
     C                               ',IT=' + %CHAR(W#ITEMID)
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @CHKQOH - 現在庫数チェック
      *=====================================================================
     C     @CHKQOH       BEGSR
     C                   IF        W#QTYOH_OLD <> W#QTYOH_NEW
     C                   EVAL      W#OLDVAL = 'QTYOH=' + %CHAR(W#QTYOH_OLD)
     C                   EVAL      W#NEWVAL = 'QTYOH=' + %CHAR(W#QTYOH_NEW)
     C                   EXSR      @LOGCHG
      * マイナス在庫チェック
     C                   IF        W#QTYOH_NEW < 0
     C                   EVAL      W#ALERT = 'Negative inventory'
     C                   DSPLY                   W#ALERT
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @CHKALC - 引当済数量チェック
      *=====================================================================
     C     @CHKALC       BEGSR
     C                   IF        W#QTYALC_OLD <> W#QTYALC_NEW
     C                   EVAL      W#OLDVAL = 'QTYALC=' + %CHAR(W#QTYALC_OLD)
     C                   EVAL      W#NEWVAL = 'QTYALC=' + %CHAR(W#QTYALC_NEW)
     C                   EXSR      @LOGCHG
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @CHKAVL - 引当可能数量チェック
      *=====================================================================
     C     @CHKAVL       BEGSR
     C                   IF        W#QTYAVL_OLD <> W#QTYAVL_NEW
     C                   EVAL      W#OLDVAL = 'QTYAVL=' + %CHAR(W#QTYAVL_OLD)
     C                   EVAL      W#NEWVAL = 'QTYAVL=' + %CHAR(W#QTYAVL_NEW)
     C                   EXSR      @LOGCHG
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @CHKCONS - 整合性チェック
      *=====================================================================
     C     @CHKCONS      BEGSR
      * 引当可能数量 = 現在庫数 - 引当済数量
     C                   EVAL      W#EXPECTED = W#QTYOH_NEW - W#QTYALC_NEW
     C                   IF        W#QTYAVL_NEW <> W#EXPECTED
     C                   EVAL      W#ALERT = 'Inventory inconsistency'
     C                   DSPLY                   W#ALERT
     C                   EVAL      W#OLDVAL = 'Expected=' + %CHAR(W#EXPECTED)
     C                   EVAL      W#NEWVAL = 'Actual=' + %CHAR(W#QTYAVL_NEW)
     C                   EXSR      @LOGERR
     C                   ENDIF
      * 引当済数量が現在庫数を超えていないかチェック
     C                   IF        W#QTYALC_NEW > W#QTYOH_NEW
     C                   EVAL      W#ALERT = 'Allocated exceeds on-hand'
     C                   DSPLY                   W#ALERT
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @LOGCHG - 変更履歴記録
      *=====================================================================
     C     @LOGCHG       BEGSR
      * 一意なログIDを生成（タイムスタンプ + カウンタ）
     C                   ADD       1             W#CNTR
     C                   ADD       W#CNTR        W#LOGID
     C                   EVAL      LOGID = W#LOGID
     C                   EVAL      TBLNAME = 'INVENTORYP'
     C                   EVAL      RECID = W#RECKEY
     C                   EVAL      ACTION = 'UPDATE'
     C                   EVAL      CHGBY = 'TRIGGER'
     C                   EVAL      CHGAT = WTIMESTAMP
     C                   EVAL      OLDVAL = W#OLDVAL
     C                   EVAL      NEWVAL = W#NEWVAL
     C                   WRITE     LOGREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @LOGERR - エラー記録
      *=====================================================================
     C     @LOGERR       BEGSR
      * 一意なログIDを生成（タイムスタンプ + カウンタ）
     C                   ADD       1             W#CNTR
     C                   ADD       W#CNTR        W#LOGID
     C                   EVAL      LOGID = W#LOGID
     C                   EVAL      TBLNAME = 'INVENTORYP'
     C                   EVAL      RECID = W#RECKEY
     C                   EVAL      ACTION = 'ERROR'
     C                   EVAL      CHGBY = 'TRIGGER'
     C                   EVAL      CHGAT = WTIMESTAMP
     C                   EVAL      OLDVAL = W#OLDVAL
     C                   EVAL      NEWVAL = W#NEWVAL
     C                   WRITE     LOGREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   EVAL      W#ALERT = 'Trigger executed'
     C                   DSPLY                   W#ALERT
     C                   DSPLY                   W#CNTR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

