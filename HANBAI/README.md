# 販売管理システム (HANBAI) — O2C デモアプリケーション

IBM i 上で動作する **受注〜入金 (Order-to-Cash / O2C)** の一連の業務フローを実装したデモアプリケーションです。  
ILE RPG (固定形式)・DDS・CL で構成されており、ライブラリ **`HANBAI`** に展開されます。


## サンプルデータについてのご注意

本リポジトリの初期データ投入プログラム（`INITCUST.RPGLE` など）では、トヨタ自動車・ソニーグループ・パナソニック・Apple・Samsung といった実在の企業名を、デモ用の顧客マスタのサンプルデータとして使用しています。これらは実在企業との実際の取引関係を示すものではなく、あくまでデモンストレーション・研修目的で作成した架空のデータです。

---

## 業務フロー概要

```
受注入力        受注登録         出荷確定         請求発行
(ORDERENTRY) → (CREATESORD) → (CONFIRMSHP) → (CREATEINV)
     ↓               ↓               ↓               ↓
 5250画面      在庫引当・        在庫減算・       請求書生成・
  対話処理     受注ヘッダ/       出荷ヘッダ/      受注ステータス
              明細書き込み      明細書き込み     'INVOICED'更新
```

在庫ファイル (`INVENTORYP`) には **`AFTER UPDATE` トリガー** (`INVTRIGGER`) が設定されており、変更履歴の記録と在庫整合性チェックが自動実行されます。

---

## ディレクトリ構成

```
HANBAI/
├── QCLLESRC/          CL ソースファイル
│   ├── CRTFILES.CLLE  データベースファイル作成
│   ├── SETUPAUTH.CLLE 権限設定（ロールベースアクセス制御）
│   ├── SETUPJRN.CLLE  ジャーナル環境セットアップ
│   ├── COMPINIT.CLLE  初期データ投入プログラムのコンパイル
│   ├── COMPBIZ.CLLE   業務ロジックプログラムのコンパイル
│   └── INITDATA.CLLE  初期マスタデータ一括投入
├── QDDSSRC/           DDS ソースファイル
│   ├── (物理ファイル .PF)
│   ├── (論理ファイル .LF)
│   └── ORDENTRYD.DSPF 受注入力画面ファイル
└── QRPGLESRC/         ILE RPG ソースファイル
    ├── (業務ロジック .RPGLE)
    └── (初期データ投入 .RPGLE)
```

---

## データベース設計

### マスタファイル (物理ファイル)

| ファイル名     | 説明                             | 主キー          |
|--------------|----------------------------------|-----------------|
| `CUSTOMERP`  | 顧客台帳（企業・個人）            | `CUSTID`        |
| `ITEMP`      | 商品マスタ                        | `ITEMID`        |
| `WAREHOUSEP` | 倉庫マスタ（物流拠点）            | `WHID`          |
| `INVENTORYP` | 在庫（倉庫×商品）                | `WHID + ITEMID` |
| `FXRATEP`    | 為替レート（日付・通貨ペア別）    | —               |
| `CODEMSTRP`  | システムコードマスタ              | —               |
| `APPUSERP`   | アプリケーションユーザー          | —               |
| `USERROLEP`  | ユーザーと権限ロールの紐付け      | —               |

### トランザクションファイル (物理ファイル)

| ファイル名      | 説明                   | 主キー   |
|---------------|------------------------|----------|
| `SORDERHP`    | 受注ヘッダ             | `SOID`   |
| `SORDERLP`    | 受注明細               | `SOID + LINENO` |
| `SHIPMENTHP`  | 出荷ヘッダ             | `SHPID`  |
| `SHIPMENTLP`  | 出荷明細               | `SHPID + LINENO` |
| `INVOICEHP`   | 請求ヘッダ             | `INVID`  |
| `INVOICELP`   | 請求明細               | `INVID + LINENO` |
| `PAYMENTP`    | 入金・消込             | —        |
| `CHANGELOGP`  | 変更履歴（監査ログ）   | `LOGID`  |

### 論理ファイル

| ファイル名     | 基底ファイル    | 用途                         |
|--------------|----------------|------------------------------|
| `CUSTOMERL1` | `CUSTOMERP`    | 顧客コード (`CUSTCD`) 検索   |
| `ITEML1`     | `ITEMP`        | 商品コード (`ITEMCD`) 検索   |
| `WAREHOUSL1` | `WAREHOUSEP`   | 倉庫コード検索               |
| `INVENTORL1` | `INVENTORYP`   | 商品ID 検索                  |
| `SORDERHL1`  | `SORDERHP`     | 受注番号 (`SONUM`) 検索      |
| `SORDERHL2`  | `SORDERHP`     | 顧客別・日付別検索           |
| `SORDERLL1`  | `SORDERLP`     | 商品別の受注検索             |

---

## プログラム一覧

### 業務ロジック (QRPGLESRC)

| メンバー名      | 説明                                            |
|---------------|-------------------------------------------------|
| `ORDERENTRY`  | **受注入力画面** — 5250対話型入力 (`ORDENTRYD` 使用)。ヘッダ入力→明細入力→確認→登録の画面フロー |
| `CREATESORD`  | **受注登録** — 顧客・商品検証、在庫引当 (`QTYALC` 加算)、受注ヘッダ/明細書き込み |
| `CONFIRMSHP`  | **出荷確定** — 引当済数量チェック → 在庫減算 (`QTYOH`/`QTYALC` 減算) → 出荷ヘッダ/明細書き込み → 受注ステータス `'SHIPPED'` 更新 |
| `CREATEINV`   | **請求発行** — 出荷データをもとに請求ヘッダ/明細生成、受注ステータス `'INVOICED'` 更新。単価・税率は `SORDERLP` から取得 |
| `INVTRIGGER`  | **在庫更新トリガー** — `INVENTORYP` の `AFTER UPDATE` で起動。`QTYOH`/`QTYALC`/`QTYAVL` の変更を `CHANGELOGP` に記録し、マイナス在庫・整合性エラーをアラート |

