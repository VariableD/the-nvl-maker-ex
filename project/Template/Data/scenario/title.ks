;------------------------------------------------------------
;非常懶惰的標題畫面
;------------------------------------------------------------
*start
;對話框歸位
@position width=&"kag.scWidth" height=&"kag.scHeight"  left="0" page="fore" marginr="0" opacity="0" color="0xFFFFFF" marginl="0" margint="0" layer="message0" top="0" marginb="0"
;LOGO
@bg time="1000" storage=&"f.config_title.logo"
@fadeinbgm time="1000" storage=&"f.config_title.bgm"

@raininit cond="f.config_title.rain==true"
@snowinit cond="f.config_title.snow==true"
@sakurainit cond="f.config_title.sakura==true"
@momijiinit cond="f.config_title.momiji==true"
@oldmovieinit cond="f.config_title.movie==true"
@fireflyinit cond="f.config_title.firefly==true"

@wait canskip="1" time="500"
@bg time="1000" storage="black"

@backlay
;背景圖片
@image left="0" visible="true" page="back" layer="base" top="0" storage=&"f.config_title.bgd"
;前景圖片
@image left="0" page="back" cond="f.config_title.front!=void" visible="true" layer="8" top="0" storage=&"f.config_title.front"
@current layer="message0" page="back"
@button_title
@stoptrans
@trans time="500" method="crossfade"
@wt
@s
*刷新畫面
@current layer="message0" page="fore"
@er
@button_title
@s
;------------------------------------------------------------
*開始遊戲
@fadeoutbgm time="1000"
@rainuninit
@snowuninit
@sakurauninit
@momijiuninit
@oldmovieuninit
@fireflyuninit
@backlay
@freeimage layer="base" page="back"
@freeimage layer="8" page="back"
@current layer="message0" page="back"
@er
@trans time="200" method="crossfade"
@wt
@current layer="message0" page="fore"
@jump storage="prelogue.ks"
;------------------------------------------------------------
*讀取進度
@call storage="load.ks"
@jump target="*刷新畫面" storage="title.ks"
*特別模式
@call storage="cgmode.ks"
@jump target="*刷新畫面" storage="title.ks"
*系統設定
@call storage="option.ks"
@jump target="*刷新畫面" storage="title.ks"
*離開遊戲
@fadeoutbgm time="1500"
@backlay
@image layer="base" page="back" storage="black"
@freeimage layer=8 page="back"
@current layer="message0" page="back"
@er
@trans time="700" rule="00" method="crossfade"
@wt
@close ask="false"
*附加按鈕
@jump target="*刷新畫面" storage="title.ks"
