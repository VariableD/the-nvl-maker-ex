*start|序章
@bgm storage="BGM074.ogg"
@bg storage="BG04a"
@fg pos="center" storage="fg01_01"
@dia
@history output="true"
@nvl娘 face="face01_01"
歡迎來到THE NVL Maker的世界～[w]
;----------
@history output="false"
@eval exp="f.姓='普'"
@eval exp="f.名='文二'"
@nowait
請輸入主角名字：[r]
姓氏：[edit name=f.姓][r]
名字：[edit name=f.名][r]
@links target="*輸入完畢" text="確定" hint="點這裡繼續~"
@endnowait
@history output="true"
@s
;----------
*輸入完畢
@commit
@er
@主角
好的，主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
接下來，測試一下選擇吧。[lr]
;----------
@selstart
@selbutton target="*選擇A" text="我要選擇A"
@selbutton target="*選擇B" text="我要選擇B"
@selend
;----------
*選擇A
@clsel
@bg clfg="1" storage="cg_01"
@addcg storage="cg_01"
@raininit
@npc id="路人甲"
你選擇了A。第一張CG現在可以在特別模式裡查看了。[w]
@rainuninit
@jump target="*合併"
;----------
*選擇B
@clsel
@bg clfg="1" storage="cg_02"
@addcg storage="cg_02"
@npc id="路人甲"
你選擇了B。第二張CG現在可以在特別模式裡查看了。[w]
;----------
*合併
@hidemes
@backlay
@image visible="1" page="back" layer="base" storage="BG01a"
@image visible="1" page="back" layer="0" pos="center" storage="fg01_02"
@trans time="800" rule="rule_27" method="universal"
@wt
@showmes
@nvl娘
@vo storage="Konnichiha01@22"
不管選擇了A還是B，最後你都會看到這句話。[w]
@scr
試試另外一個樣式的對話框……[lr]
你也可以切換文字的顏色。[l][font color=0x3366FF]比如這樣……[resetfont][lr][r]
改變[font size=30]大[font size=18]小[resetfont]也沒有問題喲。[w]
@style align="center"
居中顯示文字。[lr]
@resetstyle
@nowait
瞬間顯示文字。[lr]
@endnowait
@locate y="200" x="300"
在指定位置顯示文字。[w]
在對話中[graph char=false storage=momiji_0]顯示圖片。[w]
@dia
@nvl娘
現在換回來了……[lr]
測試一下地圖選擇吧。[w]
@map storage="sample.map"
*map01
@clmap
@nvl娘
地圖測試完畢……[lr]準備好就自動返回標題了哦。[w]
@gotostart
