;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;存取版面设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="存取版面设定"]
[iscript]

//以存储版面为例
f.config_sl=f.config_save;
f.存储=true;
f.读取=false;

//创建固定的层
f.uilayer=[];
//简单按钮
f.uilayer[0]=new uiSLLayer(f.config_sl.up,f.config_slpos.up);
f.uilayer[1]=new uiSLLayer(f.config_sl.down,f.config_slpos.down);
f.uilayer[2]=new uiSLLayer(f.config_sl.back,f.config_slpos.back);
//悬停效果
//截图
f.uilayer[3]=new uiSnapLayer(f.config_slpos.snapshot);
//章节
f.uilayer[4]=new uiTextLayer("第一章 見出し",f.config_slpos.drawmark,f.config_sl.draw.bookmark,f.setting.mapp_over_label);
//日期
f.uilayer[5]=new uiTextLayer("0000/00/00 00:00",f.config_slpos.drawdate,f.config_sl.draw.date,f.setting.mapp_over_date);
//对话
f.uilayer[6]=new uiTextLayer("THE NVL Makerとは……",f.config_slpos.drawtalk,f.config_sl.draw.talk,f.setting.mapp_over_talk);
[endscript]

*update
[iscript]
//--------------------------------------------------------
//清空档案按钮层
for (var i=7;i<f.uilayer.count;i++)
{
  f.uilayer[i]=void;
}
//强制设定f.uilayer.count的值
f.uilayer.count=f.config_slpos.locate.count+7;
//--------------------------------------------------------
//重建
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.uilayer[i+7]=new uiSLButton(i);
}
[endscript]
;---------------------------------------------------------------
*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="存取版面设定"]
[iscript]
//刷新画面----------------------------------------------------------------------------------------
with(kag.fore.layers[3])
{
   .fillRect(20,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

//所有层全部不选中
      for (var i=0;i<f.config_slpos.locate.count+7;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//切换版面
if (f.存储==true)
{
f.config_sl=f.config_save;
}
else
{
f.config_sl=f.config_load;
}
//--------------------------------------------
//背景重载
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_sl.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}

[endscript]

;新档标记
[freeimage page=fore layer=11]
[if exp="f.config_slpos.lastsavemark.use==true"]
[image layer=11 page=fore visible=true storage=&"f.config_sl.lastsavemark"]
[layopt layer=11 page=fore left=&"(int)kag.fore.layers[4].left+(int)f.config_slpos.locate[0][0]+(int)f.config_slpos.lastsavemark.x" top=&"(int)kag.fore.layers[4].top+(int)f.config_slpos.locate[0][1]+(int)f.config_slpos.lastsavemark.y"]
[endif]
[iscript]
//--------------------------------------------
//其他样式重载
//简单按钮(改变造型)
f.uilayer[0].Reset(f.config_sl.up);
f.uilayer[1].Reset(f.config_sl.down);
f.uilayer[2].Reset(f.config_sl.back);
//截图省略(改变颜色,字体样式)
f.uilayer[4].Reset(f.config_sl.draw.bookmark);
f.uilayer[5].Reset(f.config_sl.draw.date);
f.uilayer[6].Reset(f.config_sl.draw.talk);
//--------------------------------------------
//重载存取按钮内容
//改变造型,位置,内容文字...
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.uilayer[i+7].Reset(i);
}
//-----------------------------------------------------------------------------------------
//设定界面
drawFrame("基本设定",5,sf.gs.width+40,50,kag.fore.layers[3],140);
//----基本设定----
//背景
[endscript]
[option title="存" name="f.存储" x=&(sf.gs.width+65) y=65 false="f.读取"]
[option title="取" name="f.读取" x=&(sf.gs.width+115) y=65 false="f.存储"]
[iscript]
//字体样式
drawEdit("文字样式",,sf.gs.width+55,95);
[endscript]
 [link hint="点此打开文字样式设定窗口" target=*文字样式]□[endlink]
[iscript]
drawSLsetting("上翻按钮","f.uilayer[0]",sf.gs.width+60,125);
drawSLsetting("下翻按钮","f.uilayer[1]",sf.gs.width+60,155);
drawSLsetting("返回按钮","f.uilayer[2]",sf.gs.width+60,185);

drawFrame("悬停效果",4,sf.gs.width+40,250,kag.fore.layers[3],140);
//----悬停效果----
drawSLsetting("游戏截图","f.uilayer[3]",sf.gs.width+60,270);
drawSLsetting("章节名称","f.uilayer[4]",sf.gs.width+60,300,"*悬停章节");
drawSLsetting("日期显示","f.uilayer[5]",sf.gs.width+60,330,"*悬停日期");
drawSLsetting("对话记录","f.uilayer[6]",sf.gs.width+60,360,"*悬停对话");

drawFrame("存取按钮",2,sf.gs.width+40,425,kag.fore.layers[3],140);
//----存取按钮----
//档案设定-每页档案数及位置(页数用setting去除)
drawEdit("档案个数",,sf.gs.width+60,445);
[endscript]
 [link hint="点此打开存取按钮个数设定窗口" target=*档案个数]□[endlink]
[iscript]
drawEdit("内容设定",,sf.gs.width+60,475);
[endscript]
 [link hint="点此打开存取按钮内容设定窗口" target=*内容设定]□[endlink]
[iscript]
drawFrame("当前坐标",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]
;---------------------------------------------------------------
*档案个数
[call storage="window_savedata.ks"]
[jump target=*update]
;---------------------------------------------------------------
*内容设定
[call storage="window_slbutton.ks"]
[jump target=*window]
;---------------------------------------------------------------
*文字样式
[iscript]
//复制历史记录文字样式
f.参数=new Dictionary();
(Dictionary.assign incontextof f.参数)(f.config_slpos.pagefont);
[endscript]
[eval exp="tf.允许设定字号=false"]
[eval exp="tf.允许设定颜色=false"]
[call storage="window_textstyle.ks"]
[iscript]
//回写
(Dictionary.assign incontextof f.config_slpos.pagefont)(f.参数);
[endscript]
[jump target=*window]
;---------------------------------------------------------------
*悬停章节
[iscript]
f.参数=new Dictionary();
f.参数.size=f.uilayer[4].font.height;
[endscript]
[call storage="window_num.ks"]
[iscript]
//回写
f.uilayer[4].font.height=f.参数.size;
[endscript]
[jump target=*window]

*悬停日期
[iscript]
f.参数=new Dictionary();
f.参数.size=f.uilayer[5].font.height;
[endscript]
[call storage="window_num.ks"]
[iscript]
//回写
f.uilayer[5].font.height=f.参数.size;
[endscript]
[jump target=*window]

*悬停对话
[iscript]
f.参数=new Dictionary();
(Dictionary.assign incontextof f.参数)(f.config_slpos.drawtalk);
f.参数.size=f.uilayer[6].font.height;
[endscript]
[call storage="window_drawtalk.ks"]
[iscript]
//回写
f.uilayer[6].font.height=f.参数.size;
f.config_slpos.drawtalk.count=f.参数.count;
f.config_slpos.drawtalk.space=f.参数.space;
[endscript]
[jump target=*window]
;---------------------------------------------------------------
*确认
[iscript]
//导出按钮信息
f.config_slpos.up=f.uilayer[0].SLlayerElm();
f.config_slpos.down=f.uilayer[1].SLlayerElm();
f.config_slpos.back=f.uilayer[2].SLlayerElm();
f.config_slpos.snapshot=f.uilayer[3].SnapElm();

//悬停效果信息
f.config_slpos.drawmark=f.uilayer[4].TextElm();
f.config_slpos.drawdate=f.uilayer[5].TextElm();

//对话记录
f.config_slpos.drawtalk.x=f.uilayer[6].left;
f.config_slpos.drawtalk.y=f.uilayer[6].top;
f.config_slpos.drawtalk.use=f.uilayer[6].visible;
f.config_slpos.drawtalk.size=f.uilayer[6].font.height;

//各SL按钮的位置记录
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.config_slpos.locate[i][0]=f.uilayer[i+7].left;
  f.config_slpos.locate[i][1]=f.uilayer[i+7].top;
}

//保存
(Dictionary.saveStruct incontextof f.config_slpos)(sf.path+"macro/"+'uislpos.tjs');
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_slpos=Scripts.evalStorage(sf.path+"macro/"+'uislpos.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[freeimage layer="5"]
[freeimage layer="11"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
