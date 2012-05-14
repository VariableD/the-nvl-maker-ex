;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;姓名設定
;--------------------------------------------------
[iscript]
//臨時代入
tf.當前編輯姓名=tf.當前編輯值;
[endscript]

*window
[window_down width=400 height=300 title="姓名樣式編輯"]
[line title=簡稱 name=&(tf.當前編輯姓名+".tag") x=30 y=50]
[line title=姓名 name=&(tf.當前編輯姓名+".name") x=30 y=80]
[line title=顏色 name=&(tf.當前編輯姓名+".color") x=30 y=110 type="color"]

[s]

*選擇顏色
[call storage="window_color.ks"]
[jump target=*window]
;----------------------------------------------
*確認
[commit]

*關閉選單
[rclick enabled="false"]
[freeimage layer="3"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[return]
