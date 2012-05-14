;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;養成面板文字設定
;--------------------------------------------------
*window
[window_middle width=400 height=550 title="養成面板文字設定"]

[iscript]
drawFrame("顯示設定",3,15,40,kag.fore.layers[5],314);
drawFrame("文字樣式",8,15,175,kag.fore.layers[5],314);
[endscript]

[line title="名稱" name="f.參數.name" x=30 y=60]
[line title="條件" name="f.參數.cond" type="cond" x=30 y=90]
[line title="變數" name="f.參數.flagname" x=30 y=120]
;
[line title="x" name="f.參數.x" x=30 y=195]
[line title="y" name="f.參數.y" x=30 y=225]
;
[line title="字體" name="f.參數.fontname" type="font" x=30 y=255]
[line title="字號" name="f.參數.size" x=30 y=285]
[line title="顏色" name="f.參數.color" type="color" x=30 y=315]
[check title="加粗" name="f.參數.bold" x=30 y=345]

[option title="陰影" name="f.參數.shadow" x=30 y=375 false="f.參數.edge"]
[line title="" name="f.參數.shadowcolor" type="color" x=80 y=375 true="f.參數.shadow" length=174]
[option title="邊緣" name="f.參數.edge" x=30 y=405 false="f.參數.shadow"]
[line title="" name="f.參數.edgecolor" type="color" x=80 y=405 true="f.參數.edge" length=174]


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

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]

*選擇字體
[call storage="window_font.ks"]
[jump target=*window]

