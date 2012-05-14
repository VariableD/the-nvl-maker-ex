;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------
;指令按鈕選擇窗口
;-------------------------------------------------------------------
*window
[locklink]
[rclick enabled=true jump=true call="false" target=*關閉選單]
;描繪窗體底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],'指令選擇',640,480)"]
;描繪關閉按鈕
[current layer="message3"]
[er]
[nowait]
[locate x=&"640-23" y=6]
[button normal=edit_slider_button target=*關閉選單]
[eval exp="drawButtonCaption('×',16)"]

[iscript]
drawFrame("圖像",5,15,40,kag.fore.layers[3],140);

drawFrame("對話",5,170,40,kag.fore.layers[3],140);

drawFrame("音聲",5,325,40,kag.fore.layers[3],140);

drawFrame("選項",5,480,40,kag.fore.layers[3],140);

[endscript]
;圖像
[button_tag x=35 y=65 name="顯示背景" exp="f.參數.tagname='bg'"]
[button_tag x=35 y=95 name="顯示人物" exp="f.參數.tagname='fg'"]
[button_tag x=35 y=125 name="顯示頭像" exp="f.參數.tagname='face'"]
[button_tag x=35 y=155 name="消除背景" exp="f.參數.tagname='clbg'"]
[button_tag x=35 y=185 name="消除人物" exp="f.參數.tagname='clfg'"]
;對話
[button_tag x=190 y=65 name="話框樣式" exp="f.參數.tagname='dia'"]
[button_tag x=190 y=95 name="顯示對話" exp="f.參數.tagname='_talk'"]
[button_tag x=190 y=125 name="等待時間" exp="f.參數.tagname='wait'"]
[button_tag x=190 y=155 name="事件跳轉" exp="f.參數.tagname='jump'"]
[button_tag x=190 y=185 name="插入標籤" exp="f.參數.tagname='_label'"]
;音聲
[button_tag x=345 y=65 name="播放音樂" exp="f.參數.tagname='bgm'"]
[button_tag x=345 y=95 name="播放音效" exp="f.參數.tagname='se'"]
[button_tag x=345 y=125 name="等待音效" exp="f.參數.tagname='ws'"]
[button_tag x=345 y=155 name="停止音樂" exp="f.參數.tagname='fadeoutbgm'"]
[button_tag x=345 y=185 name="停止音效" exp="f.參數.tagname='stopse'"]

;選項
;[button_tag x=500 y=65 name="添加選擇" exp="f.參數.tagname='seladd'"]
;[button_tag x=500 y=95 name="等待選擇" exp="f.參數.tagname='select'"]
;[button_tag x=500 y=125 name="選項結束" exp="f.參數.tagname='seldone'"]
;[button_tag x=500 y=95 name="按鈕位置" exp="f.參數.tagname='locate'"]

[button_tag x=500 y=65 name="準備選項" exp="f.參數.tagname='selstart'"]
[button_tag x=500 y=95 name="選項按鈕" exp="f.參數.tagname='selbutton'"]
[button_tag x=500 y=125 name="等待選項" exp="f.參數.tagname='selend'"]
[button_tag x=500 y=155 name="消除選項" exp="f.參數.tagname='clsel'"]
[button_tag x=500 y=185 name="文字連接" exp="f.參數.tagname='links'"]

[locate x=15 y=230]
[button normal="edit_button_page" exp="tf.指令頁面=void" target=*window]
[eval exp="drawButtonCaption('圖形動畫',16)"]
[locate x=85 y=230]
[button normal="edit_button_page" exp="tf.指令頁面=1" target=*window]
[eval exp="drawButtonCaption('變數系統',16)"]

;--------------------------------------------------------------------------------------
[if exp="tf.指令頁面==void"]

[iscript]
//描繪欄框
drawTagBoard();
[endscript]
;雜項
[button_tag x=35 y=295 name="畫面震動" exp="f.參數.tagname='quake'"]
[button_tag x=35 y=325 name="等待震動" exp="f.參數.tagname='wq'"]
[button_tag x=35 y=385 name="圖片位移" exp="f.參數.tagname='movepos'"]
[button_tag x=35 y=415 name="天氣效果" exp="f.參數.tagname='raininit'"]

;動態
[button_tag x=190 y=295 name="動態效果" exp="f.參數.tagname='action'"]
[button_tag x=190 y=325 name="等待動態" exp="f.參數.tagname='wact'"]
[button_tag x=190 y=355 name="停止動態" exp="f.參數.tagname='stopaction'"]

[button_tag x=190 y=415 name="播放語音" exp="f.參數.tagname='vo'"]

