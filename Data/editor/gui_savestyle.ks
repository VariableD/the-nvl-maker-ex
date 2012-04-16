;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;存储图形样式设定
;--------------------------------------------------
*window
[window_down width=1010 height=800 title="存储图形样式设定"]
;----------------------------------------------
[iscript]
drawFrame("基本设定",2,15,50,kag.fore.layers[3]);
[endscript]
[line title="背景" name="f.config_save.bgd" type="pic" path="others" x=30 y=70]
[line title="新档标记" name="f.config_save.lastsavemark" type="pic" path="others" x=30 y=100]
;[line title="页数显示" name="f.config_save.pagecolor" type="color" x=30 y=130]

;返回按钮(normal/over/on)
[iscript]
drawFrame("返回按钮",5,15,160,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.back.normal" type="pic" path="others" x=30 y=180]
[line title="选中" name="f.config_save.back.over" type="pic" path="others" x=30 y=210 copyfrom="f.config_save.back.normal"]
[line title="按下" name="f.config_save.back.on" type="pic" path="others" x=30 y=240 copyfrom="f.config_save.back.over"]
[line title="选中SE" name="f.config_save.back.enterse" type="sound" x=30 y=270]
[line title="按下SE" name="f.config_save.back.clickse" type="sound" x=30 y=300]

;上翻页按钮(normal/over/on)
[iscript]
drawFrame("向上翻页",5,15,360,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.up.normal" type="pic" path="others" x=30 y=380]
[line title="选中" name="f.config_save.up.over" type="pic" path="others" x=30 y=410 copyfrom="f.config_save.up.normal"]
[line title="按下" name="f.config_save.up.on" type="pic" path="others" x=30 y=440 copyfrom="f.config_save.up.over"]
[line title="选中SE" name="f.config_save.up.enterse" type="sound" x=30 y=470]
[line title="按下SE" name="f.config_save.up.clickse" type="sound" x=30 y=500]

;下翻页按钮(normal/over/on)
[iscript]
drawFrame("向下翻页",5,15,560,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.down.normal" type="pic" path="others" x=30 y=580]
[line title="选中" name="f.config_save.down.over" type="pic" path="others" x=30 y=610 copyfrom="f.config_save.down.normal"]
[line title="按下" name="f.config_save.down.on" type="pic" path="others" x=30 y=640 copyfrom="f.config_save.down.over"]
[line title="选中SE" name="f.config_save.down.enterse" type="sound" x=30 y=670]
[line title="按下SE" name="f.config_save.down.clickse" type="sound" x=30 y=700]
;----------------------------------------------

;存档按钮(normal/over/on)
[iscript]
drawFrame("存档按钮",5,345,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.button.normal" type="pic" path="others" x=360 y=70]
[line title="选中" name="f.config_save.button.over" type="pic" path="others" x=360 y=100 copyfrom="f.config_save.button.normal"]
[line title="按下" name="f.config_save.button.on" type="pic" path="others" x=360 y=130 copyfrom="f.config_save.button.over"]
[line title="选中SE" name="f.config_save.button.enterse" type="sound" x=360 y=160]
[line title="按下SE" name="f.config_save.button.clickse" type="sound" x=360 y=190]

;按钮文字-档案编号(normal/over/on)
[iscript]
drawFrame("按钮文字-档案编号",3,345,250,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.num.normal" type="color" x=360 y=270]
[line title="选中" name="f.config_save.num.over" type="color" x=360 y=300 copyfrom="f.config_save.num.normal"]
[line title="按下" name="f.config_save.num.on" type="color" x=360 y=330 copyfrom="f.config_save.num.over"]

;章节名称(normal/over/on)
[iscript]
drawFrame("按钮文字-章节名称",3,345,390,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.bookmark.normal" type="color" x=360 y=410]
[line title="选中" name="f.config_save.bookmark.over" type="color" x=360 y=440 copyfrom="f.config_save.bookmark.normal"]
[line title="按下" name="f.config_save.bookmark.on" type="color" x=360 y=470 copyfrom="f.config_save.bookmark.over"]
;存档日期(normal/over/on)
[iscript]
drawFrame("按钮文字-存档日期",3,345,530,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.date.normal" type="color" x=360 y=550]
[line title="选中" name="f.config_save.date.over" type="color" x=360 y=580 copyfrom="f.config_save.date.normal"]
[line title="按下" name="f.config_save.date.on" type="color" x=360 y=610 copyfrom="f.config_save.date.over"]

;对话记录(normal/over/on)
[iscript]
drawFrame("按钮文字-对话记录",3,675,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.history.normal" type="color" x=690 y=70]
[line title="选中" name="f.config_save.history.over" type="color" x=690 y=100 copyfrom="f.config_save.history.normal"]
[line title="按下" name="f.config_save.history.on" type="color" x=690 y=130 copyfrom="f.config_save.history.over"]

;悬停文字(章节/日期/对话)
[iscript]
drawFrame("悬停文字",3,675,190,kag.fore.layers[3]);
[endscript]
[line title="章节" name="f.config_save.draw.bookmark" type="color" x=690 y=210]
[line title="日期" name="f.config_save.draw.date" type="color" x=690 y=240 copyfrom="f.config_save.draw.bookmark"]
[line title="对话" name="f.config_save.draw.talk" type="color" x=690 y=270 copyfrom="f.config_save.draw.bookmark"]
;----------------------------------------------
[s]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*确认
;保存当前f.config_save
[commit]
[iscript]
(Dictionary.saveStruct incontextof f.config_save)(sf.path+"macro/"+'uisave.tjs');
[endscript]

*关闭选单
;重载f.config_save
[iscript]
f.config_save=Scripts.evalStorage(sf.path+"macro/"+'uisave.tjs');
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
