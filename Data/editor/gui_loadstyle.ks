;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;读取图形样式设定
;--------------------------------------------------
*window
[window_down width=1010 height=800 title="读取图形样式设定"]
;----------------------------------------------
[iscript]
drawFrame("基本设定",2,15,50,kag.fore.layers[3]);
[endscript]
[line title="背景" name="f.config_load.bgd" type="pic" path="others" x=30 y=70]
[line title="新档标记" name="f.config_load.lastsavemark" type="pic" path="others" x=30 y=100]
;[line title="页数显示" name="f.config_load.pagecolor" type="color" x=30 y=130]

;返回按钮(normal/over/on)
[iscript]
drawFrame("返回按钮",5,15,160,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.back.normal" type="pic" path="others" x=30 y=180]
[line title="选中" name="f.config_load.back.over" type="pic" path="others" x=30 y=210 copyfrom="f.config_load.back.normal"]
[line title="按下" name="f.config_load.back.on" type="pic" path="others" x=30 y=240 copyfrom="f.config_load.back.over"]
[line title="选中SE" name="f.config_load.back.enterse" type="sound" x=30 y=270]
[line title="按下SE" name="f.config_load.back.clickse" type="sound" x=30 y=300]

;上翻页按钮(normal/over/on)
[iscript]
drawFrame("向上翻页",5,15,360,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.up.normal" type="pic" path="others" x=30 y=380]
[line title="选中" name="f.config_load.up.over" type="pic" path="others" x=30 y=410 copyfrom="f.config_load.up.normal"]
[line title="按下" name="f.config_load.up.on" type="pic" path="others" x=30 y=440 copyfrom="f.config_load.up.over"]
[line title="选中SE" name="f.config_load.up.enterse" type="sound" x=30 y=470]
[line title="按下SE" name="f.config_load.up.clickse" type="sound" x=30 y=500]

;下翻页按钮(normal/over/on)
[iscript]
drawFrame("向下翻页",5,15,560,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.down.normal" type="pic" path="others" x=30 y=580]
[line title="选中" name="f.config_load.down.over" type="pic" path="others" x=30 y=610 copyfrom="f.config_load.down.normal"]
[line title="按下" name="f.config_load.down.on" type="pic" path="others" x=30 y=640 copyfrom="f.config_load.down.over"]
[line title="选中SE" name="f.config_load.down.enterse" type="sound" x=30 y=670]
[line title="按下SE" name="f.config_load.down.clickse" type="sound" x=30 y=700]
;----------------------------------------------

;存档按钮(normal/over/on)
[iscript]
drawFrame("读档按钮",5,345,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.button.normal" type="pic" path="others" x=360 y=70]
[line title="选中" name="f.config_load.button.over" type="pic" path="others" x=360 y=100 copyfrom="f.config_load.button.normal"]
[line title="按下" name="f.config_load.button.on" type="pic" path="others" x=360 y=130 copyfrom="f.config_load.button.over"]
[line title="选中SE" name="f.config_load.button.enterse" type="sound" x=360 y=160]
[line title="按下SE" name="f.config_load.button.clickse" type="sound" x=360 y=190]

;按钮文字-档案编号(normal/over/on)
[iscript]
drawFrame("按钮文字-档案编号",3,345,250,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.num.normal" type="color" x=360 y=270]
[line title="选中" name="f.config_load.num.over" type="color" x=360 y=300 copyfrom="f.config_load.num.normal"]
[line title="按下" name="f.config_load.num.on" type="color" x=360 y=330 copyfrom="f.config_load.num.over"]

;章节名称(normal/over/on)
[iscript]
drawFrame("按钮文字-章节名称",3,345,390,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.bookmark.normal" type="color" x=360 y=410]
[line title="选中" name="f.config_load.bookmark.over" type="color" x=360 y=440 copyfrom="f.config_load.bookmark.normal"]
[line title="按下" name="f.config_load.bookmark.on" type="color" x=360 y=470 copyfrom="f.config_load.bookmark.over"]
;存档日期(normal/over/on)
[iscript]
drawFrame("按钮文字-存档日期",3,345,530,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.date.normal" type="color" x=360 y=550]
[line title="选中" name="f.config_load.date.over" type="color" x=360 y=580 copyfrom="f.config_load.date.normal"]
[line title="按下" name="f.config_load.date.on" type="color" x=360 y=610 copyfrom="f.config_load.date.over"]

;对话记录(normal/over/on)
[iscript]
drawFrame("按钮文字-对话记录",3,675,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.history.normal" type="color" x=690 y=70]
[line title="选中" name="f.config_load.history.over" type="color" x=690 y=100 copyfrom="f.config_load.history.normal"]
[line title="按下" name="f.config_load.history.on" type="color" x=690 y=130 copyfrom="f.config_load.history.over"]

;悬停文字(章节/日期/对话)
[iscript]
drawFrame("悬停文字",3,675,190,kag.fore.layers[3]);
[endscript]
[line title="章节" name="f.config_load.draw.bookmark" type="color" x=690 y=210]
[line title="日期" name="f.config_load.draw.date" type="color" x=690 y=240 copyfrom="f.config_load.draw.bookmark"]
[line title="对话" name="f.config_load.draw.talk" type="color" x=690 y=270 copyfrom="f.config_load.draw.bookmark"]
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
;保存当前f.config_load
[commit]
[iscript]
(Dictionary.saveStruct incontextof f.config_load)(sf.path+"macro/"+'uiload.tjs');
[endscript]

*关闭选单
;重载f.config_load
[iscript]
f.config_load=Scripts.evalStorage(sf.path+"macro/"+'uiload.tjs');
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
