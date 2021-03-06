;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;养成面板图形设定
;--------------------------------------------------
*window
[window_middle width=400 height=550 title="养成面板图形设定"]
[iscript]
drawFrame("显示设定",3,15,40,kag.fore.layers[5],314);
drawFrame("位置设定",2,15,175,kag.fore.layers[5],314);
drawFrame("变数值作为图形数字",2,15,280,kag.fore.layers[5],314);
drawFrame("变数值作为图片名",1,15,385,kag.fore.layers[5],314);
[endscript]

[line title="名称" name="f.参数.name" x=30 y=60]
[line title="条件" name="f.参数.cond" type="cond" x=30 y=90]
[line title="变数" name="f.参数.flagname" x=30 y=120]
;
[line title="x" name="f.参数.x" x=30 y=195]
[line title="y" name="f.参数.y" x=30 y=225]
;
;[line title="只指定前缀和间距的情况，变数值会转化为图形数字" x=15 y=200]
[line title="前缀" name="f.参数.num" x=30 y=300]
[line title="间距" name="f.参数.space" x=30 y=330]
;
;[line title="当指定了演示图形后，变数值（字符串）被视为图片名" x=15 y=290]
[line title="演示图形" name="f.参数.pic" x=30 y=405 type="pic" path="others"]

[s]

*确认
[commit]
[eval exp=&"tf.当前操作层+'.Reset(f.参数)'"]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]
