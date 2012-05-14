;------------------------------------------------------------
;請不要隨意編輯
;------------------------------------------------------------
[linemode mode=none]
[startanchor]
[stoptrans]
[clearvar]
;------------------------------------------------------------
;初始化（設定默認值）
;------------------------------------------------------------
[if exp="sf.初始化==false"]
[eval exp="kag.allskip=false"]
[eval exp="kag.fullScreen=false"]
[eval exp="sf.歷史=[]"]
[eval exp="sf.最近存儲頁=1"]
[eval exp="sf.初始化=true"]
[endif]
;------------------------------------------------------------
;載入宏
;------------------------------------------------------------
[call storage="macro.ks"]
;------------------------------------------------------------
;右鍵菜單及系統按鈕層的默認設定
;------------------------------------------------------------
[rclick enabled="false" call="true" storage="rclick.ks" target=*隱藏對話框]
[history enabled="false" output="false"]
[system_menu]
;------------------------------------------------------------
;字體設定
;------------------------------------------------------------
;載入配置文件
[eval exp="f.setting=Scripts.evalStorage('setting.tjs')"]

;以防萬一的強制字體設定
[current layer=message0 page=fore]
[resetfont]
;預渲染字體設定
[mappfont storage=&"global.configMappfont" cond="(global.useconfigMappfont) && (global.configMappfont!=void)"]

;選項按鈕設定
[selopt left=&f.setting.selbutton.left top=&f.setting.selbutton.top width=&f.setting.selbutton.width height=&f.setting.selbutton.height face=&"kag.scflags.chDefaultFace" bold=&"kag.fore.messages[0].defaultBold" size=&f.setting.selfont.height normal=&f.setting.selbutton.normal over=&f.setting.selbutton.over on=&f.setting.selbutton.on color=&f.setting.selfont.normal  overcolor=&f.setting.selfont.over oncolor=&f.setting.selfont.on selectedcolor=&f.setting.selfont.read edge=&"kag.fore.messages[0].defaultEdge" edgecolor=&"kag.fore.messages[0].defaultEdgeColor" shadow=&"kag.fore.messages[0].defaultShadow" shadowcolor=&"kag.fore.messages[0].defaultShadowColor" enterse=&f.setting.selbutton.enterse clickse=&f.setting.selbutton.clickse]

;------------------------------------------------------------
;跳躍到測試處理畫面
;------------------------------------------------------------
[jump storage="start.ks"]
