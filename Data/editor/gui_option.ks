;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;系统界面设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系统界面版面设定"]
[iscript]
//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiSliderLayer(f.config_option.textspeed);
f.uilayer[1]=new uiSliderLayer(f.config_option.autospeed);

f.uilayer[2]=new uiSliderLayer(f.config_option.bgmvolume);
f.uilayer[3]=new uiSliderLayer(f.config_option.sevolume);

f.uilayer[4]=new uiButtonLayer(f.config_option.fullscreen);
f.uilayer[5]=new uiButtonLayer(f.config_option.window);

f.uilayer[6]=new uiButtonLayer(f.config_option.allskip);
f.uilayer[7]=new uiButtonLayer(f.config_option.readskip);

f.uilayer[8]=new uiButtonLayer(f.config_option.totitle);
f.uilayer[9]=new uiButtonLayer(f.config_option.endgame);

f.uilayer[10]=new uiButtonLayer(f.config_option.back);

f.uilayer[11]=new uiSliderLayer(f.config_option.cvvolume);
f.uilayer[12]=new uiButtonLayer(f.config_option.reset);

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系统界面版面设定"]

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
   .loadImages(%["storage"=>f.config_option.bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}
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
drawFrame("基本设定",1,sf.gs.width+40,50,kag.fore.layers[3],140);
drawEdit("背景图形",,sf.gs.width+70,70);
drawLink_Picwin("f.config_option.bgd","others",,);

drawFrame("控件设定",13,sf.gs.width+40,110,kag.fore.layers[3],140);

drawSliderSetting("文字速度","f.uilayer[0]",sf.gs.width+50,125);
drawSliderSetting("自动速度","f.uilayer[1]",sf.gs.width+50,155);

drawSliderSetting("音乐音量","f.uilayer[2]",sf.gs.width+50,185);
drawSliderSetting("音效音量","f.uilayer[3]",sf.gs.width+50,215);
drawSliderSetting("语音音量","f.uilayer[11]",sf.gs.width+50,245);

//--------------------------------------------------------
//drawFrame("按钮",7,sf.gs.width+40,290,kag.fore.layers[3],140);
drawButtonSetting("全屏显示","f.uilayer[4]",sf.gs.width+50,280);
drawButtonSetting("窗口显示","f.uilayer[5]",sf.gs.width+50,310);
drawButtonSetting("跳过全部","f.uilayer[6]",sf.gs.width+50,340);
drawButtonSetting("只跳已读","f.uilayer[7]",sf.gs.width+50,370);

drawButtonSetting("返回标题","f.uilayer[8]",sf.gs.width+50,405);
drawButtonSetting("离开游戏","f.uilayer[9]",sf.gs.width+50,435);

drawButtonSetting("恢复默认","f.uilayer[12]",sf.gs.width+50,465);

drawButtonSetting("返回游戏","f.uilayer[10]",sf.gs.width+50,495);
//--------------------------------------------------------
drawFrame("当前坐标",1,sf.gs.width+40,540,kag.fore.layers[3],140);

//补画分割线
with(kag.fore.layers[3])
{
      .fillRect(sf.gs.width+40,274,140+1,1,0xFFaca899);
      .fillRect(sf.gs.width+40,274+1,140+2,1,0xFFFFFFFF);
      
      .fillRect(sf.gs.width+40,399,140+1,1,0xFFaca899);
      .fillRect(sf.gs.width+40,399+1,140+2,1,0xFFFFFFFF);      
}

[endscript]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*滑动槽设定
[call storage="window_slider.ks"]
[jump target=*window]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*确认
[iscript]
f.config_option.textspeed=f.uilayer[0].SliderElm();
f.config_option.autospeed=f.uilayer[1].SliderElm();
f.config_option.bgmvolume=f.uilayer[2].SliderElm();
f.config_option.sevolume=f.uilayer[3].SliderElm();

f.config_option.cvvolume=f.uilayer[11].SliderElm();

f.config_option.fullscreen=f.uilayer[4].ButtonElm();
f.config_option.window=f.uilayer[5].ButtonElm();
f.config_option.allskip=f.uilayer[6].ButtonElm();
f.config_option.readskip=f.uilayer[7].ButtonElm();
f.config_option.totitle=f.uilayer[8].ButtonElm();
f.config_option.endgame=f.uilayer[9].ButtonElm();
f.config_option.back=f.uilayer[10].ButtonElm();

f.config_option.reset=f.uilayer[12].ButtonElm();

(Dictionary.saveStruct incontextof f.config_option)(sf.path+"macro/"+'uioption.tjs');
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_option=Scripts.evalStorage(sf.path+"macro/"+'uioption.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
