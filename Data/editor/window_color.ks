;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------
;顏色轉換函數
;------------------------------------------------------------
[iscript]
function drawcolor()
{
//描繪數值
with(kag.fore.layers[7])
{
  //重新描繪一小塊區域
  .fillRect(140,40,90,150,0xFFD4D0C8);
  //描繪文字
     .drawText(143,46, f.red, 0x000000);
     .drawText(143,86, f.green, 0x000000);
     .drawText(143,126, f.blue, 0x000000);
  //重新描繪一小塊區域
  .fillRect(32,130,90,30,0xFFD4D0C8);
  //描繪文字
  .drawText(32,130, f.color, 0x000000);
}

//設定顏色
var r=d2x(f.red);   while (r.length<2) {r="0"+r;}
var g=d2x(f.green);   while (g.length<2) {g="0"+g;}
var b=d2x(f.blue);   while (b.length<2) {b="0"+b;}

f.color="0x"+r+g+b;

//描繪顏色圖
with(kag.fore.layers[8])
{
  .visible=true;
  .width=90;
  .height=90;
  .left=kag.fore.layers[7].left+20;
  .top=kag.fore.layers[7].top+40;
  .colorRect(0,0,90,90,f.color,255);
}

}
[endscript]
;---------------------------------------------------------------
[iscript]
//滴管取色
function getdropcolor()
{
  //取得顏色
   var color=kag.fore.layers[10].getMainPixel(kag.fore.layers[10].cursorX,kag.fore.layers[10].cursorY);
  //轉換為16進制
   color=d2x(color);
   while (color.length<6) {color="0"+color;}
   f.color="0x"+color;
}
[endscript]

[iscript]
//十進制->十六進制轉換
function d2x(num)
{
        var CH = "0123456789ABCDEF";
        var res = "";
        while (num>=1)
        {
                res = CH[num % 16] + res;
                num /= 16;
        }
        return res;
}
//十六進制->十進制轉換
function x2d(str)
{
       var res=(int)("0x"+str);
       return res;
}
[endscript]
;---------------------------------------------------------------
[iscript]
//取得顏色
f.color=(string)(tf.當前編輯值!);
[endscript]
;---------------------------------------------------------------
;顏色選擇窗口
;---------------------------------------------------------------
*window
[window_up width=750 height=330 title="選擇顏色"]
[iscript]

if (f.color!='')
{
   f.red=x2d(f.color.substring(2,2));
   f.green=x2d(f.color.substring(4,2));
   f.blue=x2d(f.color.substring(6,2));
}
else
{
   f.color="0x000000";
   f.red=0;
   f.green=0;
   f.blue=0;
}

//創建顯示用計時器
f.計時器=new Timer(drawcolor, "");
f.計時器.interval = 10;
[endscript]

[locate x=130 y=40]
R    [slider value="f.red" max=255 height=10]
[locate x=130 y=80]
G    [slider value="f.green" max=255 height=10]
[locate x=130 y=120]
B    [slider value="f.blue" max=255 height=10]
[iscript]
f.計時器.enabled=true;
[endscript]
[locate x=430 y=50]
[button normal="edit_colorboard" recthit="false" exp="getdropcolor()" target=*window]
[image layer=10 visible="true" storage="edit_colorboard"]
[layopt layer=10 left=&"(int)kag.fore.messages[7].left+430" top=&"(int)kag.fore.messages[7].top+50"]
[s]

*確認
[eval exp=&"tf.當前編輯值+'=\''+f.color+'\''"]

*關閉選單
[iscript]
f.計時器.enabled=false;
delete f.計時器;
[endscript]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[freeimage layer="10"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
