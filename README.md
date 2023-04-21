# create-certについて

SSL/TLSのサーバ証明書、および関連ファイルを作成するツールです。<br>
Dockerコンテナで作成プロセスが動き、以下のファイルを生成します。

* サーバ証明書
    * 自己証明書、または自作CA局を利用して発行したもの
        * CA局を利用するかどうかは環境変数 ``USE_CA`` で指定可能（デフォルト``false``）
    * 出力ファイル名は``server.pem``
* 証明書署名要求(CSR)
    * サーバ証明書発行時に利用
    * 出力ファイル名は``server.csr``
* 秘密鍵
    * サーバ証明書、およびCSR作成時に利用
    * 出力ファイル名は``privatekey.pem``
* 秘密鍵のパスワード
    * ``pswd``という名前のファイルにパスワードを保存

# 前提条件

* 動作確認OSはLinuxのみ
* Dockerがインストールされている必要があります

# 作成手順

## 証明書作成用のDockerイメージ作成

```
docker build --force-rm=true -t create-cert .
```

## 環境変数ファイルの用意

証明書作成で設定するパラメータは環境変数で指定します。指定する環境変数が多いため、
予めファイルに環境変数と値を記載してコンテナ起動時に引数で渡すことをお勧めします。
サンプルファイルは ``.env.sample`` という名前で格納しており、以下の手順でコピーして環境変数ファイルの作成が可能です。

```
cp .env.sample .env
vi .env
(.envを編集)
```

※環境変数を指定しない場合は ``ansible/inventory.yaml``に記載された値が設定されます。

## 証明書の作成

### 証明書格納用のディレクトリの用意

```
mkdir /path/to/output
```

### Dockerコンテナの起動

以下のコマンドでDockerコンテナを起動し証明書を作成します

```
docker run --rm \
-v /path/to/output:/volume \
--env-file .env \
create-cert
```

### 作成されたファイルの確認

```
$ ls /path/to/output/ssl/
privatekey.pem  pswd  server.csr  server.pem
```

``openssl``でサーバ証明書の中身を確認する例

```
openssl x509 -text -noout -in /path/to/output/ssl/server.pem
```

# License
"ceph-osd-restarter" is under [GPL license](https://www.gnu.org/licenses/licenses.en.html).
 
