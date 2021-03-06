;-------------------------------------------------------------------------------------------
;封装的宏,对应于指令编辑器
;-------------------------------------------------------------------------------------------
*start

;-------------------------------------------------------------------------------------------
;截图功能
;-------------------------------------------------------------------------------------------
[iscript]
function savenote(name)
{
	//设定保存路径
	var fn = System.exePath + "/ScreenShot/" + name;
	//新建一层
	var tmp = new Layer(kag, kag.fore.base);
	tmp.setImageSize(f.setting.width, f.setting.height);
	//用新建层取得当前画面
	tmp.piledCopy(0, 0, kag.fore.base, 0, 0, f.setting.width, f.setting.height);
	//将当前画面保存为BMP
	tmp.saveLayerImage(fn + ".bmp", "bmp");
	dm("保存截图为"+name+".bmp");
}

//获得日期时间字符串
function getDateString()
{
	var time=new Date();
	
	var str="nvl";
	var year=time.getYear();
	var month=time.getMonth()+1;
	var day=time.getDate();
	
	if (month<10) month="0"+(string)month;
	if (day<10) day="0"+(string)day;
	
	var hour=time.getHours();
	var minute=time.getMinutes();
	var second=time.getSeconds();
	
	if (hour<10) hour="0"+(string)hour;
	if (minute<10) minute="0"+(string)minute;
	if (second<10) second="0"+(string)second;
	
	//最后结果
	str+=(string)year+(string)month+(string)day+"_";
	str+=(string)hour+(string)minute+(string)second;
	return str;
}

function ScreenShot(key, shift)
{	
  dm("按键编号"+key);
  
  //106为小键盘星号截图键
  if (key != 106)
    return false;

	//保存图片
	var str=getDateString();
	savenote(str);
}
// キー押下時のハンドラを登録
kag.keyDownHook.add(ScreenShot);
[endscript]
;-------------------------------------------------------------------------------------------
;历史记录用的人名显示效果
;-------------------------------------------------------------------------------------------
[iscript]
//需要修改MyHistoryLayer里的historyColor
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
         var name=text.substring(1,text.length-2);
         var arr=f.config_name;
         
         //为主角
         if (name==f.姓+f.名) return arr[0].color;
         //否则
         //有颜色记录,使用颜色
           for (var i=2;i<arr.count;i++)
          {
             if (arr[i].name==name) return arr[i].color;
           }
           
         //无颜色记录,使用路人颜色
         return arr[1].color;
       }
       return kag.fore.messages[0].defaultChColor;
}
[endscript]
;-------------------------------------------------------------------------------------------
;人名显示基础
;-------------------------------------------------------------------------------------------
;★npc
[macro name=npc]

[nowait]
[layopt layer="message0" visible="true"]
[current layer="message0"]
[er]

;修改姓名显示相对位置的地方（去掉下面这行的;，就可以用了，坐标可以为负值）
;[locate x=-50 y=-50]

;使用默认的颜色值
[font color=&"f.config_name[1].color"]
;使用强制设定的值
[font color=%color cond="mp.color!=void"]

;非主角
[if exp="mp.id!='主角'"]
【[emb exp="mp.id"]】
[endif]

;为主角，没姓名时不显示
[if exp="mp.id=='主角'"]
[ch text="【" cond="f.姓!=void || f.名!=void"]
[emb exp="f.姓"][emb exp="f.名"]
[ch text="】" cond="f.姓!=void || f.名!=void"]
[endif]
[resetfont]
[r]
[endnowait]

;附加显示
[backlay]
;头像
[if exp="mp.face!=void"]
[image layer=8 page="back" storage=%face visible="true"]
;left/top位置自己改吧我不管了，可以用数字，这里是设成底边中点自动对齐
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
[endif]
;立绘
[if exp="mp.fg!=void"]
;在原位置显示图片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method="crossfade" time=100]
[wt]

