;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;游戏选单设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="主选单设定"]
[iscript]
//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_menu.save);
f.uilayer[1]=new uiButtonLayer(f.config_menu.load);
f.uilayer[2]=new uiButtonLayer(f.config_menu.option);
f.uilayer[3]=new uiButtonLayer(f.config_menu.history);

f.uilayer[4]=new uiButtonLayer(f.config_menu.other);
f.uilayer[5]=new uiButtonLayer(f.config_menu.exit);
f.uilayer[6]=new uiButtonLayer(f.config_menu.totitle);
f.uilayer[7]=new uiButtonLayer(f.config_menu.back);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="主选单设定"]
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
   .loadImages(%["storage"=>f.config_menu.bgd]);
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

drawLink_Picwin("f.config_menu.bgd","others",,);

drawFrame("按钮",8,sf.gs.width+40,130,kag.fore.layers[3],140);
drawButtonSetting("存储游戏","f.uilayer[0]",sf.gs.width+50,150);
drawButtonSetting("读取进度","f.uilayer[1]",sf.gs.width+50,180);
drawButtonSetting("系统设定","f.uilayer[2]",sf.gs.width+50,210);
drawButtonSetting("历史记录","f.uilayer[3]",sf.gs.width+50,240);

drawButtonSetting("自定选单","f.uilayer[4]",sf.gs.width+50,270);
drawButtonSetting("离开游戏","f.uilayer[5]",sf.gs.width+50,300);
drawButtonSetting("返回标题","f.uilayer[6]",sf.gs.width+50,330);
drawButtonSetting("返回游戏","f.uilayer[7]",sf.gs.width+50,360);
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

*确认
[iscript]
f.config_menu.save=f.uilayer[0].ButtonElm();
f.config_menu.load=f.uilayer[1].ButtonElm();
f.config_menu.option=f.uilayer[2].ButtonElm();
f.config_menu.history=f.uilayer[3].ButtonElm();

f.config_menu.other=f.uilayer[4].ButtonElm();
f.config_menu.exit=f.uilayer[5].ButtonElm();
f.config_menu.totitle=f.uilayer[6].ButtonElm();
f.config_menu.back=f.uilayer[7].ButtonElm();

(Dictionary.saveStruct incontextof f.config_menu)(sf.path+"macro/"+'uimenu.tjs');
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_menu=Scripts.evalStorage(sf.path+"macro/"+'uimenu.tjs');
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
