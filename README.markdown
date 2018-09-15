ISUCON 2018 ホッシャニスト
==========

## ローカルホスト上での実行 (Docker 利用)

```
docker-compose up -d db # 初期化に時間がかかるので先に DB 起動しておく。
# しばらく待つ。

docker-compose up
```

起動したら、http://localhost/ で表示できるはず。

### アプリケーションを変更したら

アプリケーションのコードを変更したら、Docker イメージのビルドが必要なので、下記コマンドでビルド。

```
docker-compose build

# もしくは下記コマンドで、ビルドした後起動ということも可能。
# docker-compose up --build
```
