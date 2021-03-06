;------------------------------------------------------------
;请不要随意编辑
;------------------------------------------------------------
[linemode mode=none]
[startanchor]
[stoptrans]
[clearvar]
;------------------------------------------------------------
;初始化（设定默认值）
;------------------------------------------------------------
[if exp="sf.初始化==false"]
[eval exp="kag.allskip=false"]
[eval exp="kag.fullScreen=false"]
[eval exp="sf.历史=[]"]
[eval exp="sf.最近存储页=1"]
[eval exp="sf.初始化=true"]
[endif]
;------------------------------------------------------------
;载入宏
;------------------------------------------------------------
[call storage="macro.ks"]
;------------------------------------------------------------
;右键菜单及系统按钮层的默认设定
;------------------------------------------------------------
[rclick enabled="false" call="true" storage="rclick.ks" target=*隐藏对话框]
[history enabled="false" output="false"]
[system_menu]
;------------------------------------------------------------
;字体设定
;------------------------------------------------------------
;载入配置文件
[eval exp="f.setting=Scripts.evalStorage('setting.tjs')"]

;以防万一的强制字体设定
[current layer=message0 page=fore]
[resetfont]
;预渲染字体设定
[mappfont storage=&"global.configMappfont" cond="(global.useconfigMappfont) && (global.configMappfont!=void)"]

;选项按钮设定
[selopt left=&f.setting.selbutton.left top=&f.setting.selbutton.top width=&f.setting.selbutton.width height=&f.setting.selbutton.height face=&"kag.scflags.chDefaultFace" bold=&"kag.fore.messages[0].defaultBold" size=&f.setting.selfont.height normal=&f.setting.selbutton.normal over=&f.setting.selbutton.over on=&f.setting.selbutton.on color=&f.setting.selfont.normal  overcolor=&f.setting.selfont.over oncolor=&f.setting.selfont.on selectedcolor=&f.setting.selfont.read edge=&"kag.fore.messages[0].defaultEdge" edgecolor=&"kag.fore.messages[0].defaultEdgeColor" shadow=&"kag.fore.messages[0].defaultShadow" shadowcolor=&"kag.fore.messages[0].defaultShadowColor" enterse=&f.setting.selbutton.enterse clickse=&f.setting.selbutton.clickse]

;------------------------------------------------------------
;跳跃到测试处理画面
;------------------------------------------------------------
[jump storage="start.ks"]
