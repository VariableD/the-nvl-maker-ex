;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;對話界面設定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="對話界面版面設定"]
[iscript]
//背景設定
with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20;
   .top=kag.fore.layers[3].top+50;
   .width=sf.gs.width;
   .height=sf.gs.height;
   .visible=true;
   .fillRect(0,0,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}
//在背景上添加圖片
f.uilayer=[];

//全屏對話框
f.uilayer[0]=new uiMessageLayer(f.config_dia.scr);
f.uilayer[0].visible=false;
//普通對話框
f.uilayer[1]=new uiMessageLayer(f.config_dia.dia);
//頭像
//載入頭像大小
var sizelayer=new Layer(kag, kag.fore.stage);
sizelayer.loadImages("face_setting_sample");
sizelayer.setSizeToImageSize();
      
f.uilayer[2]=new uiLayer(%[
                             "left"=>f.config_dia.face.left-sizelayer.width\2,
                             "top"=>f.config_dia.face.top-sizelayer.height,
                             "frame"=>"face_setting_sample"
                          ]);                      
//各按鈕
//save
f.uilayer[3]=new uiButtonLayer(f.config_dia.save);
//load
f.uilayer[4]=new uiButtonLayer(f.config_dia.load);
//skip
f.uilayer[5]=new uiButtonLayer(f.config_dia.skip);
//auto
f.uilayer[6]=new uiButtonLayer(f.config_dia.auto);
//history
f.uilayer[7]=new uiButtonLayer(f.config_dia.history);
//option
f.uilayer[8]=new uiButtonLayer(f.config_dia.option);
//hide
f.uilayer[9]=new uiButtonLayer(f.config_dia.hide);
//menu
f.uilayer[10]=new uiButtonLayer(f.config_dia.menu);
//other
f.uilayer[11]=new uiButtonLayer(f.config_dia.other);

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="對話界面版面設定"]
[iscript]
//--------------------------------------------------------
//刷新圖層
      //所有層全部不選中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
drawFrame("消息層",4,sf.gs.width+40,50,kag.fore.layers[3],140);

drawEdit("透明框邊距",,sf.gs.width+60,70);
[endscript]
 [link hint="點此打開邊距設定窗口" target=*透明框]□[endlink]
[iscript]
drawView("全屏框","f.uilayer[0]",sf.gs.width+60,100,"*全屏框");
drawView("對話框","f.uilayer[1]",sf.gs.width+60,130,"*對話框");
drawView("頭像位","f.uilayer[2]",sf.gs.width+60,160);
//--------------------------------------------------------
drawFrame("系統按鈕",9,sf.gs.width+40,220,kag.fore.layers[3],140);

drawButtonSetting("存儲按鈕","f.uilayer[3]",sf.gs.width+50,240);
drawButtonSetting("讀取按鈕","f.uilayer[4]",sf.gs.width+50,270);
drawButtonSetting("快速略過","f.uilayer[5]",sf.gs.width+50,300);
drawButtonSetting("自動前進","f.uilayer[6]",sf.gs.width+50,330);
drawButtonSetting("歷史記錄","f.uilayer[7]",sf.gs.width+50,360);
drawButtonSetting("系統設定","f.uilayer[8]",sf.gs.width+50,390);
drawButtonSetting("隱藏窗口","f.uilayer[9]",sf.gs.width+50,420);
drawButtonSetting("主選單","f.uilayer[10]",sf.gs.width+50,450);
drawButtonSetting("自定義","f.uilayer[11]",sf.gs.width+50,480);

drawFrame("當前坐標",1,sf.gs.width+40,540,kag.fore.layers[3],140);
//--------------------------------------------------------
[endscript]
[s]

*透明框
[iscript]
      //所有層全部不選中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
[endscript]
;打開margin設定窗口
[iscript]
f.參數=new Dictionary();
f.參數.marginl=f.config_dia.blank.marginl;
f.參數.marginr=f.config_dia.blank.marginr;
f.參數.margint=f.config_dia.blank.margint;
f.參數.marginb=f.config_dia.blank.marginb;
f.參數.frame="empty";
[endscript]
[call storage="window_margin.ks"]
[iscript]
f.config_dia.blank.marginl=f.參數.marginl;
f.config_dia.blank.marginr=f.參數.marginr;
f.config_dia.blank.margint=f.參數.margint;
f.config_dia.blank.marginb=f.參數.marginb;
[endscript]
[jump target=*window]

*全屏框
[iscript]
f.參數=f.uilayer[0].MessageElm();
[endscript]
[call storage="window_frame.ks"]
[iscript]
f.uilayer[0].Reset(f.參數);
[endscript]
[jump target=*window]

*對話框
[iscript]
f.參數=f.uilayer[1].MessageElm();
[endscript]
[call storage="window_frame.ks"]
[iscript]
f.uilayer[1].Reset(f.參數);
[endscript]
[jump target=*window]

*按鈕設定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*確認
;保存
[iscript]
//透明框已經複製

//複製對話框信息
f.config_dia.scr=f.uilayer[0].MessageElm();
f.config_dia.dia=f.uilayer[1].MessageElm();
f.config_dia.face.left=f.uilayer[2].left+sizelayer.width\2;
f.config_dia.face.top=f.uilayer[2].top+sizelayer.height;

//複製按鈕信息
f.config_dia.save=f.uilayer[3].ButtonElm();
f.config_dia.load=f.uilayer[4].ButtonElm();
f.config_dia.skip=f.uilayer[5].ButtonElm();
f.config_dia.auto=f.uilayer[6].ButtonElm();
f.config_dia.history=f.uilayer[7].ButtonElm();
f.config_dia.option=f.uilayer[8].ButtonElm();
f.config_dia.hide=f.uilayer[9].ButtonElm();
f.config_dia.menu=f.uilayer[10].ButtonElm();
f.config_dia.other=f.uilayer[11].ButtonElm();

//保存字典
(Dictionary.saveStruct incontextof f.config_dia)(sf.path+"macro/"+'uidia.tjs');
[endscript]

*關閉選單
;重載字典
[iscript]
f.config_dia=Scripts.evalStorage(sf.path+"macro/"+'uidia.tjs');
delete f.uilayer;
delete sizelayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
