;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="插入标签"]
[line title="标签名" name="f.参数.label" x=30 y=50]
[check title="作为可存档标签" name="f.参数.cansave" x=30 y=80]
[line true="f.参数.cansave" title="章节名" name="f.参数.pagename" x=30 y=110]
[s]

*确认
[commit]
[iscript]
//防止出错用
if (f.参数.cansave=="true") f.参数.cansave=true;
//假如去掉了可存档标记,则不记录章节名
if (f.参数.cansave==false) f.参数.pagename=void;
//假如缺乏必须值,自动加入
if (f.参数.label==void) f.参数.label="*label";
//假如参数开头不是星号，强制加入星号
if (f.参数.label[0]!="*") f.参数.label="*"+f.参数.label;
[endscript]

[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
