;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.編輯用字典=dictoForm(f.參數);
//如果是空白行就清掉
if  (f.編輯用字典[0]=="_blank") f.編輯用字典[0]="";
[endscript]

*window
[window_middle width=700 height=550 title="直接輸入"]
[line title="指令 @" name="f.編輯用字典[0]" x=30 y=50]

[eval exp="tf.循環=1"]

*circle
[iscript]
if (f.編輯用字典[tf.循環]==void)
{
f.編輯用字典[tf.循環]=%[];
}
tf.操作屬性="f.編輯用字典["+tf.循環+"].elm";
tf.操作值="f.編輯用字典["+tf.循環+"].value";
[endscript]

[line title="&('參數'+tf.循環)" name=&tf.操作屬性 x=30 y=&(50+30*tf.循環)]
[line title="=" name=&tf.操作值 x=290 y=&(50+30*tf.循環)]
[eval exp="tf.循環++"]
[jump target=*circle cond="tf.循環<16"]
[s]

*確認
[commit]
[iscript]
if (f.編輯用字典[0]!=void)
{
//參數格式設置
f.參數=formtoDic(f.編輯用字典);
//參數正式寫入
commitLine(f.參數);
}
[endscript]

*擦除窗口
[rclick enabled="false"]
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return storage="window_tag.ks" target=*關閉選單]

*關閉選單
[iscript]
//變數重設
f.參數=%[];
[endscript]
[rclick enabled="false"]
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
