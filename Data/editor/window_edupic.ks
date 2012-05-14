;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;養成面板圖形設定
;--------------------------------------------------
*window
[window_middle width=400 height=550 title="養成面板圖形設定"]
[iscript]
drawFrame("顯示設定",3,15,40,kag.fore.layers[5],314);
drawFrame("坐標設定",2,15,175,kag.fore.layers[5],314);
drawFrame("變數值作為圖形數字",2,15,280,kag.fore.layers[5],314);
drawFrame("變數值作為圖片名",1,15,385,kag.fore.layers[5],314);
[endscript]

[line title="名稱" name="f.參數.name" x=30 y=60]
[line title="條件" name="f.參數.cond" type="cond" x=30 y=90]
[line title="變數" name="f.參數.flagname" x=30 y=120]
;
[line title="x" name="f.參數.x" x=30 y=195]
[line title="y" name="f.參數.y" x=30 y=225]
;
;[line title="只指定前綴和間距的情況，變數值會轉化為圖形數字" x=15 y=200]
[line title="前綴" name="f.參數.num" x=30 y=300]
[line title="間距" name="f.參數.space" x=30 y=330]
;
;[line title="當指定了演示圖形後，變數值（字符串）被視為圖片名" x=15 y=290]
[line title="演示圖形" name="f.參數.pic" x=30 y=405 type="pic" path="others"]

[s]

*確認
[commit]
[eval exp=&"tf.當前操作層+'.Reset(f.參數)'"]

*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]

*生成條件
[call storage="window_cond.ks"]
[jump target=*window]

*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]
