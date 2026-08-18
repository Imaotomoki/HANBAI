     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: CONFIRMSHP
      * 説明: 出荷確定プログラム（在庫引当の整合性保証）
      * ライブラリ: DEMOAPP
      * 変更履歴:
      *   修正#2 @UPDSOL - SORDERLP のCHAINキーを W#SOID 単体から
      *          複合キー SOLKEY(W#SOID+W#SOLINENO) に変更
      *   修正#5 @REDINV - 在庫チェック順序を修正
      *          QTYALC（引当済）の確認を QTYOH チェックより先に実施
      *   修正#6 @REDINV - W#WHID単体のCHAINをINVKEY(W#WHID+W#ITEMID)複合キーに変更
      *   修正#7 @UPDSOH - @VLDSOH実行後の冗長なCHAINを除去
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FSORDERHP  UF   E           K DISK
     FSORDERLP  UF   E           K DISK
     FSHIPMENTHPO    E             DISK
     FSHIPMENTLPO    E             DISK
     FINVENTORYPUF   E           K DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0
     D W#SHPID         S             18P 0
     D W#SOID          S             18P 0
     D W#WHID          S              4P 0
     D W#LINENO        S              9P 0
     D W#FOUND         S               N
     D W#ERROR         S               N
     D W#ERRMSG        S             52A
     D W#EOF           S               N
      * 出荷明細用変数
     D W#ITEMID        S              9P 0
     D W#SHPQTY        S             15P 3
     D W#UNITPRC       S             15P 4
     D W#LINEAMT       S             15P 2
     D W#SOLINENO      S              9P 0

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @VLDSOH
     C                   IF        W#ERROR
     C                   EXSR      @END
     C                   ENDIF
     C                   EXSR      @GENSHPID
     C                   EXSR      @PRCSOL
     C                   IF        W#ERROR
     C                   EXSR      @END
     C                   ENDIF
     C                   EXSR      @WRTSHPH
     C                   EXSR      @UPDSOH
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
     C                   EVAL      W#LINENO = *ZERO
      * テストデータ設定
     C                   EVAL      W#SOID = 1
     C                   EVAL      W#WHID = 1
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @VLDSOH - 受注ヘッダチェック
      *=====================================================================
     C     @VLDSOH       BEGSR
     C     W#SOID        CHAIN     SORDERHP
     C                   EVAL      W#FOUND = %FOUND(SORDERHP)
     C                   IF        NOT W#FOUND
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Sales order not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * ステータスチェック
     C                   IF        STATUS <> 'ALLOCATED' AND
     C                             STATUS <> 'OPEN'
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Invalid order status'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @GENSHPID - 出荷ID採番
      *=====================================================================
     C     @GENSHPID     BEGSR
      * タイムスタンプベースの採番（重複回避）
     C                   EVAL      W#SHPID = (WDATE8 * 1000000) + WTIME6
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCSOL - 受注明細処理
      *=====================================================================
     C     @PRCSOL       BEGSR
     C     W#SOID        SETLL     SORDERLP
     C                   EVAL      W#EOF = *OFF
     C                   DOW       NOT W#EOF
     C     W#SOID        READE     SORDERLP                             99
     C                   EVAL      W#EOF = *IN99
     C                   IF        W#EOF
     C                   LEAVE
     C                   ENDIF
      * 明細データ取得
     C                   EVAL      W#SOLINENO = LINENO
     C                   EVAL      W#ITEMID = ITEMID
     C                   EVAL      W#SHPQTY = ORDQTY - SHPQTY
     C                   EVAL      W#UNITPRC = UNITPRC
     C                   EVAL      W#LINEAMT = W#SHPQTY * W#UNITPRC
      * 在庫減算
     C                   EXSR      @REDINV
     C                   IF        W#ERROR
     C                   LEAVE
     C                   ENDIF
      * 受注明細更新
     C                   EXSR      @UPDSOL
     C                   IF        W#ERROR
     C                   LEAVE
     C                   ENDIF
      * 出荷明細書き込み
     C                   EXSR      @WRTSHPL
     C                   ENDDO
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @REDINV - 在庫減算
      * [修正#5] 在庫チェック順序を修正:
      *   変更前: QTYOH < W#SHPQTY → QTYALC < W#SHPQTY の順
      *   変更後: QTYALC < W#SHPQTY（引当済確認）を先に行い、
      *           続けて QTYOH < W#SHPQTY（実在庫確認）を行う
      *   理由: 出荷は引当済みの範囲内で行うのが正しい業務フロー
      * [修正#6] W#WHID単体CHAINをINVKEY(W#WHID+W#ITEMID)複合キーに変更
      *=====================================================================
     C     INVKEY        KLIST
     C                   KFLD                    W#WHID
     C                   KFLD                    W#ITEMID

     C     @REDINV       BEGSR
     C     INVKEY        CHAIN     INVENTORYP                         99
     C                   IF        *IN99
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Inventory not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * [修正#5] 引当済数量チェックを先に実施（業務ルール: 引当の範囲内で出荷）
     C                   IF        QTYALC < W#SHPQTY
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Insufficient allocated qty'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 実在庫数量チェック（念のため二重確認）
     C                   IF        QTYOH < W#SHPQTY
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Insufficient inventory'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 在庫数量減算
     C                   EVAL      QTYOH = QTYOH - W#SHPQTY
     C                   EVAL      QTYALC = QTYALC - W#SHPQTY
     C                   EVAL      QTYAVL = QTYOH - QTYALC
     C                   EVAL      LSTUPD = WTIMESTAMP
     C                   UPDATE    INVREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @UPDSOL - 受注明細更新
      * [修正#2] CHAINキーを複合キー SOLKEY(W#SOID+W#SOLINENO) に変更
      *   変更前: W#SOID CHAIN SORDERLP  ← SOID のみでは1つ目の行を誤更新
      *   変更後: SOLKEY(SOID+LINENO) でCHAINし正確なレコードを更新
      *=====================================================================
     C     SOLKEY        KLIST
     C                   KFLD                    W#SOID
     C                   KFLD                    W#SOLINENO

     C     @UPDSOL       BEGSR
     C     SOLKEY        CHAIN     SORDERLP                           99
     C                   IF        *IN99
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Order line not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 出荷済数量更新
     C                   EVAL      SHPQTY = SHPQTY + W#SHPQTY
      * ステータス更新
     C                   IF        SHPQTY >= ORDQTY
     C                   EVAL      STATUS = 'COMPLETED'
     C                   ELSE
     C                   EVAL      STATUS = 'PARTIAL'
     C                   ENDIF
     C                   UPDATE    SOLREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WRTSHPH - 出荷ヘッダ書き込み
      *=====================================================================
     C     @WRTSHPH      BEGSR
     C                   EVAL      SHPID = W#SHPID
     C                   EVAL      SHPNUM = 'SHP-2025-0001'
     C                   EVAL      SOID = W#SOID
     C                   EVAL      SHPDATE = WDATE8
     C                   EVAL      WHID = W#WHID
     C                   EVAL      CARRIER = 'ヤマト運輸'
     C                   EVAL      TRACKNO = '1234-5678-9012'
     C                   EVAL      STATUS = 'SHIPPED'
     C                   EVAL      CRTUSER = 'SYSTEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'SYSTEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     SHPREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WRTSHPL - 出荷明細書き込み
      *=====================================================================
     C     @WRTSHPL      BEGSR
     C                   ADD       1             W#LINENO
     C                   EVAL      SHPID = W#SHPID
     C                   EVAL      LINENO = W#LINENO
     C                   EVAL      SOLNO = W#SOLINENO
     C                   EVAL      ITEMID = W#ITEMID
     C                   EVAL      SHPQTY = W#SHPQTY
     C                   EVAL      LOTNO = ''
     C                   WRITE     SHPLREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @UPDSOH - 受注ヘッダ更新
      * [修正#7] @VLDSOH実行後の冗長なCHAINを除去
      *   @VLDSOH で既に W#SOID CHAIN SORDERHP 済みのため再CHAINは不要
      *=====================================================================
     C     @UPDSOH       BEGSR
     C                   EVAL      STATUS = 'SHIPPED'
     C                   EVAL      UPDUSER = 'SYSTEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   UPDATE    SOHREC
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   IF        NOT W#ERROR
     C                   EVAL      W#ERRMSG = 'Shipment confirmed successfully'
     C                   DSPLY                   W#ERRMSG
     C                   DSPLY                   W#CNTR
     C                   ELSE
     C                   EVAL      W#ERRMSG = 'Shipment confirmation failed'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

