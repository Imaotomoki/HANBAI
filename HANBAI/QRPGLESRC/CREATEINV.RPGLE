     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: CREATEINV
      * 説明: 請求発行プログラム（締め条件対応）
      * ライブラリ: DEMOAPP
      * 変更履歴:
      *   修正#4 @PRCSHP - 単価のハードコード(1000.0000)を廃止し
      *          受注明細(SORDERLP)から実際の単価・税率を取得するよう変更
      *          ファイル定義に SORDERLP を読み込みファイルとして追加
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FSORDERHP  UF   E           K DISK
      * [修正#4] SORDERLP: 受注明細から単価・税率を取得するために追加
     FSORDERLP  IF   E           K DISK
     FSHIPMENTHPIF   E           K DISK
     FSHIPMENTLPIF   E           K DISK
     FINVOICEHP O    E             DISK
     FINVOICELP O    E             DISK
     FCUSTOMERP IF   E           K DISK    PREFIX(C_)

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0
     D W#INVID         S             18P 0
     D W#SHPID         S             18P 0
     D W#SOID          S             18P 0
     D W#CUSTID        S              9P 0
     D W#LINENO        S              9P 0
     D W#FOUND         S               N
     D W#ERROR         S               N
     D W#ERRMSG        S             52A
     D W#EOF           S               N
      * 請求金額計算用
     D W#SUBTOTAL      S             15P 2
     D W#TAXAMT        S             15P 2
     D W#TOTAMT        S             15P 2
     D W#LINEAMT       S             15P 2
      * 明細用変数
     D W#ITEMID        S              9P 0
     D W#QTY           S             15P 3
     D W#UNITPRC       S             15P 4
     D W#TAXRATE       S              5P 3
     D W#SOLINENO      S              9P 0

      *---------------------------------------------------------------
      * キーリスト: 受注明細複合キー（SOID + LINENO）
      * [修正#4] 受注明細から単価を取得するためのキー定義
      *---------------------------------------------------------------
     C     SOLKEY        KLIST
     C                   KFLD                    W#SOID
     C                   KFLD                    W#SOLINENO

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @VLDCUST
     C                   IF        W#ERROR
     C                   EXSR      @END
     C                   ENDIF
     C                   EXSR      @GENINVID
     C                   EXSR      @PRCSHP
     C                   IF        W#ERROR
     C                   EXSR      @END
     C                   ENDIF
     C                   EXSR      @WRTINVH
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
     C                   EVAL      W#SUBTOTAL = *ZERO
     C                   EVAL      W#TAXAMT = *ZERO
     C                   EVAL      W#TOTAMT = *ZERO
     C                   EVAL      W#TAXRATE = 0.100
      * テストデータ設定
      * 実際の出荷IDを指定（CONFIRMSHPで作成されたID）
     C                   EVAL      W#SHPID = 20251222202615
     C                   EVAL      W#CUSTID = 1
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @VLDCUST - 顧客チェック
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
      * サブルーチン: @GENINVID - 請求ID採番
      *=====================================================================
     C     @GENINVID     BEGSR
      * タイムスタンプベースの採番（重複回避）
     C                   EVAL      W#INVID = (WDATE8 * 1000000) + WTIME6
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PRCSHP - 出荷データ処理
      * [修正#4] W#UNITPRC のハードコード(1000.0000)を廃止
      *   変更前: EVAL W#UNITPRC = 1000.0000  <- 固定値で請求金額誤り
      *   変更後: SOLKEY(W#SOID+W#SOLINENO) で SORDERLP をCHAINして
      *           UNITPRC（受注時の単価）と TAXRATE（税率）を取得する
      *=====================================================================
     C     @PRCSHP       BEGSR
      * 出荷ヘッダ読み込み
     C     W#SHPID       CHAIN     SHIPMENTHP
     C                   EVAL      W#FOUND = %FOUND(SHIPMENTHP)
     C                   IF        NOT W#FOUND
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Shipment not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
     C                   EVAL      W#SOID = SOID
      * 出荷明細処理
     C     W#SHPID       SETLL     SHIPMENTLP
     C                   EVAL      W#EOF = *OFF
     C                   DOW       NOT W#EOF
     C     W#SHPID       READE     SHIPMENTLP                             99
     C                   EVAL      W#EOF = *IN99
     C                   IF        W#EOF
     C                   LEAVE
     C                   ENDIF
      * 出荷明細データ取得
     C                   EVAL      W#SOLINENO = SOLNO
     C                   EVAL      W#ITEMID = ITEMID
     C                   EVAL      W#QTY = SHPQTY
      * [修正#4] 受注明細（SORDERLP）から実際の単価・税率を取得
     C     SOLKEY        CHAIN     SORDERLP                           99
     C                   IF        NOT *IN99
      * 受注明細から単価と税率を取得
     C                   EVAL      W#UNITPRC = UNITPRC
     C                   EVAL      W#TAXRATE = TAXRATE
     C                   ELSE
      * 受注明細が見つからない場合はエラーとして処理
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      W#ERRMSG = 'Order line not found'
     C                   DSPLY                   W#ERRMSG
     C                   RETURN
     C                   ENDIF
      * 金額計算（税別単価 × 出荷数量）
     C                   EVAL      W#LINEAMT = W#QTY * W#UNITPRC
      * 請求明細書き込み
     C                   EXSR      @WRTINVL
      * 金額集計
     C                   ADD       W#LINEAMT     W#SUBTOTAL
     C                   EVAL      W#TAXAMT = W#TAXAMT +
     C                               W#LINEAMT * W#TAXRATE
     C                   ENDDO
     C                   EVAL      W#TOTAMT = W#SUBTOTAL + W#TAXAMT
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WRTINVH - 請求ヘッダ書き込み
      *=====================================================================
     C     @WRTINVH      BEGSR
     C                   EVAL      INVID = W#INVID
     C                   EVAL      INVNUM = 'INV-2025-0001'
     C                   EVAL      CUSTID = W#CUSTID
     C                   EVAL      SOID = W#SOID
     C                   EVAL      INVDATE = WDATE8
     C                   EVAL      DUEDATE = %DEC(%DATE(WDATE8:*ISO)
     C                               + %DAYS(30):*ISO)
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      SUBTOT = W#SUBTOTAL
     C                   EVAL      TAXAMT = W#TAXAMT
     C                   EVAL      TOTAMT = W#TOTAMT
     C                   EVAL      PAIDAMT = *ZERO
     C                   EVAL      BALANCE = W#TOTAMT
     C                   EVAL      STATUS = 'OPEN'
     C                   EVAL      CRTUSER = 'SYSTEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'SYSTEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     INVREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @WRTINVL - 請求明細書き込み
      *=====================================================================
     C     @WRTINVL      BEGSR
     C                   ADD       1             W#LINENO
     C                   EVAL      INVID = W#INVID
     C                   EVAL      LINENO = W#LINENO
     C                   EVAL      SOID = W#SOID
     C                   EVAL      SHPID = W#SHPID
     C                   EVAL      ITEMID = W#ITEMID
     C                   EVAL      QTY = W#QTY
     C                   EVAL      UNITPRC = W#UNITPRC
     C                   EVAL      TAXRATE = W#TAXRATE
     C                   EVAL      LINEAMT = W#LINEAMT
     C                   WRITE     INVLREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @UPDSOH - 受注ヘッダ更新
      *=====================================================================
     C     @UPDSOH       BEGSR
     C     W#SOID        CHAIN     SORDERHP
     C                   EVAL      W#FOUND = %FOUND(SORDERHP)
     C                   IF        W#FOUND
     C                   EVAL      STATUS = 'INVOICED'
     C                   EVAL      UPDUSER = 'SYSTEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   UPDATE    SOHREC
     C                   ENDIF
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   IF        NOT W#ERROR
     C                   EVAL      W#ERRMSG = 'Invoice created successfully'
     C                   DSPLY                   W#ERRMSG
     C                   DSPLY                   W#CNTR
     C                   ELSE
     C                   EVAL      W#ERRMSG = 'Invoice creation failed'
     C                   DSPLY                   W#ERRMSG
     C                   ENDIF
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

