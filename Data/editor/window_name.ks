;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;姓名设定
;--------------------------------------------------
[iscript]
//临时代入
tf.当前编辑姓名=tf.当前编辑值;
[endscript]

*window
[window_down width=400 height=300 title="姓名样式编辑"]
[line title=简称 name=&(tf.当前编辑姓名+".tag") x=30 y=50]
[line title=姓名 name=&(tf.当前编辑姓名+".name") x=30 y=80]
[line title=颜色 name=&(tf.当前编辑姓名+".color") x=30 y=110 type="color"]

[s]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]
;----------------------------------------------
*确认
[commit]

*关闭选单
[rclick enabled="false"]
[freeimage layer="3"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[return]
