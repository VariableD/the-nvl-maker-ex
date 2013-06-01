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
[iscript]
if (sf.初始化==false)
{
	//option初始化
	kag.allskip=false;//SKIP时只允许略过已读部分
	
	kag.bgmvolume=50;//背景音乐音量
	kag.sevolume=50;//总音效音量

	kag.textspeed=5;//文字速度
	kag.autospeed=5;//自动前进速度
	
	//系统变数初始化
	sf.cglist=%[];
	sf.历史=[];
	sf.最近存储页=1;

	sf.初始化=true;
}
[endscript]

[iscript]
if (sf.语音初始化==false)
{
	//初始化语音全局变数

	kag.sevolume=100; //重置总音效音量到最大

	//系统设置里使用到的中间值
	sf.sevolume=50;
	sf.voicevolume=50;
	sf.语音初始化=true;
}

//使音量值与中间值相同
kag.se[0].volume=sf.sevolume;
kag.se[1].volume=sf.voicevolume;
[endscript]
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
