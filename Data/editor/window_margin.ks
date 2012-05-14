;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;對話框頁邊距設定,margin
;--------------------------------------------------
*window
[window_up width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="頁邊距設定"]
[iscript]
//背景設定
with(kag.fore.layers[8])
{
   .left=kag.fore.layers[7].left+20;
   .top=kag.fore.layers[7].top+50;
   .width=sf.gs.width;
   .height=sf.gs.height;
   .visible=true;
   .fillRect(0,0,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

drawFrame("頁邊距",3,sf.gs.width+40,50,kag.fore.layers[7],140);
kag.fore.layers[7].drawText(20,sf.gs.height+65,"提示：請以左上角->右下角的方向用鼠標拖動出紅色框線，紅框代表文字在對話框上顯示的範圍",0x000000);
f.marginlayer=new getMarginLayer(f.參數.frame);

[endscript]
[s]

*確認
[iscript]
//確認輸出(正式寫入f.參數.margin)
f.marginlayer.MarginElm();
[endscript]

*關閉選單
[iscript]
delete f.marginlayer;
[endscript]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
