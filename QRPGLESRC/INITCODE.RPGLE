     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITCODE
      * 説明: コードマスタの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FCODEMSTRP O    E             DISK

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
     C                   EXSR      @CURR
     C                   EXSR      @TAX
     C                   EXSR      @STAT
     C                   EXSR      @SOSTAT
     C                   EXSR      @PAYTRM
     C                   EXSR      @UOM
     C                   EXSR      @ITMCAT
     C                   EXSR      @USRROL
     C                   EXSR      @DEPT
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
      * サブルーチン: @CURR - 通貨コード投入
      *=====================================================================
     C     @CURR         BEGSR
     C                   EVAL      CODETYPE = 'CURRENCY'
     C                   EVAL      CODEVAL = 'JPY'
     C                   EVAL      DESC = '日本円'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'CURRENCY'
     C                   EVAL      CODEVAL = 'USD'
     C                   EVAL      DESC = '米ドル'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'CURRENCY'
     C                   EVAL      CODEVAL = 'EUR'
     C                   EVAL      DESC = 'ユーロ'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'CURRENCY'
     C                   EVAL      CODEVAL = 'CNY'
     C                   EVAL      DESC = '中国元'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'CURRENCY'
     C                   EVAL      CODEVAL = 'KRW'
     C                   EVAL      DESC = '韓国ウォン'
     C                   EVAL      DISPORD = 5
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @TAX - 税区分投入
      *=====================================================================
     C     @TAX          BEGSR
     C                   EVAL      CODETYPE = 'TAX_CAT'
     C                   EVAL      CODEVAL = 'STANDARD'
     C                   EVAL      DESC = '標準税率(10%)'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'TAX_CAT'
     C                   EVAL      CODEVAL = 'REDUCED'
     C                   EVAL      DESC = '軽減税率(8%)'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'TAX_CAT'
     C                   EVAL      CODEVAL = 'EXEMPT'
     C                   EVAL      DESC = '非課税'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'TAX_CAT'
     C                   EVAL      CODEVAL = 'EXPORT'
     C                   EVAL      DESC = '輸出免税'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @STAT - ステータス投入
      *=====================================================================
     C     @STAT         BEGSR
     C                   EVAL      CODETYPE = 'STATUS'
     C                   EVAL      CODEVAL = 'ACTIVE'
     C                   EVAL      DESC = '有効'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'STATUS'
     C                   EVAL      CODEVAL = 'INACTIVE'
     C                   EVAL      DESC = '無効'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'STATUS'
     C                   EVAL      CODEVAL = 'PENDING'
     C                   EVAL      DESC = '保留中'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'STATUS'
     C                   EVAL      CODEVAL = 'CANCELLED'
     C                   EVAL      DESC = 'キャンセル'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @SOSTAT - 受注ステータス投入
      *=====================================================================
     C     @SOSTAT       BEGSR
     C                   EVAL      CODETYPE = 'SO_STATUS'
     C                   EVAL      CODEVAL = 'OPEN'
     C                   EVAL      DESC = '受注済'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'SO_STATUS'
     C                   EVAL      CODEVAL = 'ALLOCATED'
     C                   EVAL      DESC = '引当済'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'SO_STATUS'
     C                   EVAL      CODEVAL = 'SHIPPED'
     C                   EVAL      DESC = '出荷済'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'SO_STATUS'
     C                   EVAL      CODEVAL = 'INVOICED'
     C                   EVAL      DESC = '請求済'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'SO_STATUS'
     C                   EVAL      CODEVAL = 'CANCELLED'
     C                   EVAL      DESC = 'キャンセル'
     C                   EVAL      DISPORD = 5
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @PAYTRM - 支払条件投入
      *=====================================================================
     C     @PAYTRM       BEGSR
     C                   EVAL      CODETYPE = 'PAYMENT_TERM'
     C                   EVAL      CODEVAL = 'NET30'
     C                   EVAL      DESC = '月末締翌月末払'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'PAYMENT_TERM'
     C                   EVAL      CODEVAL = 'NET60'
     C                   EVAL      DESC = '月末締翌々月末払'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'PAYMENT_TERM'
     C                   EVAL      CODEVAL = 'COD'
     C                   EVAL      DESC = '代金引換'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'PAYMENT_TERM'
     C                   EVAL      CODEVAL = 'PREPAID'
     C                   EVAL      DESC = '前払'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @UOM - 単位投入
      *=====================================================================
     C     @UOM          BEGSR
     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'EA'
     C                   EVAL      DESC = '個'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'KG'
     C                   EVAL      DESC = 'キログラム'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'L'
     C                   EVAL      DESC = 'リットル'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'M'
     C                   EVAL      DESC = 'メートル'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'BOX'
     C                   EVAL      DESC = '箱'
     C                   EVAL      DISPORD = 5
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'UOM'
     C                   EVAL      CODEVAL = 'CASE'
     C                   EVAL      DESC = 'ケース'
     C                   EVAL      DISPORD = 6
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @ITMCAT - 商品カテゴリ投入
      *=====================================================================
     C     @ITMCAT       BEGSR
     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'ELECTRONICS'
     C                   EVAL      DESC = '電子機器'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'FURNITURE'
     C                   EVAL      DESC = '家具'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'FOOD'
     C                   EVAL      DESC = '食品'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'CLOTHING'
     C                   EVAL      DESC = '衣料品'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'BOOKS'
     C                   EVAL      DESC = '書籍'
     C                   EVAL      DISPORD = 5
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'ITEM_CAT'
     C                   EVAL      CODEVAL = 'TOYS'
     C                   EVAL      DESC = '玩具'
     C                   EVAL      DISPORD = 6
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @USRROL - ユーザーロール投入
      *=====================================================================
     C     @USRROL       BEGSR
     C                   EVAL      CODETYPE = 'USER_ROLE'
     C                   EVAL      CODEVAL = 'SALES'
     C                   EVAL      DESC = '営業'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'USER_ROLE'
     C                   EVAL      CODEVAL = 'WAREHOUSE'
     C                   EVAL      DESC = '倉庫'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'USER_ROLE'
     C                   EVAL      CODEVAL = 'ACCOUNTING'
     C                   EVAL      DESC = '経理'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'USER_ROLE'
     C                   EVAL      CODEVAL = 'ADMIN'
     C                   EVAL      DESC = '管理者'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @DEPT - 部門投入
      *=====================================================================
     C     @DEPT         BEGSR
     C                   EVAL      CODETYPE = 'DEPT'
     C                   EVAL      CODEVAL = 'SALES'
     C                   EVAL      DESC = '営業部'
     C                   EVAL      DISPORD = 1
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'DEPT'
     C                   EVAL      CODEVAL = 'WAREHOUSE'
     C                   EVAL      DESC = '物流部'
     C                   EVAL      DISPORD = 2
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'DEPT'
     C                   EVAL      CODEVAL = 'ACCOUNTING'
     C                   EVAL      DESC = '経理部'
     C                   EVAL      DISPORD = 3
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'DEPT'
     C                   EVAL      CODEVAL = 'IT'
     C                   EVAL      DESC = '情報システム部'
     C                   EVAL      DISPORD = 4
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR

     C                   EVAL      CODETYPE = 'DEPT'
     C                   EVAL      CODEVAL = 'HR'
     C                   EVAL      DESC = '人事部'
     C                   EVAL      DISPORD = 5
     C                   EVAL      ISACTIVE = 'Y'
     C                   EVAL      CRTDATE = %DATE(WTIMESTAMP)
     C                   EVAL      CRTTIM = %TIME(WTIMESTAMP)
     C                   WRITE     CODEREC
     C                   ADD       1             W#CNTR
     C                   ENDSR

      *=====================================================================
      * サブルーチン: @END - 終了処理
      *=====================================================================
     C     @END          BEGSR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR

