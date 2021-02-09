<h1>BestMeal</h1>

<img src="https://user-images.githubusercontent.com/72218177/107189991-8efdc380-6a2d-11eb-9ce7-2c364e6a2b11.png" width="150px"> <img src="https://user-images.githubusercontent.com/72218177/107189995-91601d80-6a2d-11eb-9abb-517637a6fb1f.png" width="150px">
<img src="https://user-images.githubusercontent.com/72218177/107190004-93c27780-6a2d-11eb-8c94-30553fe657b7.png" width="150px">
<img src="https://user-images.githubusercontent.com/72218177/107190010-9624d180-6a2d-11eb-8775-6d5b34deddf1.png" width="150px">
<img src="https://user-images.githubusercontent.com/72218177/107190015-97ee9500-6a2d-11eb-91a6-9998347fa876.png" width="150px">



<h2>アプリ概要</h2>
「今日のランチはどうしよう？」「夜ふらっと飲みに行こうよ」なんて時に使える、飲食店検索アプリ。自分の位置情報を登録し、お店のキーワードを検索すれば、あなたにオススメのお店がカード状になって現れます。行ってみたい！と思ったら右にスワイプ、今度でいいや、、と思ったら左にスワイプ。右にスワイプしたお店たちだけがリストになり、あなただけのお気に入りリストが作れちゃう！リストから直接safariに飛び、詳細を見ることもできます）


<h4>開発環境<h4>
<br>・MacBook Pro Retina Late2013
<br>・MacOS Catalina (ver10.15.7)
<br>・Xcode (Version 12.4)

<h2>操作画面動画</h2>
<video src="107367956-4b858100-6b23-11eb-983f-fd06650fb163.mov"></video>

https://user-images.githubusercontent.com/72218177/107367956-4b858100-6b23-11eb-983f-fd06650fb163.mov
<h2>機能一覧</h2>
・新規登録画面（一度登録したらスキップ）
<br>・ユーザー現在地探知機能（近くの飲食店検索のため）
<br>・現在地から半径1km圏内の飲食店検索機能
<br>・APIで取得した飲食店情報をカード上に見やすく表示する機能
<br>・カードを好みに合わせて左右にスワイプできる機能
<br>・好みのお店をリスト化できる機能
<br>・リストから直接safariで詳細を閲覧できる機能

<h2>工夫点</h2>
<br>・「すぐに行ける」がコンセプトのため、現在地から歩ける範囲(1km圏内）の飲食店に限定し情報を取得できるようにした。
<br>・お店情報をカード状にしてスワイプできるようにすることで、直感的で遊びゴゴロのあるUI/UXをイメージし実装。
<br>・お気に入り店をリスト化でき、そのままsafariに飛ぶことで意思決定までを短時間にできるような実装。
<br>・検索ボタンを押すたびにリスト内容を全て削除することで、使い切り型のアプリケーションスタイルを実現。

<h2>改善点,気になっている点</h2>
<br>・限定された店名では検索できないため、「あそこにあるあのお店に行きたい！」という場面での検索には不向きである。
<br>・一度お気に入りと判断したお店をずっとアプリ内に記憶しておきたい場合には不向きである。

<h2>作成の背景</h2>
私には2年お付き合いしている彼女がおり、予期せず空いた時間にどこで食事をするかに悩むことが多々ありました。その際の会話の中で、「（お互いにiPhoneを使用しているため）機能性はそれほど多くなくていいから、歩いて行ける距離にあるお店をジャンル別ですぐに検索できる、操作の簡単なアプリがあればいいね」という話になりました。そこで私は、時間もあるしニーズもあるので作ってみようという思いから作成しました。（この前にも美容系のアプリを作成しており、それは彼女の個人的な悩みを解決するものでした。ここでは省きますが、その出来事がエンジニアになったきっかけです。）


