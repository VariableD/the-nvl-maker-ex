;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=370 title="段落样式"]

[eval exp="drawFrame('对齐',1,15,40,kag.fore.layers[5],314)"]
[group title="左" name="f.参数.align" x=45 y=60 comp="left"]
[group title="中" name="f.参数.align" x=145 y=60 comp="center"]
[group title="右" name="f.参数.align" x=245 y=60 comp="right"]

[eval exp="drawFrame('间距',3,15,110,kag.fore.layers[5],314)"]

[line title="行间距" name="f.参数.linespacing" x=30 y=130]
[line title="字间距" name="f.参数.pitch" x=30 y=160]
[line title="默认行高" name="f.参数.linesize" x=30 y=190]
[check title="自动换行" name="f.参数.autoreturn" x=30 y=240]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