### 初期データ投入 (QRPGLESRC)

| メンバー名    | 説明                   |
|-------------|------------------------|
| `INITCODE`  | コードマスタ投入       |
| `INITWH`    | 倉庫マスタ投入         |
| `INITCUST`  | 顧客マスタ投入         |
| `INITITEM`  | 商品マスタ投入         |
| `INITFX`    | 為替レート投入         |
| `INITINV`   | 在庫初期データ投入     |
| `INITUSER`  | アプリユーザー投入     |

### 画面ファイル (QDDSSRC)

| メンバー名      | 説明                                                                      |
|---------------|---------------------------------------------------------------------------|
| `ORDENTRYD`   | 受注入力画面 (24×80 5250)。`HEADER`・`DETAIL`(SFL)・`CONFIRM`・`COMPLETE` の4レコード構成 |

### CL プログラム (QCLLESRC)

| メンバー名      | 説明                                                                   |
|---------------|------------------------------------------------------------------------|
| `CRTFILES`    | 全物理ファイル・論理ファイルを `HANBAI` ライブラリに作成              |
| `SETUPAUTH`   | グループプロファイル (`O2CSALES`/`O2CWHSE`/`O2CACCT`/`O2CADMIN`) 作成と権限設定 |
| `SETUPJRN`    | ジャーナルレシーバー・ジャーナル (`O2CJRN`) 作成、全ファイルのジャーナリング開始 |
| `COMPINIT`    | 初期データ投入プログラム群 (`INITCODE`〜`INITDATA`) の一括コンパイル   |
| `COMPBIZ`     | 業務ロジックプログラム群 (`CREATESORD`/`CONFIRMSHP`/`CREATEINV`/`INVTRIGGER`) の一括コンパイルとトリガー設定 |
| `INITDATA`    | 各初期データ投入プログラムを順序どおりに呼び出す制御プログラム         |

---

## セットアップ手順

> **前提**: ライブラリ `HANBAI` が事前に存在していること。

```
CRTLIB LIB(HANBAI) TEXT('O2C Demo Application')
```

### 1. データベースファイルの作成

```
CALL PGM(HANBAI/CRTFILES)
```

### 2. ジャーナル環境のセットアップ

```
CALL PGM(HANBAI/SETUPJRN)
```

### 3. 権限設定

```
CALL PGM(HANBAI/SETUPAUTH)
```

### 4. 初期データ投入プログラムのコンパイル

```
CALL PGM(HANBAI/COMPINIT)
```

### 5. 業務ロジックプログラムのコンパイル

```
CALL PGM(HANBAI/COMPBIZ)
```
> `COMPBIZ` は最後に `INVENTORYP` へのトリガー (`INVTRIGGER`) も自動設定します。

### 6. 初期マスタデータ投入

```
CALL PGM(HANBAI/INITDATA)
```

---

## 権限設計 (ロールベースアクセス制御)

| グループプロファイル | 役割   | 主な権限                                              |
|--------------------|--------|-------------------------------------------------------|
| `O2CSALES`         | 営業   | 顧客・受注: `*CHANGE` / 商品・在庫: `*USE`(読取)      |
| `O2CWHSE`          | 倉庫   | 在庫・出荷: `*CHANGE` / 受注・商品: `*USE`(読取)      |
| `O2CACCT`          | 経理   | 請求・入金・為替: `*CHANGE` / 受注・出荷: `*USE`(読取)|
| `O2CADMIN`         | 管理者 | 全ファイル・ライブラリ: `*ALL`                        |

- コードマスタ (`CODEMSTRP`) と倉庫マスタ (`WAREHOUSEP`) は全グループが参照可能 (`*USE`)
- 変更履歴 (`CHANGELOGP`) は管理者のみ参照可能
- `*PUBLIC` への権限付与は行わない（最小権限の原則）

---

## 在庫管理の3数量モデル

`INVENTORYP` は3つの数量フィールドで在庫を管理します。

| フィールド | 意味           | 更新タイミング                         |
|----------|----------------|----------------------------------------|
| `QTYOH`  | 現在庫数       | 出荷確定時 (`CONFIRMSHP`) に減算       |
| `QTYALC` | 引当済数量     | 受注時 (`CREATESORD`) に加算、出荷時に減算 |
| `QTYAVL` | 引当可能数量   | 常に `QTYOH − QTYALC` として更新       |

**受注引当フロー**: `QTYAVL ≥ 発注数量` を確認 → `QTYALC` を加算 → `QTYAVL` を再計算  
**出荷確定フロー**: `QTYALC ≥ 出荷数量` を先に確認 → `QTYOH`・`QTYALC` を減算 → `QTYAVL` を再計算

---

## 受注ステータス遷移

```
ALLOCATED  →  SHIPPED  →  INVOICED
  (受注登録)    (出荷確定)   (請求発行)
```

明細レベルでは `PARTIAL`（一部出荷済）も存在します。

---

## 注意事項

- 各業務プログラム (`CREATESORD`/`CONFIRMSHP`/`CREATEINV`) は現時点でテストデータをソース内にハードコードしています。本番利用時はパラメータ渡しまたは画面連携に変更してください。
- ID採番はタイムスタンプ (`YYYYMMDD × 1000000 + HHMMSS`) ベースのため、同一秒内での重複には注意が必要です。
- ジャーナリングはコミット制御スコープ `*ACTGRP` で設定されています。