[endmacro]
;------------------------------------------------------------------
;准备选项
;------------------------------------------------------------------
[macro name=selstart]
[hr]
[backlay]
;隐藏对话层、消除头像
[if exp="mp.hidemes"]
[rclick enabled="false"]
[layopt layer="message0" visible="false" page=back]
[freeimage layer="8" page=back]
[endif]
;隐藏按钮层
[if exp="mp.hidesysbutton"]
[rclick enabled="false"]
[layopt layer="message2" visible="false" page=back]
[endif]
;显示选项层
[position layer="message1" visible="true" frame="empty" left=0 top=0 marginb=0 marginl=0 marginr=0 margint=0 page=back]
[current layer="message1" page=back]
[nowait]
[endmacro]
;------------------------------------------------------------------
;按钮选项
;------------------------------------------------------------------
[iscript]
//描绘按钮文字用函数
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默认文字样式设定
	button.font.face = kag.scflags.chDefaultFace;
	button.font.bold = kag.fore.messages[0].defaultBold;
	button.font.height = f.setting.selfont.height;
	
	//sel颜色设定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

	//将文字对应成预渲染文字
	if ((global.useconfigMappfont) && (f.setting.mapp_sel!=void))
	{
	  button.font.mapPrerenderedFont(f.setting.mapp_sel);
	}

	var w = button.font.getTextWidth(caption); // 取得要描绘文字的宽度
	var x = (button.width - w) \ 2;    // 在按钮中央显示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按钮上的y位置（左上角起算）

	//取得既读设定
	var target_name=target.substring(1,target.length-1);
	var checklabel="sf.trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var sel_color;

	// 既读文字颜色设定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	if (kag.fore.messages[0].defaultEdge) //默认设置带有描边
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (kag.fore.messages[0].defaultShadow)//默认设置带有阴影
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, shadowcolor, 0, 2, 2);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, shadowcolor, 0, 2, 2);
	}
	else //无任何效果
	{
		// 按钮「通常状態」部分文字显示
		button.drawText(x,y, caption, sel_color, 255, true);
		// 按钮「按下状態」部分文字显示
		button.drawText(x+button.width, y, caption, on ,255, true);
		// 按钮「选中状態」部分文字显示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true);
	}

}
[endscript]

[macro name=selbutton]
;假如没有填写选择条,使用默认选择条
[eval exp="mp.normal=f.setting.selbutton.normal" cond="mp.normal==void"]
[eval exp="mp.over=f.setting.selbutton.over" cond="mp.over==void"]
[eval exp="mp.on=f.setting.selbutton.on" cond="mp.on==void"]
[eval exp="mp.enterse=f.setting.selbutton.enterse" cond="mp.enterse==void"]
[eval exp="mp.clickse=f.setting.selbutton.clickse" cond="mp.clickse==void"]

;假如没有填写剧本，则读取当前执行中的剧本名
[if exp="mp.storage==void"]
[eval exp="mp.storage=Storages.extractStorageName(kag.conductor.curStorage)"]
[endif]

