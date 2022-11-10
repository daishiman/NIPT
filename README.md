# README <!-- omit in toc -->
- [開発環境構築手順](#開発環境構築手順)
  - [前提ツールのインストール](#前提ツールのインストール)
  - [git cloneする](#git-cloneする)
  - [.envファイルの追加](#envファイルの追加)
  - [コンテナ立ち上げ](#コンテナ立ち上げ)
  - [セットアップ](#セットアップ)
  - [A5:Mk-2でのDB接続情報](#a5mk-2でのdb接続情報)
  - [command memo](#command-memo)
  - [コンテナ構造](#コンテナ構造)
  - [Gitプロジェクト構造](#gitプロジェクト構造)
  - [サブモジュールを変更した際のコミットとプッシュについて](#サブモジュールを変更した際のコミットとプッシュについて)

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

# 開発環境構築手順

## 前提ツールのインストール

インストール済みの項目は適宜スキップしてください。

「プロジェクトの環境構築 : 前提」

基本的には [こちらのプロジェクト](https://mf-clspprt.backlog.com/git/BC_KRT/bc_krt/tree/develop)を参考に作成します。  
実施事項としては READMEに記載されている 下記の内容の構築をしてください。  
- Docker Desktop on Windows のインストール
- wsl2 のインストール
- git for windows のインストール
- backlog/git

「プロジェクトの環境構築 : 本プロジェクト」
構築すること
- [git clone](#git-clone)
- [コンテナ立ち上げ](#コンテナ立ち上げ)
- [セットアップ コマンド実行・動作確認](#セットアップ・動作確認)
- UX Teamとのgithub取り込み(必要に応じて)

## git cloneする

クローン場所

```
\\wsl$\Ubuntu-20.04\usr\src
```

コマンド

```
git clone --recursive mf-clspprt@mf-clspprt.git.backlog.com:/NIPT/nipt.git
```

※ "--recursive"をつけると、サブモジュールも一緒にクローンできる


## .envファイルの追加

[こちら](https://drive.google.com/drive/folders/1itTLI1XY-k4gNDeQ7sddsj91NfP7Gu00)から.env_for_localをダウンロードしてください。（nipt-admin,nipt-webのフォルダ内の.env_for_localもダウンロードする）

先程クローンしたniptフォルダ配下に.env_for_localを入れてください。
nipt-adminからダウンロードした.env_for_localファイルはnipt-adminフォルダ配下に設置してください。

.env_for_localの名前を.envに変更してください。
## コンテナ立ち上げ
nipt-admin, nipt-web配下の
.env.exampleを.envというファイル名に変更

```bash
cd nipt プロジェクトパス
docker-compose build
docker-compose up -d
```

## セットアップ

```shell
# PowerShell
bash setup.sh
```

ここまで終了したら、以下で表示可能。

```bash
患者様側: <http://localhost:8080/>
管理画面: <http://localhost:8181/>（現在使用していない）
```

## A5:Mk-2でのDB接続情報
[こちら](https://drive.google.com/drive/folders/12wf-V1eRQvKGp-xZSDjnKK9DmO-5vM_o)を参照してください。

## command memo

```bash
# コンテナへの接続 docker exec
# php
docker-compose exec webapp bash
# hostにservices名指定でdbに接続
psql -h postgres -U root -d postgres

# PostgreSQL
docker-compose exec postgres bash
psql -h postgres -U root -d postgres
```

```bash
#Laravel vite コンパイル実行 新規ファイルの認識,作成
docker-compose exec webapp sh -c 'cd /var/www/public/nipt && npm run build'
#Laravel vite コンパイル実行 rollupのwatch
docker-compose exec webapp sh -c 'cd /var/www/public/nipt && npm run dev'
```

```bash
#マイグレーション実行
docker compose exec webapp sh -c "cd /var/www/html && php artisan migrate:refresh --seed"
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

## サブモジュールを変更した際のコミットとプッシュについて

- 以下の設定をしないとコミットとプッシュができないっぽい

エラー内容：make sure you configure your "user.name" and "user.email" in git

```
git config --global user.name "ユーザー名"
git config --global user.email "メールアドレス"
```