;------------------------------------------------------------
;主菜單
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]
;------------------------------------------------------------
*window
;載入配置文件
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="main_menu.ks" target=*返回]

[backlay]
[image layer=14 page=back storage=&"f.config_menu.bgd" left=0 top=0 visible="true"]

;無效化系統按鈕層
[hidesysbutton page=back]

;用message4描繪
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;這裡顯示按鈕
[if exp="f.config_menu.save.use==true"]
[locate x=&"f.config_menu.save.x" y=&"f.config_menu.save.y"]
[mybutton dicname="f.config_menu.save" target=*保存遊戲]
[endif]
[if exp="f.config_menu.load.use==true"]
[locate x=&"f.config_menu.load.x" y=&"f.config_menu.load.y"]
[mybutton dicname="f.config_menu.load" target=*讀取進度]
[endif]
[if exp="f.config_menu.option.use==true"]
[locate x=&"f.config_menu.option.x" y=&"f.config_menu.option.y"]
[mybutton dicname="f.config_menu.option" target=*系統設定]
[endif]
[if exp="f.config_menu.history.use==true"]
[locate x=&"f.config_menu.history.x" y=&"f.config_menu.history.y"]
[mybutton dicname="f.config_menu.history" exp="kag.onShowHistoryMenuItemClick()"]
[endif]
[if exp="f.config_menu.other.use==true"]
[locate x=&"f.config_menu.other.x" y=&"f.config_menu.other.y"]
[mybutton dicname="f.config_menu.other" target=*自定義選單]
[endif]
[if exp="f.config_menu.exit.use==true"]
[locate x=&"f.config_menu.exit.x" y=&"f.config_menu.exit.y"]
[mybutton dicname="f.config_menu.exit" exp="kag.close()"]
[endif]
[if exp="f.config_menu.totitle.use==true"]
[locate x=&"f.config_menu.totitle.x" y=&"f.config_menu.totitle.y"]
[mybutton dicname="f.config_menu.totitle" exp="kag.goToStartWithAsk()"]
[endif]

;返回按鈕
[if exp="f.config_menu.back.use==true"]
[locate x=&"f.config_menu.back.x" y=&"f.config_menu.back.y"]
[mybutton dicname="f.config_menu.back" target=*返回]
[endif]

[trans method="crossfade" time=200]
[wt]

[s]

;都是跳轉到window標籤

*保存遊戲
[jump storage="save.ks" target=*window]

*讀取進度
[jump storage="load.ks" target=*window]

*系統設定
[jump storage="option.ks" target=*window]

*自定義選單
[jump storage="other.ks" target=*window]

;------------------------------------------------------------
*返回
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]
[unlocksnapshot]
[return]
