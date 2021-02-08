<h1>BestMeal</h1>

写真
<img src="https://user-images.githubusercontent.com/72218177/107169228-b722fd80-6a00-11eb-80ab-458e7de6b661.jpg" width="320px">



・写真
・アプリ概要
「今日のランチはどうしよう？」「夜ふらっと飲みに行こうよ」なんて時に使える、飲食店検索アプリ。自分の位置情報を登録し、お店のキーワードを検索すれば、あなたにオススメのお店がカード状になって現れます。行ってみたい！と思ったら右にスワイプ、今度でいいや、、と思ったら左にスワイプ。右にスワイプしたお店たちだけがリストになり、あなただけのお気に入りリストが作れちゃう！リストから直接safariに飛び、詳細を見ることもできます）

・開発環境（MAc,xcode)
・MacBook Pro Retina Late2013
・MacOS Catalina (ver10.15.7)
・Xcode (Version 12.4)

<h3>操作画面動画</h3>

<h1>機能一覧</h1>
・新規登録画面（一度登録したらスキップ）
・ユーザー現在地探知機能（近くの飲食店検索のため）
・現在地から半径1km圏内の飲食店検索機能
・APIで取得した飲食店情報をカード上に見やすく表示する機能
・カードを好みに合わせて左右にスワイプできる機能
・好みのお店をリスト化できる機能
・リストから直接safariで詳細を閲覧できる機能

<h1>工夫点</h1>
・「すぐに行ける」がコンセプトのため、現在地から歩ける範囲(1km圏内）の飲食店に限定し情報を取得できるようにした。
・お店情報をカード状にしてスワイプできるようにすることで、直感的で遊びゴゴロのあるUI/UXをイメージし実装。
・お気に入り店をリスト化でき、そのままsafariに飛ぶことで意思決定までを短時間にできるような実装。
・検索ボタンを押すたびにリスト内容を全て削除することで、使い切り型のアプリケーションスタイルを実現。

<h1>改善点,気になっている点</h1>
・限定された店名では検索できないため、「あそこにあるあのお店に行きたい！」という場面での検索には不向きである。
・一度お気に入りと判断したお店をずっとアプリ内に記憶しておきたい場合には不向きである。

<h1>作成の背景</h1>
私には2年お付き合いしている彼女がおり、予期せず空いた時間にどこで食事をするかに悩むことが多々ありました。その際の会話の中で、「（お互いにiPhoneを使用しているため）機能性はそれほど多くなくていいから、歩いて行ける距離にあるお店をジャンル別ですぐに検索できる、操作の簡単なアプリがあればいいね」という話になりました。そこで私は、時間もあるしニーズもあるので作ってみようという思いから作成しました。（この前にも美容系のアプリを作成しており、それは彼女の個人的な悩みを解決するものでした。ここでは省きますが、その出来事がエンジニアになったきっかけです。）



使用ライブラリ一覧
Lottie/VerticalCardSwiper/SwiftyJSON/ChameleonFramework/FirebaseFirestore/FirebaseAuth/FirebaseDatabase/MapKit/SDWebImage/
