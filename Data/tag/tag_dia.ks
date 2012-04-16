;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=400 title="话框样式"]
[group title="对话框" name="f.参数.tagname" x=30 y=50 comp="dia"]
[group title="全屏框" name="f.参数.tagname" x=30 y=80 comp="scr"]
[group title="透明框" name="f.参数.tagname" x=30 y=110 comp="menu"]

[group title="隐藏话框" name="f.参数.tagname" x=30 y=170 comp="hidemes"]
[group title="恢复显示" name="f.参数.tagname" x=30 y=200 comp="showmes"]

;[group title="话框移入" name="f.参数.tagname" x=30 y=140 comp="framein"]
;[group title="话框移出" name="f.参数.tagname" x=30 y=170 comp="frameout"]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
