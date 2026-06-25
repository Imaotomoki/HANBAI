     H DFTACTGRP(*NO) ACTGRP(*NEW)
      *===============================================================
      * プログラム名: ORDERENTRY
      * 機能: 受注入力画面プログラム
      * 作成日: 2025-12-18
      * 説明: 5250画面を使用した対話型受注入力処理
      * 変更履歴:
      *   修正#1  - TOTAMT/ERRMSG初期化をワーク変数(W#TOTAMT)に統一
      *   修正#2  - REQDATE計算 %DATE+%DAYS / UNITPRC 9S4→13S4
      *   修正#3  - ITEML1作成 / RENAME CUSTREC→CSTREC,ITEMREC→ITMREC
      *   修正#4  - CHAIN前にWHID(4S0)→W#WHID(4P0)変換
      *   修正#5  - DIM(20) / F6=確認 / 合計リアルタイム更新
      *   修正#6  - @INPDETAIL再帰廃止 / DOWループ継続
      *   修正#9  - ORDDATE/REQDATE 8S0→8A
      *  修正#13  - OQTY_O/UPRC_O(表示用)セット処理追加
      *  修正#15  - L_ORDQTY: 15P3→15P0(整数)
      *  修正#16  - ORDQTY/UNITPRCをB型に統合
      *  修正#17  - L_UNITPRC/L_LINEAMT 整数化
      *  修正#19  - WDATE8: MOVE *DATE→%INT(%CHAR(W#ORDDT:*ISO0))
      *             で YYYYMMDD 形式の正しい8桁を取得
      *             受注番号: SO-20260608-182132 形式に修正
      *===============================================================

      *---------------------------------------------------------------
      * ファイル定義
      *---------------------------------------------------------------
     FORDENTRYD CF   E             WORKSTN SFILE(DETAIL:SFLRRN)
     FCUSTOMERL1IF   E           K DISK    PREFIX(C_)
     F                                     RENAME(CUSTREC:CSTREC)
     FITEML1    IF   E           K DISK    PREFIX(I_)
     F                                     RENAME(ITEMREC:ITMREC)
     FWAREHOUSEPIF   E           K DISK    PREFIX(W_)
     FSORDERHP  O    E             DISK    PREFIX(SO_)
     FSORDERLP  O    E             DISK    PREFIX(SL_)

      *---------------------------------------------------------------
      * グローバル変数定義
      *---------------------------------------------------------------
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0

     D W#SOID          S             18P 0
     D W#LINENO        S              9P 0
     D W#IDX           S             10I 0
     D W#ERROR         S               N
     D W#LINE_COUNT    S             10I 0
     D SFLRRN          S              4S 0

      * 修正#9: 8A型
     D W#ORDDATE       S              8A
     D W#REQDATE       S              8A
     D W#CURRCD        S              3A
     D W#PAYTERM       S             20A
     D W#WHID          S              4P 0
      * 修正#17: 整数
     D W#TOTAMT        S             15P 0
     D W#AMT           S             15P 0

     D W#ORDDT         S               D
     D W#REQDT         S               D

     D W#CUSTCD        S             20A
     D W#ITEMCD        S             12A
     D W#CUSTID        S              9P 0
     D W#ITEMID        S              9P 0

      *---------------------------------------------------------------
      * 明細行配列（最大20行）
      *---------------------------------------------------------------
     D L_ITEMCD        S             12A   DIM(20)
     D L_ITEMID        S              9P 0 DIM(20)
     D L_ITEMNM        S             22A   DIM(20)
      * 修正#15: 整数
     D L_ORDQTY        S             15P 0 DIM(20)
      * 修正#17: 整数
     D L_UNITPRC       S             13P 0 DIM(20)
     D L_LINEAMT       S             15P 0 DIM(20)

      *===============================================================
      * メイン処理
      *===============================================================
     C                   DOW       NOT *IN03
     C                   EXSR      @INIT
     C                   EXSR      @INPUT_HEADER

     C                   IF        *IN12
     C                   EVAL      *IN12 = *OFF
     C                   ITER
     C                   ENDIF

     C                   IF        *IN03
     C                   LEAVE
     C                   ENDIF

     C                   EXSR      @INPDETAIL

     C                   IF        *IN12
     C                   EVAL      *IN12 = *OFF
     C                   ITER
     C                   ENDIF

     C                   IF        *IN03
     C                   LEAVE
     C                   ENDIF

     C                   EXSR      @CONFIRM

     C                   IF        *IN12
     C                   EVAL      *IN12 = *OFF
     C                   EXSR      @INPDETAIL
     C                   IF        *IN12
     C                   EVAL      *IN12 = *OFF
     C                   ITER
     C                   ENDIF
     C                   IF        *IN03
     C                   LEAVE
     C                   ENDIF
     C                   EXSR      @CONFIRM
     C                   ENDIF

     C                   IF        *IN03
     C                   LEAVE
     C                   ENDIF

     C                   EXSR      @SAVEORD
     C                   EXSR      @SHOWCOMP
     C                   ENDDO

     C                   EVAL      *INLR = *ON
     C                   RETURN

     C*===============================================================
     C* @INIT - 初期化
     C*===============================================================
     C     @INIT         BEGSR

     C                   TIME                    WTIME6
      * 修正#19: MOVE *DATE は MMDDYY形式になる場合がある
      *          W#ORDDT(Date型)からYYYYMMDD形式の8桁数値を取得
     C                   MOVE      *DATE         W#ORDDT
     C                   EVAL      WDATE8 = %INT(%CHAR(W#ORDDT:*ISO0))

     C                   EVAL      W#ERROR = *OFF
     C                   EVAL      W#LINE_COUNT = 0
     C                   EVAL      W#TOTAMT = 0
     C                   EVAL      W#AMT = 0
     C                   EVAL      ERRMSG = *BLANK
     C                   EVAL      ERRMSG_D = *BLANK

     C                   EVAL      *IN03 = *OFF
     C                   EVAL      *IN06 = *OFF
     C                   EVAL      *IN12 = *OFF
     C                   EVAL      *IN31 = *OFF
     C                   EVAL      *IN32 = *OFF
     C                   EVAL      *IN33 = *OFF
     C                   EVAL      *IN34 = *OFF
     C                   EVAL      *IN35 = *OFF

     C                   EVAL      W#REQDT = W#ORDDT + %DAYS(10)
     C                   EVAL      ORDDATE = %CHAR(W#ORDDT:*ISO0)
     C                   EVAL      REQDATE = %CHAR(W#REQDT:*ISO0)
     C                   EVAL      CURRCD = 'JPY'
     C                   EVAL      PAYTERM = 'NET30'
     C                   EVAL      CUSTCD = *BLANK
     C                   EVAL      CUSTNM = *BLANK
     C                   EVAL      WHID = 0
     C                   EVAL      WHNM = *BLANK

     C                   ENDSR

     C*===============================================================
     C* @INPUT_HEADER - ヘッダー入力
     C*===============================================================
     C     @INPUT_HEADER BEGSR

     C                   EVAL      *IN31 = *OFF
     C                   EVAL      *IN32 = *OFF
     C                   EVAL      *IN33 = *OFF
     C                   EVAL      *IN34 = *OFF
     C                   EVAL      *IN35 = *OFF
     C                   EVAL      ERRMSG = *BLANK

     C                   EXFMT     HEADER

     C                   DOW       NOT *IN03 AND NOT *IN12

     C                   EXSR      @VALIDHDR

     C                   IF        NOT W#ERROR
     C                   LEAVE
     C                   ENDIF

     C                   EXFMT     HEADER
     C                   ENDDO

     C                   ENDSR

     C*===============================================================
     C* @VALIDHDR - ヘッダーバリデーション
     C*===============================================================
     C     @VALIDHDR     BEGSR

     C                   EVAL      W#ERROR = *OFF
     C                   EVAL      ERRMSG = *BLANK

     C     CUSTCD        CHAIN     CSTREC                             99
     C                   IF        *IN99
     C                   EVAL      *IN31 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Cust not found'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN31 = *OFF
     C                   EVAL      CUSTNM = C_CUSTNM
     C                   EVAL      W#CUSTID = C_CUSTID
     C                   ENDIF

     C                   IF        ORDDATE = *BLANK
     C                   EVAL      *IN32 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Invalid order date'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN32 = *OFF
     C                   ENDIF

     C                   IF        REQDATE < ORDDATE
     C                   EVAL      *IN33 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Invalid req date'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN33 = *OFF
     C                   ENDIF

     C                   EVAL      W#WHID = WHID
     C     W#WHID        CHAIN     WAREHOUSEP                         99
     C                   IF        *IN99
     C                   EVAL      *IN35 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Warehouse not found'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN35 = *OFF
     C                   EVAL      WHNM = W_WHNM
     C                   ENDIF

     C                   ENDSR

     C*===============================================================
     C* @INPDETAIL - 明細入力
     C*===============================================================
     C     @INPDETAIL    BEGSR

     C                   EVAL      CUSTCD_D = CUSTCD
     C                   EVAL      CUSTNM_D = CUSTNM
     C                   EVAL      ORDDATE_D = ORDDATE
     C                   EVAL      REQDATE_D = REQDATE
     C                   EVAL      CURRCD_D = CURRCD
     C                   EVAL      PAYTERM_D = PAYTERM
     C                   EVAL      WHID_D = WHID
     C                   EVAL      WHNM_D = WHNM

     C                   EVAL      *IN93 = *ON
     C                   WRITE     DETAILCTL
     C                   EVAL      *IN93 = *OFF
     C                   EVAL      W#LINE_COUNT = 0
     C                   EVAL      SFLRRN = 0
     C                   EVAL      W#TOTAMT = 0
     C                   EVAL      W#ERROR = *OFF
     C                   EVAL      ERRMSG_D = *BLANK
     C                   EVAL      ERRMSG = *BLANK
     C                   EVAL      *IN06 = *OFF

     C                   DOW       NOT *IN03 AND NOT *IN12
     C                             AND NOT *IN06

     C                   EVAL      *IN06 = *OFF

      * 入力用空行を追加
     C                   IF        W#LINE_COUNT < 20
     C                   ADD       1             SFLRRN
     C                   EVAL      LINENO = SFLRRN
     C                   EVAL      ITEMCD = *BLANK
     C                   EVAL      ITEMNM = *BLANK
     C                   EVAL      ORDQTY = 0
     C                   EVAL      UNITPRC = 0
     C                   WRITE     DETAIL
     C                   ENDIF

     C                   EVAL      TOTAMT_D = W#TOTAMT

     C                   EVAL      *IN91 = *ON
     C                   EVAL      *IN92 = *ON
     C                   EVAL      ERRMSG_D = ERRMSG
     C                   EXFMT     DETAILCTL
     C                   EVAL      ERRMSG = *BLANK
     C                   EVAL      ERRMSG_D = *BLANK

     C                   IF        *IN03 OR *IN12
     C                   LEAVE
     C                   ENDIF

     C                   IF        *IN06
     C                   IF        W#LINE_COUNT = 0
     C                   EVAL      ERRMSG = 'Enter at least 1 item'
     C                   EVAL      *IN06 = *OFF
     C                   EVAL      *IN93 = *ON
     C                   WRITE     DETAILCTL
     C                   EVAL      *IN93 = *OFF
     C                   EVAL      SFLRRN = 0
     C                   EXSR      @REDRAWSFL
     C                   ENDIF
     C                   ITER
     C                   ENDIF

     C                   READC     DETAIL                                 99

     C                   IF        *IN99
     C                   ITER
     C                   ENDIF

     C                   IF        ITEMCD = *BLANK
     C                   ITER
     C                   ENDIF

     C                   EXSR      @VALIDDET

     C                   IF        W#ERROR
     C                   EVAL      *IN93 = *ON
     C                   WRITE     DETAILCTL
     C                   EVAL      *IN93 = *OFF
     C                   EVAL      SFLRRN = W#LINE_COUNT
     C                   EXSR      @REDRAWSFL
     C                   ITER
     C                   ENDIF

      * 行確定→配列保存
     C                   ADD       1             W#LINE_COUNT
     C                   EVAL      W#IDX = W#LINE_COUNT
     C                   EVAL      L_ITEMCD(W#IDX) = ITEMCD
     C                   EVAL      L_ITEMID(W#IDX) = W#ITEMID
     C                   EVAL      L_ITEMNM(W#IDX) = ITEMNM
     C                   EVAL      L_ORDQTY(W#IDX) = ORDQTY
     C                   EVAL      L_UNITPRC(W#IDX) = UNITPRC
     C                   EVAL      L_LINEAMT(W#IDX) = ORDQTY * UNITPRC
     C                   EVAL      W#AMT = L_LINEAMT(W#IDX)
     C                   ADD       W#AMT         W#TOTAMT
     C                   UPDATE    DETAIL

     C                   ENDDO

     C                   IF        W#LINE_COUNT = 0
     C                             AND NOT *IN03 AND NOT *IN12
     C                             AND NOT *IN06
     C                   EVAL      ERRMSG = 'Enter at least 1 item'
     C                   EVAL      W#ERROR = *ON
     C                   ENDIF

     C                   ENDSR

     C*===============================================================
     C* @REDRAWSFL - サブファイル再描画
     C*===============================================================
     C     @REDRAWSFL    BEGSR

     C                   EVAL      W#IDX = 1
     C                   DOW       W#IDX <= W#LINE_COUNT
     C                   EVAL      LINENO = W#IDX
     C                   EVAL      ITEMCD = L_ITEMCD(W#IDX)
     C                   EVAL      ITEMNM = L_ITEMNM(W#IDX)
     C                   EVAL      ORDQTY = L_ORDQTY(W#IDX)
     C                   EVAL      UNITPRC = L_UNITPRC(W#IDX)
     C                   WRITE     DETAIL
     C                   ADD       1             W#IDX
     C                   ENDDO
     C                   EVAL      SFLRRN = W#LINE_COUNT

     C                   ENDSR

     C*===============================================================
     C* @VALIDDET - 明細バリデーション
     C*===============================================================
     C     @VALIDDET     BEGSR

     C                   EVAL      W#ERROR = *OFF
     C                   EVAL      ERRMSG = *BLANK

     C     ITEMCD        CHAIN     ITMREC                             99
     C                   IF        *IN99
     C                   EVAL      *IN41 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Item not found'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN41 = *OFF
     C                   EVAL      ITEMNM = I_ITEMDSC
     C                   EVAL      W#ITEMID = I_ITEMID
     C                   IF        UNITPRC = 0
     C                   EVAL      UNITPRC = I_UNITPRC
     C                   ENDIF
     C                   ENDIF

     C                   IF        ORDQTY <= 0
     C                   EVAL      *IN42 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Invalid quantity'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN42 = *OFF
     C                   ENDIF

     C                   IF        UNITPRC < 0
     C                   EVAL      *IN43 = *ON
     C                   EVAL      W#ERROR = *ON
     C                   EVAL      ERRMSG = 'Invalid unit price'
     C                   LEAVESR
     C                   ELSE
     C                   EVAL      *IN43 = *OFF
     C                   ENDIF

     C                   ENDSR

     C*===============================================================
     C* @CONFIRM - 確認画面
     C*===============================================================
     C     @CONFIRM      BEGSR

     C                   EVAL      CUSTCD_C = CUSTCD
     C                   EVAL      CUSTNM_C = CUSTNM
     C                   EVAL      ORDDATE_C = ORDDATE
     C                   EVAL      REQDATE_C = REQDATE
     C                   EVAL      CURRCD_C = CURRCD
     C                   EVAL      PAYTERM_C = PAYTERM
     C                   EVAL      WHID_C = WHID
     C                   EVAL      WHNM_C = WHNM
     C                   EVAL      TOTAMT = W#TOTAMT

     C                   EVAL      *IN91 = *ON
     C                   EVAL      *IN92 = *ON

     C                   EXFMT     CONFIRM

     C                   ENDSR

     C*===============================================================
     C* @SAVEORD - 受注保存
     C*===============================================================
     C     @SAVEORD      BEGSR

     C                   EVAL      W#SOID = (WDATE8 * 1000000) + WTIME6
     C                   EVAL      W#ORDDATE = ORDDATE
     C                   EVAL      W#REQDATE = REQDATE
     C                   EVAL      W#CURRCD = CURRCD
     C                   EVAL      W#PAYTERM = PAYTERM
     C                   EVAL      W#WHID = WHID

     C                   CLEAR                   SOHREC
     C                   EVAL      SO_SOID = W#SOID
      * 修正#19: WDATE8はYYYYMMDD(8桁)になったので受注番号は正しい形式
     C                   EVAL      SO_SONUM = 'SO-' + %CHAR(WDATE8) + '-' +
     C                             %CHAR(WTIME6)
     C                   EVAL      SO_CUSTID = W#CUSTID
     C                   EVAL      SO_ORDDATE = %INT(W#ORDDATE)
     C                   EVAL      SO_REQDATE = %INT(W#REQDATE)
     C                   EVAL      SO_CURRCD = W#CURRCD
     C                   EVAL      SO_PAYTERM = W#PAYTERM
     C                   EVAL      SO_WHID = W#WHID
     C                   EVAL      SO_STATUS = 'PENDING'
     C                   EVAL      SO_TOTAMT = W#TOTAMT
     C                   EVAL      SO_CRTUSER = 'DSPFUSER'
     C                   EVAL      SO_UPDUSER = 'DSPFUSER'
     C                   EVAL      SO_CRTDATE = WDATE8
     C                   EVAL      SO_UPDDATE = WDATE8
     C                   EVAL      SO_CRTTIM = WTIME6
     C                   EVAL      SO_UPDTIM = WTIME6

     C                   WRITE     SOHREC

     C                   EVAL      W#LINENO = 1
     C                   DOW       W#LINENO <= W#LINE_COUNT
     C                   EVAL      W#IDX = W#LINENO
     C                   CLEAR                   SOLREC
     C                   EVAL      SL_SOID = W#SOID
     C                   EVAL      SL_LINENO = W#LINENO
     C                   EVAL      SL_ITEMID = L_ITEMID(W#IDX)
     C                   EVAL      SL_ORDQTY = L_ORDQTY(W#IDX)
     C                   EVAL      SL_UNITPRC = L_UNITPRC(W#IDX)
     C                   EVAL      SL_LINEAMT = L_LINEAMT(W#IDX)
     C                   EVAL      SL_ALCQTY = 0
     C                   EVAL      SL_SHPQTY = 0
     C                   EVAL      SL_STATUS = 'PENDING'

     C                   WRITE     SOLREC

     C                   ADD       1             W#LINENO
     C                   ENDDO

     C                   ENDSR

     C*===============================================================
     C* @SHOWCOMP - 完了画面
     C*===============================================================
     C     @SHOWCOMP     BEGSR

     C                   EVAL      *IN91 = *ON
     C                   EVAL      *IN92 = *ON
     C                   EVAL      SONUM = SO_SONUM

     C                   EXFMT     COMPLETE

     C                   ENDSR