;trans
[button_tag x=345 y=295 name="準備切換" exp="f.參數.tagname='backlay'"]
[button_tag x=345 y=325 name="載入圖片" exp="f.參數.tagname='image'"]
[button_tag x=345 y=355 name="卸載圖片" exp="f.參數.tagname='freeimage'"]
[button_tag x=345 y=385 name="執行切換" exp="f.參數.tagname='trans'"]
[button_tag x=345 y=415 name="等待切換" exp="f.參數.tagname='wt'"]

;map/other
[button_tag x=500 y=295 name="調用地圖" exp="f.參數.tagname='map'"]
[button_tag x=500 y=325 name="消除地圖" exp="f.參數.tagname='clmap'"]
[button_tag x=500 y=355 name="調用面板" exp="f.參數.tagname='edu'"]
[button_tag x=500 y=385 name="消除面板" exp="f.參數.tagname='cledu'"]
[button_tag x=500 y=415 name="登錄CG" exp="f.參數.tagname='addcg'"]
;--------------------------------------------------------------------------------------
[else]
[iscript]
//描繪欄框
drawTagBoard(70);
[endscript]
;變數
[button_tag x=35 y=295 name="操作變數" exp="f.參數.tagname='eval'"]
[button_tag x=35 y=325 name="顯示變數" exp="f.參數.tagname='emb'"]

[button_tag x=35 y=355 name="創建分歧" exp="f.參數.tagname='newif'"]
[button_tag x=35 y=385 name="條件分歧" exp="f.參數.tagname='if'"]
[button_tag x=35 y=415 name="分歧結束" exp="f.參數.tagname='endif'"]

[button_tag x=190 y=295 name="對話速度" exp="f.參數.tagname='nowait'"]
[button_tag x=190 y=325 name="對話位置" exp="f.參數.tagname='locate'"]
[button_tag x=190 y=355 name="段落樣式" exp="f.參數.tagname='style'"]
[button_tag x=190 y=385 name="消除對話" exp="f.參數.tagname='er'"]

;系統/流程
[button_tag x=345 y=295 name="離開遊戲" exp="f.參數.tagname='close'"]
[button_tag x=345 y=325 name="歷史記錄" exp="f.參數.tagname='history'"]

[button_tag x=345 y=385 name="呼叫事件" exp="f.參數.tagname='call'"]
[button_tag x=345 y=415 name="呼叫返回" exp="f.參數.tagname='return'"]

;文本/指令
[button_tag x=500 y=295 name="編輯文本" exp="f.參數.tagname='_msg'"]
[button_tag x=500 y=325 name="直接輸入" exp="f.參數.tagname='_blank'"]

[button_tag x=500 y=385 name="TJS段落" exp="f.參數.tagname='iscript'"]
[button_tag x=500 y=415 name="插入註釋" exp="f.參數.tagname='_remark'"]

[endif]
;--------------------------------------------------------------------------------------

;[button_tag x=345 y=415 name="*系統選單" exp="f.參數.tagname='system'"]
;[button_tag x=35 y=385 name="*播放影片" exp="f.參數.tagname='movie'"]
;[button_tag x=35 y=415 name="*圖層設定" exp="f.參數.tagname='layopt'"]
;[button_tag x=500 y=415 name="*登陸CG" exp="f.參數.tagname='getcg'"]

;;按鈕/輸入
;[button_tag x=345 y=295 name="*普通按鈕" exp="f.參數.tagname='button'"]
;[button_tag x=345 y=325 name="*文字連接" exp="f.參數.tagname='links'"]
;[button_tag x=345 y=355 name="*輸入框" exp="f.參數.tagname='edit'"]
;[button_tag x=345 y=385 name="*等待輸入" exp="f.參數.tagname='s'"]
;[button_tag x=345 y=415 name="*確認輸入" exp="f.參數.tagname='commit'"]

;[button_tag x=35 y=415 name="*播放影片" exp="f.參數.tagname='movie'"]
;[button_tag x=190 y=415 name="消除文字" exp="f.參數.tagname='er'"]
[s]

;------------------------------------------------------
;給tagname設好默認值後打開對應窗口
;------------------------------------------------------
*打開指令窗口
[if exp="f.target[f.參數.tagname]!=void"]
[call storage="&('tag_'+f.target[f.參數.tagname]+'.ks')"]
[else]
[call storage="tag_direct.ks"]
[endif]

[jump storage="window_tag.ks"]

*關閉選單
[iscript]
//假如是為最後一行加入的空白行,直接刪除
if (f.script[f.當前腳本行].tagname=="_blank" && f.script[f.當前腳本行+1].tagname=="_end")
{
     deleteLine();
}
[endscript]
[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_script.ks" target=*window]
