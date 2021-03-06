;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;历史记录设定窗口
;背景,文字样式,文字区域
;上下按钮,返回按钮,滚动条
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="历史记录设定"]
[iscript]
//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_history.up);
f.uilayer[1]=new uiButtonLayer(f.config_history.down);
f.uilayer[2]=new uiButtonLayer(f.config_history.back);
f.uilayer[3]=new uiScrollLayer(f.config_history.slider);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="历史记录设定"]

[iscript]
with(kag.fore.layers[3])
{
   .fillRect(20,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}
//背景重载
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_history.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}
//描绘文字
demoHistory();
//--------------------------------------------------------
//刷新图层
      //所有层全部不选中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
drawFrame("基本设定",2,sf.gs.width+40,50,kag.fore.layers[3],140);
drawEdit("背景图形",,sf.gs.width+70,70);drawLink_Picwin("f.config_history.bgd","others",,);
drawEdit("文字范围",,sf.gs.width+70,100);
[endscript]
 [link hint="点此打开文字范围设定窗口" target=*文字范围]□[endlink]
 
[iscript]
drawFrame("控件设定",4,sf.gs.width+40,160,kag.fore.layers[3],140);
drawButtonSetting("上翻按钮","f.uilayer[0]",sf.gs.width+50,180);
drawButtonSetting("下翻按钮","f.uilayer[1]",sf.gs.width+50,210);
drawButtonSetting("返回按钮","f.uilayer[2]",sf.gs.width+50,240);
//滚动条
       drawCheck("滚动条","f.uilayer[3].visible",sf.gs.width+50,270);
[endscript]
 [link hint="点此打开滚动条样式设定窗口" target=*滚动条]□[endlink]
[iscript]
//--------------------------------------------------------
drawFrame("当前坐标",1,sf.gs.width+40,540,kag.fore.layers[3],140);
[endscript]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*文字范围
[iscript]
f.参数=new Dictionary();
f.参数.frame=f.config_history.bgd;
f.参数.marginl=f.config_history.marginl;
f.参数.marginr=f.config_history.marginr;
f.参数.margint=f.config_history.margint;
f.参数.marginb=f.config_history.marginb;
[endscript]
;[call storage="window_textscale.ks"]
;[iscript]
;f.config_history.left=(int)f.参数.left;
;f.config_history.top=(int)f.参数.top;
;f.config_history.line=(int)f.参数.line;
;f.config_history.linespace=(int)f.参数.linespace;
;[endscript]
[call storage="window_margin.ks"]
[iscript]
f.config_history.marginl=f.参数.marginl;
f.config_history.marginr=f.参数.marginr;
f.config_history.margint=f.参数.margint;
f.config_history.marginb=f.参数.marginb;
[endscript]
[jump target=*window]

*文字样式
[iscript]
//复制历史记录文字样式
f.参数=new Dictionary();
(Dictionary.assign incontextof f.参数)(f.config_history.font);
[endscript]
[eval exp="tf.允许设定颜色=false"]
[eval exp="tf.允许设定字号=true"]
[call storage="window_textstyle.ks"]
[iscript]
//回写
(Dictionary.assign incontextof f.config_history.font)(f.参数);
[endscript]
[jump target=*window]

*滚动条
[iscript]
tf.当前操作层="f.uilayer[3]";
f.参数=f.uilayer[3].ScrollElm();
[endscript]
[call storage="window_scroll.ks"]
[jump target=*window]

*确认
[iscript]
//按钮,滚动条信息
f.config_history.up=f.uilayer[0].ButtonElm();
f.config_history.down=f.uilayer[1].ButtonElm();
f.config_history.back=f.uilayer[2].ButtonElm();
f.config_history.slider=f.uilayer[3].ScrollElm();
//保存
(Dictionary.saveStruct incontextof f.config_history)(sf.path+"macro/"+'uihistory.tjs');
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_history=Scripts.evalStorage(sf.path+"macro/"+'uihistory.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
