*start|スター
@bgm storage="BGM074.ogg"
@bg storage="BG04a"
@fg pos="center" storage="fg01_01"
@dia
@history output="true"
@nvl娘 face="face01_01"
THE NVL Makerの世界へようこそ～[w]
;----------
@history output="false"
@eval exp="f.姓='普'"
@eval exp="f.名='文二'"
@nowait
名前を教えてください：[r]
苗字：[edit name=f.姓][r]
名前：[edit name=f.名][r]
@links target="*输入完毕" text="確認" hint="つづき~"
@endnowait
@history output="true"
@s
;----------
*输入完毕
@commit
@er
@主角
よし，主人公の苗字は[emb exp=f.姓]，名前は[emb exp=f.名]です。[w]
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
次は選択のテストです。[lr]
;----------
@selstart
@selbutton target="*选择A" text="Aです"
@selbutton target="*选择B" text="Bです"
@selend
;----------
*选择A
@clsel
@bg clfg="1" storage="cg_01"
@addcg storage="cg_01"
@raininit
@npc id="路人甲"
選択したのはAです。CGモードでCG 1を表示できます。[w]
@rainuninit
@jump target="*合并"
;----------
*选择B
@clsel
@bg clfg="1" storage="cg_02"
@addcg storage="cg_02"
@npc id="路人甲"
選択したのはBです。CGモードでCG 2を表示できます。[w]
;----------
*合并
@hidemes
@backlay
@image visible="1" page="back" layer="base" storage="BG01a"
@image visible="1" page="back" layer="0" pos="center" storage="fg01_02"
@trans time="800" rule="rule_27" method="universal"
@wt
@showmes
@nvl娘
選択はこれで終わりです。[w]
@nvl娘
ボイスのテストです。[lr]
@vo storage="Konnichiha01@22"
こんにちはだにゃん。（履歴で再生できる）[w]
@scr
セリフ枠のスタイルを変更しました……[lr]
文字色も変更できます。[l][font color=0x3366FF]例えば、これ……[resetfont][lr][r]
サイズ[font size=30]大[font size=18]小[resetfont]の設定。[w]
@style align="center"
センタリング。[lr]
@resetstyle
@nowait
文字表示ノーウェイト。[lr]
@endnowait
@locate y="200" x="300"
文字表示位置の指定。[w]
インライン画像[graph char=false storage=momiji_0]表示。[w]
@dia
@nvl娘
再びセリフ枠を変更しました……[lr]
地図のテストです。[w]
@map storage="sample.map"
*map01
@clmap
@nvl娘
テスト終了……[lr]タイトル画面に戻ります。[w]
@gotostart
