;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=350 title="停止音效"]

[group title="停止音效" name="f.参数.tagname" x=30 y=50 comp="stopse"]
[group title="音效渐变" name="f.参数.tagname" x=30 y=80 comp="fadese"]
[group title="音效渐出" name="f.参数.tagname" x=30 y=110 comp="fadeoutse"]

[line title="编号" name="f.参数.buf" x=30 y=150]

[if exp="f.参数.tagname=='fadeoutse'"]
[line title="时间" name="f.参数.time" x=30 y=180]

[elsif exp="f.参数.tagname=='fadese'"]
[line title="时间" name="f.参数.time" x=30 y=180]
[line title="音量" name="f.参数.volume" x=30 y=210]
[endif]

[s]

*确认
[commit]
[iscript]
//清理非必要参数
if (f.参数.tagname=="stopse") 
{
f.参数.time=void;
f.参数.volume=void;
}
else if (f.参数.tagname=="fadeoutse")
{
f.参数.volume=void;
}
[endscript]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
