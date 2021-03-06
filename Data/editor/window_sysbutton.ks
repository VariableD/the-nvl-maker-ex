;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;系统按钮设定,包括x,y,normal,over,on几个选项
;--------------------------------------------------
*window
[window_middle width=400 height=380 title="系统按钮样式设定"]
[line title="x" name="f.参数.x" x=30 y=50]
[line title="y" name="f.参数.y" x=30 y=80]
[line title="一般" name="f.参数.normal" x=30 y=110 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=140 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=170 type="pic" path="others" copyfrom="f.参数.over"]
[line title="选中SE" name="f.参数.enterse" x=30 y=200 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=30 y=230 type="sound"]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*确认
[commit]
[eval exp=&"tf.当前操作层+'.Reset(f.参数)'"]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
