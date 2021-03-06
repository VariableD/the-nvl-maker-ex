;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.参数.autor=false;
f.参数.autow=false;

f.文本框=new MultiEditLayer(kag , kag.fore.base);
f.文本框.text=f.参数.tjs;
f.文本框.left=(kag.scWidth-700)/2+25;
f.文本框.top=10+105;
[endscript]

*window
[window_middle width=700 height=600 title="TJS编辑"]
[locate x=30 y=40]
插入
[locate x=100 y=40]
[link exp="f.文本框.insertCharacter('function ()\n{\n//这里填写具体内容\n\n}')"]空函数
[endlink]
;[locate x=200 y=40]
;[link exp="f.文本框.insertCharacter('kag.tagHandlers.ch(%[\n\n]);')"]TAG的TJS式
;[endlink]
[locate x=30 y=70]
[ch text="[iscript]"]
[iscript]
f.文本框.visible=true;
[endscript]
[locate x=30 y=415]
[ch text="[endscript]"]
[s]

*确认
[commit]
[iscript]
f.参数.tjs=f.文本框.text;
commitLine(f.参数);
f.文本框.visible=false;
f.文本框=void;
[endscript]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[iscript]
f.文本框.visible=false;
f.文本框=void;
[endscript]
[jump storage="tag_direct.ks" target=*关闭选单]
