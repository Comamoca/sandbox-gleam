# ex_gleam_with_flake

Nixを使ってGitリポジトリをGleamパッケージとして扱うたサンプル。

nvfetcherでGitリポジトリを定義して、生成されたNix式をflake.nixで読み込みそのsrcをlinkするコマンドをshellHookに書き込むことで機能する。

まだまだ課題はあれど、Gleamが抱えるパッケージエコシステムの問題を解決するヒントになるかもしれない。

合わせて[メモ書き](./memo.org)も見ると良いかもしれない。
