;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;面板編輯窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+370" height=&"sf.gs.height+100" title="面板編輯窗口"]
[iscript]
//創建層
f.uilayer=[];
//按鈕層
for (var i=0;i<10;i++)
{
f.uilayer[i]=new uiEduButtonLayer(f.config_edu[i+1]);
}
//文字層
for (var i=10;i<20;i++)
{
f.uilayer[i]=new uiEduTextLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
}
//數值層
for (var i=20;i<30;i++)
{
f.uilayer[i]=new uiEduPicLayer(f.config_edu[i+1].name,f.config_edu[i+1]);
}

[endscript]
;---------------------------------------------------------------
*window
[window_down width=&"sf.gs.width+370" height=&"sf.gs.height+100" title="面板編輯窗口"]
[iscript]
//--------------------------------------------
//背景重載
with(kag.fore.layers[3])
{
   .fillRect(20+160,50,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

with(kag.fore.layers[4])
{
   .left=kag.fore.layers[3].left+20+160;
   .top=kag.fore.layers[3].top+50;
   .visible=true;
   .loadImages(%["storage"=>f.config_edu[0].bgd]);
   .width=sf.gs.width;
   .height=sf.gs.height;
}
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

drawFrame("顯示設定",20,20,50,kag.fore.layers[3],140);
drawFrame("基本設定",1,sf.gs.width+200,50,kag.fore.layers[3],140);
drawEdit("背景圖形",,sf.gs.width+220,70);
drawLink_Picwin("f.config_edu[0].bgd","map",,);

drawFrame("按鈕設定",10,sf.gs.width+200,130,kag.fore.layers[3],140);
drawFrame("當前坐標",1,sf.gs.width+200,540,kag.fore.layers[3],140);

//按鈕編輯
for (var i=0;i<10;i++)
{
drawEduButtonSetting(f.uilayer[i].name,"f.uilayer["+i+"]",sf.gs.width+220,150+i*30);
}
//文字編輯
for (var i=10;i<20;i++)
{
drawEduTextSetting(f.uilayer[i].name,"f.uilayer["+i+"]",40,70+(i-10)*30);
}
//數值編輯
for (var i=20;i<30;i++)
{
drawEduPicSetting(f.uilayer[i].name,"f.uilayer["+i+"]",40,70+(i-10)*30);
}
[endscript]
[s]

*確認
[iscript]
//按鈕
for (var i=0;i<10;i++)
{
f.config_edu[i+1]=f.uilayer[i].ButtonElm();
}
//文字
for (var i=10;i<20;i++)
{
f.config_edu[i+1]=f.uilayer[i].TextElm();
}
//圖形
for (var i=20;i<30;i++)
{
f.config_edu[i+1]=f.uilayer[i].PicElm();
}

//保存
f.config_edu.saveStruct(sf.path+"map/"+f.eduname);
[endscript]

*關閉選單
[iscript]
delete f.uilayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="map_main.ks"]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]

*按鈕設定
[call storage="window_edubutton.ks"]
[jump target=*window]

*文字設定
[call storage="window_edutext.ks"]
[jump target=*window]

*圖形設定
[call storage="window_edupic.ks"]
[jump target=*window]
