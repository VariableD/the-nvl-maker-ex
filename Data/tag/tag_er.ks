;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="消除对话"]
[group title="消除文字（当前文字层）" name="f.参数.tagname" x=30 y=50 comp="er"]
[group title="消除头像" name="f.参数.tagname" x=30 y=80 comp="clface"]
[group title="段落样式复原" name="f.参数.tagname" x=30 y=110 comp="resetstyle"]

[group title="清空全部文字层" name="f.参数.tagname" x=30 y=140 comp="cm"]
[group title="清空全部文字层并复位" name="f.参数.tagname" x=30 y=170 comp="ct"]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
