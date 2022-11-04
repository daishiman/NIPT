# README <!-- omit in toc -->
- [開発環境構築手順](#開発環境構築手順)
  - [前提ツールのインストール](#前提ツールのインストール)
    - [プロジェクトの環境構築:前提](#プロジェクトの環境構築:前提)
    - [プロジェクトの環境構築:本プロジェクト](#プロジェクトの環境構築:本プロジェクト)

    - [Docker Desktop on Windows のインストール](#docker-desktop-on-windows-のインストール)
    - [wsl2 のインストール](#wsl2-のインストール)
    - [git for windows のインストール](#git-for-windows-のインストール)
    - [backlog/git](#backloggit)
    - [github](#github)
  - [プロジェクト作成](#プロジェクト作成)
    - [git cloneする](#git-cloneする)
    - [コンテナ立ち上げ](#コンテナ立ち上げ)
  - [command memo](#command-memo)
    - [hostsの設定](#hostsの設定)
- [コンテナ構造](#コンテナ構造)
- [Gitプロジェクト構造](#Gitプロジェクト構造)

## 開発環境構築手順

### 前提ツールのインストール

インストール済みの項目は適宜スキップしてください。

#### プロジェクトの環境構築:前提
基本的には [こちらのプロジェクト](https://mf-clspprt.backlog.com/git/BC_KRT/bc_krt/tree/develop)を参考に作成します。  
実施事項としては READMEに記載されている 下記の内容の構築をしてください。  
- Docker Desktop on Windows のインストール
- wsl2 のインストール
- git for windows のインストール
- backlog/git

#### プロジェクトの環境構築:本プロジェクト
[プロジェクトの環境構築:前提](#プロジェクトの環境構築:前提)を完了してからこちらの構築をしてください。

構築すること:
- [git clone](#git-clone)
- [コンテナ立ち上げ](#コンテナ立ち上げ)
- [セットアップ コマンド実行・動作確認](#セットアップ・動作確認)
- UX Teamとのgithub取り込み(必要に応じて)

#### git cloneする
```git
git clone mf-clspprt@mf-clspprt.git.backlog.com:/BC_KRT/bc_krt.git
```


#### コンテナ立ち上げ

```bash
cd プロジェクトパス
docker-compose build
docker-compose up -d
```

#### セットアップ・動作確認 
TODO：今後記載します。

.env.exampleを.envというファイル名にコピー  


```shell
# PowerShell
bash setup.sh
```

ここまで終了したら、以下で表示可能。

```bash
患者様側: <http://localhost:8080/>  
管理画面: <http://localhost:8181/>  
```


### command memo

```bash
# コンテナへの接続 docker exec
# php
docker-compose exec web bash
# hostにservices名指定でdbに接続
psql -h postgres -U root -d postgres

# PostgreSQL
docker-compose exec postgres bash
psql -h postgres -U root -d postgres
```

```bash
#Laravel vite コンパイル実行 新規ファイルの認識,作成
docker-compose exec web sh -c 'cd /var/www/public/bc_krt && npm run build'
#Laravel vite コンパイル実行 rollupのwatch
docker-compose exec web sh -c 'cd /var/www/public/bc_krt && npm run dev'
```

## コンテナ構造

```text
├── webapp (患者様側 WEB APP port:web)
├── adminapp (クリニック側 管理画面 WEB APP port:admin)
└── postgres
```

## Gitプロジェクト構造
```text
/nipt (ローカル開発環境構築用 docker git project)
├── nipt-web (患者様側 WEB APP git project)
└── nipt-admin (クリニック側管理画面 WEB APP git project)
```

### submod