;显示按钮（根据有无音效切换）
[if exp="mp.enterse!=void && mp.clickse!=void"]
[button enterse=%enterse clickse=%clickse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[elsif exp="mp.enterse!=void"]
[button enterse=%enterse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[elsif exp="mp.clickse!=void"]
[button clickse=%clickse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[else]
[button storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[endif]

;描绘选项文字
[eval exp="drawSelButton(mp.text,mp.storage,mp.target)"]

[endmacro]
;------------------------------------------------------------------
;等待选择-选项
;------------------------------------------------------------------
[iscript]
//让所有按钮自动居中对齐的效果
function Arrange_SelButton(num)
{
	var x=f.setting.selbutton.left;
	var y=f.setting.selbutton.top;
	var width=f.setting.selbutton.width;
	var height=f.setting.selbutton.height;
	
	var per_height=f.setting.selbutton.height/(num+1);

	for (var i=0;i<num;i++)
	{
		kag.current.links[i].object.left=x+(width-kag.current.links[i].object.width)/2;
		kag.current.links[i].object.top=(int)y+(int)per_height*(i+1);
		
		dm("选项按钮"+(i+1));
		dm("x="+kag.current.links[i].object.left);
		dm("y="+kag.current.links[i].object.top);
	}

}
[endscript]
[macro name=selend]
[endnowait]
;假如是限时选项，强制将系统菜单无效化
[if exp="mp.timeout"]
[history enabled="false"]
[rclick enabled="false"]
[layopt layer="message2" visible="false" page=back]
[endif]
;按钮排列处理
[eval exp="Arrange_SelButton(kag.current.links.count)"]
[trans method=%method|crossfade time=%time|300 rule=%rule|1 from=%from stay=%stay]
[wt canskip=%canskip]
;限时选项处理
[if exp="mp.timeout"]
[timeout time=%outtime storage=%storage target=%target]
[endif]
[if exp="mp.timebar"]
[timebar bar=%bar x=%x y=%y time=%outtime width=%width bgimage=%bgimage bgx=%bgx bgy=%bgy]
[endif]
[s]
[endmacro]
;------------------------------------------------------------------
;★清理选项
;------------------------------------------------------------------
[macro name=clsel]
[deltimebar]
[rclick enabled="true" call="true" jump="false" storage="rclick.ks" target="*隐藏对话框"]
[history enabled="true"]
[backlay]
[layopt layer="message1" visible="false" page="back"]

;恢复对话框与系统按钮
[layopt layer="message0" visible="true" page=back]
[layopt layer="message2" visible="true" page="back"]
[trans method=%method|crossfade time=%time|100 rule=%rule|1 from=%from stay=%stay]
[wt canskip=%canskip]
;返回对话
[current layer="message0"]
[endmacro]
;------------------------------------------------------------------
;文字连接
;------------------------------------------------------------------
[macro name=links]
[link *][ch text=%text][endlink]
[endmacro]
;-------------------------------------------------------------------------------------------
;播放视频
;-------------------------------------------------------------------------------------------
[macro name=playmv]
[video width="1024" left="0" visible="true" height="768" top="0"]
[playvideo storage=%storage]
[wv canskip=%canskip|true]
[endmacro]
;-------------------------------------------------------------------------------------------
;播放语音
;-------------------------------------------------------------------------------------------
[iscript]
//简单的播放语音函数
function playse(file,buf=1,isloop=false)
{
	kag.tagHandlers.playse(%[
	"storage"=>file,
	"buff"=>buf,
	"loop"=>isloop
	]);
}
[endscript]

[macro name=vo]
[eval exp="f.voing=true"]
[playse storage=%storage buf="1" loop="false"]
[hact exp=&("playse("+"\""+mp.storage+"\""+")")]
[endmacro]

[macro name=endvo]
[if exp="f.voing==true"]
[eval exp="f.voing=false"]
[endhact]
[ws buf="1"]
[endif]
[endmacro]
;------------------------------------------------------------------
;★等待
;------------------------------------------------------------------
[macro name=lr]
[endvo]
[l][r]
[endmacro]

[macro name=w]
[endvo]
[p]
[freeimage layer=8 page=fore]
[cm]
[endmacro]
;------------------------------------------------------------------
;★普通对话框(含头像)
;------------------------------------------------------------------
[macro name=dia]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.dia.frame" left=&"f.config_dia.dia.left" top=&"f.config_dia.dia.top" marginl=&"f.config_dia.dia.marginl" marginr=&"f.config_dia.dia.marginr" margint=&"f.config_dia.dia.margint" marginb=&"f.config_dia.dia.marginb"]
[layopt layer="message2" visible="true" page="back"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------------
;★全屏对话框(不含头像)
;------------------------------------------------------------------
[macro name=scr]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.scr.frame" left=&"f.config_dia.scr.left" top=&"f.config_dia.scr.top" marginl=&"f.config_dia.scr.marginl" marginr=&"f.config_dia.scr.marginr" margint=&"f.config_dia.scr.margint" marginb=&"f.config_dia.scr.marginb"]
[layopt layer="message2" visible="true" page="back"]
;有效化系统按钮层
[eval exp="kag.back.messages[2].enabled=true"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------------
;★透明全屏对话框
;------------------------------------------------------------------
[macro name=menu]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame="empty" left=0 top=0 marginl=&"f.config_dia.blank.marginl" marginr=&"f.config_dia.blank.marginr" margint=&"f.config_dia.blank.margint" marginb=&"f.config_dia.blank.marginb"]
[layopt layer="message2" visible="false" page="back"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[endmacro]
;------------------------------------------------------------
;★隐藏对话框
;------------------------------------------------------------
[macro name=hidemes]
[backlay]
;隐藏对话框
[layopt layer="message0" page="back" visible="false"]
;隐藏系统按钮
[layopt layer="message2" page="back" visible="false"]
;隐藏头像
[layopt layer=8 page="back" visible="false"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;------------------------------------------------------------
;★显示对话框
;------------------------------------------------------------
[macro name=showmes]
[backlay]
;隐藏对话框
[layopt layer="message0" page="back" visible="true"]
;隐藏系统按钮
[layopt layer="message2" page="back" visible="true"]
;隐藏头像
[layopt layer=8 page="back" visible="true" cond="kag.back.layers[8].width>32"]
[trans method="crossfade" time=100]
[wt]
[current layer=message0 page=back]
[er]
[current layer=message0 page=fore]
[endmacro]
;------------------------------------------------------------------
;★显示背景
;------------------------------------------------------------------
[macro name=bg]
[backlay]
;一般效果
[image layer=base storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity]
;反色效果
[if exp="mp.convert==true"]
[image layer=base storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity rceil=0 gceil=0 bceil=0 rfloor=255 bfloor=255 gfloor=255]
[endif]

;消除立绘
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]

;消除对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除背景
;------------------------------------------------------------------
[macro name=clbg]
[backlay]
[freeimage layer=base page="back"]
;连同全部前景
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]

;连同对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★显示人物
;------------------------------------------------------------------
[macro name=fg]
[backlay]
;第一次显示,指定角色位置
[if exp="mp.pos!=''"]
[image * storage=%storage|empty layer=%layer|0 page="back" pos=%pos visible="true"]
[else]
;不指定时,自动调整,使立绘显示在原位置/指定位置
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left" cond="mp.left==void"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top" cond="mp.top==void"]
[image * storage=%storage layer=%layer page="back" left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|500 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除人物
;------------------------------------------------------------------
[macro name=clfg]
[backlay]
;消除全部
[if exp="mp.layer=='all'"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]
;消除单层
[if exp="mp.layer!='all'"]
[freeimage layer=%layer page="back"]
[endif]
;消除头像
[if exp="mp.clface==true"]
[freeimage layer=8 page="back"]
[endif]
;连同对话框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]
[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★显示头像
;------------------------------------------------------------------
[macro name=face]
[backlay]
[image * layer=8 visible="true" page="back" storage=%storage|empty]
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
;附加显示立绘
[if exp="mp.fg!=void"]
;在原位置显示图片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|100 rule=%rule|1]
[wt]
[endmacro]
;------------------------------------------------------------------
;★消除头像
;------------------------------------------------------------------
[macro name=clface]
[backlay]
[freeimage layer=8 page="back"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;------------------------------------------------------------
;★播放音乐
;------------------------------------------------------------
[macro name=bgm]
[xchgbgm * storage=%storage overlap=%overlap|500 time=%time|1000]
[endmacro]
;------------------------------------------------------------
;★播放音效
;------------------------------------------------------------
[macro name=se]
[if exp="mp.time==void"]
[playse storage=%storage loop=%loop|false buf=%buf|0]
[else]
[fadeinse storage=%storage loop=%loop|false buf=%buf|0 time=%time|0]
[endif]
[endmacro]
;-------------------------------------------------------------------------------------------
;★移动基础
;-------------------------------------------------------------------------------------------
[macro name=movepos]
[eval exp="tf.layer=0"]
[eval exp="tf.layer=mp.layer" cond="mp.layer!=''"]
[eval exp="tf.left=kag.fore.layers[tf.layer].left"]
[eval exp="tf.top=kag.fore.layers[tf.layer].top"]
[eval exp="tf.oop=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=0"]
[eval exp="tf.y=0"]
[eval exp="tf.opacity=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=mp.x" cond="mp.x!=''"]
[eval exp="tf.y=mp.y" cond="mp.y!=''"]
[eval exp="tf.opacity=mp.opacity" cond="mp.opacity!=''"]
[eval exp="tf.x2=tf.left*1+mp.x*1"]
[eval exp="tf.y2=tf.top*1+mp.y*1"]
[eval exp="tf.path='('+&tf.x2+','+&tf.y2+','+&tf.opacity+')'"]
[move layer=%layer|0 path="&tf.path" time=%time|100 accel=%accel]
[wm canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
;★背景摇晃
;-------------------------------------------------------------------------------------------
[macro name=shake]
[action layer=base module=LayerWaveActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='wave'"]
[action layer=base module=LayerJumpActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='jump'"]
[wact canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
[return]
