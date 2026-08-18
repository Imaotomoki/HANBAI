     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITITEM
      * 説明: 商品マスタの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FITEMP     O    E             DISK

      *---------------------------------------------------------------
      * 変数定義
      *---------------------------------------------------------------
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
     D W#CNTR          S              9S 0
     D W#NXID          S              9S 0

      *=====================================================================
      * メインルーチン
      *=====================================================================
     C                   EXSR      @INZ
     C                   EXSR      @ITEM
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
      * サブルーチン: @ITEM - 商品データ投入
      *=====================================================================
     C     @ITEM         BEGSR
      *-------------------------------------------------------------------
      * 電子機器カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E001'
     C                   EVAL      ITEMDSC = 'ノートPC i7 16GB 512GB SSD'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 150000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E002'
     C                   EVAL      ITEMDSC = 'デスクトップPC i9 32GB 1TB SSD'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 250000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E003'
     C                   EVAL      ITEMDSC = '液晶モニター 27インチ 4K'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 45000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E004'
     C                   EVAL      ITEMDSC = 'ワイヤレスキーボード'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 8000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E005'
     C                   EVAL      ITEMDSC = 'ワイヤレスマウス'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 5000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E006'
     C                   EVAL      ITEMDSC = 'Webカメラ Full HD'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 12000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E007'
     C                   EVAL      ITEMDSC = 'ヘッドセット ノイキャン対応'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 18000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E008'
     C                   EVAL      ITEMDSC = 'プリンター 複合機 A4'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 35000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E009'
     C                   EVAL      ITEMDSC = 'スキャナー A4 両面対応'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 28000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-E010'
     C                   EVAL      ITEMDSC = 'タブレット 10インチ 128GB'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 55000.0000
     C                   EVAL      CATEGORY = 'ELECTRONICS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 家具カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-F001'
     C                   EVAL      ITEMDSC = 'オフィスデスク 幅120cm'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 35000.0000
     C                   EVAL      CATEGORY = 'FURNITURE'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-F002'
     C                   EVAL      ITEMDSC = 'オフィスチェア エルゴ対応'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 45000.0000
     C                   EVAL      CATEGORY = 'FURNITURE'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-F003'
     C                   EVAL      ITEMDSC = '書棚 5段 幅90cm'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 25000.0000
     C                   EVAL      CATEGORY = 'FURNITURE'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-F004'
     C                   EVAL      ITEMDSC = 'ミーティングテーブル 6人用'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 80000.0000
     C                   EVAL      CATEGORY = 'FURNITURE'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-F005'
     C                   EVAL      ITEMDSC = 'キャビネット 3段 鍵付き'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 38000.0000
     C                   EVAL      CATEGORY = 'FURNITURE'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 食品カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-FD01'
     C                   EVAL      ITEMDSC = 'コーヒー豆 ブレンド 1kg'
     C                   EVAL      UOM = 'KG'
     C                   EVAL      UNITPRC = 3000.0000
     C                   EVAL      CATEGORY = 'FOOD'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-FD02'
     C                   EVAL      ITEMDSC = '緑茶 煎茶 100g'
     C                   EVAL      UOM = 'KG'
     C                   EVAL      UNITPRC = 1500.0000
     C                   EVAL      CATEGORY = 'FOOD'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-FD03'
     C                   EVAL      ITEMDSC = 'ミネラルウォーター 2L'
     C                   EVAL      UOM = 'L'
     C                   EVAL      UNITPRC = 150.0000
     C                   EVAL      CATEGORY = 'FOOD'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-FD04'
     C                   EVAL      ITEMDSC = 'お菓子詰め合わせセット'
     C                   EVAL      UOM = 'BOX'
     C                   EVAL      UNITPRC = 2500.0000
     C                   EVAL      CATEGORY = 'FOOD'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-FD05'
     C                   EVAL      ITEMDSC = 'インスタントラーメン 5食入'
     C                   EVAL      UOM = 'CASE'
     C                   EVAL      UNITPRC = 800.0000
     C                   EVAL      CATEGORY = 'FOOD'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 衣料品カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-C001'
     C                   EVAL      ITEMDSC = 'ビジネススーツ 上下セット'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 45000.0000
     C                   EVAL      CATEGORY = 'CLOTHING'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-C002'
     C                   EVAL      ITEMDSC = 'ワイシャツ 長袖'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 5000.0000
     C                   EVAL      CATEGORY = 'CLOTHING'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-C003'
     C                   EVAL      ITEMDSC = 'ネクタイ シルク100%'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 8000.0000
     C                   EVAL      CATEGORY = 'CLOTHING'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-C004'
     C                   EVAL      ITEMDSC = 'ビジネスシューズ 革靴'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 15000.0000
     C                   EVAL      CATEGORY = 'CLOTHING'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-C005'
     C                   EVAL      ITEMDSC = 'ベルト 本革'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 6000.0000
     C                   EVAL      CATEGORY = 'CLOTHING'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 書籍カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-B001'
     C                   EVAL      ITEMDSC = 'ビジネス書 経営戦略'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 2500.0000
     C                   EVAL      CATEGORY = 'BOOKS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-B002'
     C                   EVAL      ITEMDSC = '技術書 プログラミング入門'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 3500.0000
     C                   EVAL      CATEGORY = 'BOOKS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-B003'
     C                   EVAL      ITEMDSC = '雑誌 ビジネス月刊誌'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 800.0000
     C                   EVAL      CATEGORY = 'BOOKS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-B004'
     C                   EVAL      ITEMDSC = '辞書 英和・和英'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 4500.0000
     C                   EVAL      CATEGORY = 'BOOKS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-B005'
     C                   EVAL      ITEMDSC = '参考書 資格試験対策'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 3000.0000
     C                   EVAL      CATEGORY = 'BOOKS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 玩具カテゴリ
      *-------------------------------------------------------------------
     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-T001'
     C                   EVAL      ITEMDSC = 'ボードゲーム ファミリー向け'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 4500.0000
     C                   EVAL      CATEGORY = 'TOYS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-T002'
     C                   EVAL      ITEMDSC = 'パズル 1000ピース'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 2500.0000
     C                   EVAL      CATEGORY = 'TOYS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-T003'
     C                   EVAL      ITEMDSC = 'ぬいぐるみ Lサイズ'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 3500.0000
     C                   EVAL      CATEGORY = 'TOYS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-T004'
     C                   EVAL      ITEMDSC = 'プラモデル 1/144スケール'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 2000.0000
     C                   EVAL      CATEGORY = 'TOYS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      ITEMID = W#NXID
     C                   EVAL      ITEMCD = 'ITEM-T005'
     C                   EVAL      ITEMDSC = 'カードゲーム スターターセット'
     C                   EVAL      UOM = 'EA'
     C                   EVAL      UNITPRC = 1500.0000
     C                   EVAL      CATEGORY = 'TOYS'
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITITEM'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITITEM'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     ITEMREC
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

