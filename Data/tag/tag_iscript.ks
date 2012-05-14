;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.參數.autor=false;
f.參數.autow=false;

f.文本框=new MultiEditLayer(kag , kag.fore.base);
f.文本框.text=f.參數.tjs;
f.文本框.left=(kag.scWidth-700)/2+30;
f.文本框.top=(kag.scHeight-600)/2+105;
[endscript]

*window
[window_middle width=700 height=600 title="TJS編輯"]
[locate x=30 y=40]
插入
[locate x=100 y=40]
[link exp="f.文本框.insertCharacter('function ()\n{\n//這裡填寫具體內容\n\n}')"]空函數
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

*確認
[commit]
[iscript]
f.參數.tjs=f.文本框.text;
commitLine(f.參數);
f.文本框.visible=false;
f.文本框=void;
[endscript]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[iscript]
f.文本框.visible=false;
f.文本框=void;
[endscript]
[jump storage="tag_direct.ks" target=*關閉選單]
