     H DATEDIT(*YMD) DECEDIT('0.') COPYRIGHT('DEMOAPP')
      *=====================================================================
      * プログラム名: INITCUST
      * 説明: 顧客マスタの初期データ投入
      * ライブラリ: DEMOAPP
      *=====================================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FCUSTOMERP O    E             DISK

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
     C                   EXSR      @CUST
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
      * サブルーチン: @CUST - 顧客データ投入
      *=====================================================================
     C     @CUST         BEGSR
      *-------------------------------------------------------------------
      * 国内顧客（日本企業）
      *-------------------------------------------------------------------
     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0001'
     C                   EVAL      CUSTNM = 'トヨタ自動車株式会社'
     C                   EVAL      BILLADR =
     C                               '愛知県豊田市トヨタ町1番地'
     C                   EVAL      SHIPADR =
     C                               '愛知県豊田市トヨタ町1番地'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 100000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0002'
     C                   EVAL      CUSTNM = 'ソニーグループ株式会社'
     C                   EVAL      BILLADR = '東京都港区港南1-7-1'
     C                   EVAL      SHIPADR = '東京都港区港南1-7-1'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 50000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0003'
     C                   EVAL      CUSTNM = 'パナソニック株式会社'
     C                   EVAL      BILLADR =
     C                               '大阪府門真市大字門真1006番地'
     C                   EVAL      SHIPADR =
     C                               '大阪府門真市大字門真1006番地'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 80000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0004'
     C                   EVAL      CUSTNM = '日立製作所'
     C                   EVAL      BILLADR =
     C                               '東京都千代田区丸の内1-6-6'
     C                   EVAL      SHIPADR =
     C                               '東京都千代田区丸の内1-6-6'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 70000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0005'
     C                   EVAL      CUSTNM = '富士通株式会社'
     C                   EVAL      BILLADR = '東京都港区東新橋1-5-2'
     C                   EVAL      SHIPADR = '東京都港区東新橋1-5-2'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 60000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0006'
     C                   EVAL      CUSTNM = 'NEC Corporation'
     C                   EVAL      BILLADR = '東京都港区芝5-7-1'
     C                   EVAL      SHIPADR = '東京都港区芝5-7-1'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 55000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0007'
     C                   EVAL      CUSTNM = 'キヤノン株式会社'
     C                   EVAL      BILLADR =
     C                               '東京都大田区下丸子3-30-2'
     C                   EVAL      SHIPADR =
     C                               '東京都大田区下丸子3-30-2'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 45000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0008'
     C                   EVAL      CUSTNM = '三菱電機株式会社'
     C                   EVAL      BILLADR =
     C                               '東京都千代田区丸の内2-7-3'
     C                   EVAL      SHIPADR =
     C                               '東京都千代田区丸の内2-7-3'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 65000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0009'
     C                   EVAL      CUSTNM = 'シャープ株式会社'
     C                   EVAL      BILLADR =
     C                               '大阪府堺市堺区匠町1番地'
     C                   EVAL      SHIPADR =
     C                               '大阪府堺市堺区匠町1番地'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 40000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-0010'
     C                   EVAL      CUSTNM = '東芝テック株式会社'
     C                   EVAL      BILLADR =
     C                               '東京都品川区大崎1-11-1'
     C                   EVAL      SHIPADR =
     C                               '東京都品川区大崎1-11-1'
     C                   EVAL      TAXCAT = 'STANDARD'
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      CREDLMT = 35000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 海外顧客（米国企業）
      *-------------------------------------------------------------------
     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-US01'
     C                   EVAL      CUSTNM = 'Apple Inc.'
     C                   EVAL      BILLADR =
     C                               'One Apple Park Way, Cupertino, CA'
     C                   EVAL      SHIPADR =
     C                               'One Apple Park Way, Cupertino, CA'
     C                   EVAL      TAXCAT = 'EXPORT'
     C                   EVAL      CURRCD = 'USD'
     C                   EVAL      CREDLMT = 5000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-US02'
     C                   EVAL      CUSTNM = 'Microsoft Corporation'
     C                   EVAL      BILLADR =
     C                               'One Microsoft Way, Redmond, WA'
     C                   EVAL      SHIPADR =
     C                               'One Microsoft Way, Redmond, WA'
     C                   EVAL      TAXCAT = 'EXPORT'
     C                   EVAL      CURRCD = 'USD'
     C                   EVAL      CREDLMT = 4500000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 海外顧客（欧州企業）
      *-------------------------------------------------------------------
     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-EU01'
     C                   EVAL      CUSTNM = 'Siemens AG'
     C                   EVAL      BILLADR =
     C                               'Werner-von-Siemens-Str. 1, Munchen'
     C                   EVAL      SHIPADR =
     C                               'Werner-von-Siemens-Str. 1, Munchen'
     C                   EVAL      TAXCAT = 'EXPORT'
     C                   EVAL      CURRCD = 'EUR'
     C                   EVAL      CREDLMT = 3000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

      *-------------------------------------------------------------------
      * 海外顧客（アジア企業）
      *-------------------------------------------------------------------
     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-CN01'
     C                   EVAL      CUSTNM = 'Huawei Technologies'
     C                   EVAL      BILLADR =
     C                               'Bantian, Longgang, Shenzhen, China'
     C                   EVAL      SHIPADR =
     C                               'Bantian, Longgang, Shenzhen, China'
     C                   EVAL      TAXCAT = 'EXPORT'
     C                   EVAL      CURRCD = 'CNY'
     C                   EVAL      CREDLMT = 20000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
     C                   ADD       1             W#CNTR
     C                   ADD       1             W#NXID

     C                   EVAL      CUSTID = W#NXID
     C                   EVAL      CUSTCD = 'CUST-KR01'
     C                   EVAL      CUSTNM = 'Samsung Electronics'
     C                   EVAL      BILLADR =
     C                               '129 Samsung-ro, Suwon, South Korea'
     C                   EVAL      SHIPADR =
     C                               '129 Samsung-ro, Suwon, South Korea'
     C                   EVAL      TAXCAT = 'EXPORT'
     C                   EVAL      CURRCD = 'KRW'
     C                   EVAL      CREDLMT = 5000000000.00
     C                   EVAL      STATUS = 'ACTIVE'
     C                   EVAL      CRTUSER = 'INITCUST'
     C                   EVAL      CRTDATE = WDATE8
     C                   EVAL      CRTTIM = WTIME6
     C                   EVAL      UPDUSER = 'INITCUST'
     C                   EVAL      UPDDATE = WDATE8
     C                   EVAL      UPDTIM = WTIME6
     C                   WRITE     CUSTREC
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

