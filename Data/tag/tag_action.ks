;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=480 title="動態效果"]
[eval exp="drawFrame('基本信息',3,15,40,kag.fore.layers[5],314)"]
[line title="編號" name="f.參數.layer" x=30 y=60 type=list target="*選擇圖層"]
[line title="時間" name="f.參數.time" x=30 y=90]
[line title="延遲" name="f.參數.delay" x=30 y=120]

[eval exp="drawFrame('效果設定',5,15,175,kag.fore.layers[5],314)"]
[line title="效果" name="f.參數.module" x=30 y=190 type=list target="*選擇效果"]
;----------------------------------------------------------------------------------------------
;移動動作組
[if exp="f.參數.module=='LayerNormalMoveModule' || f.參數.module=='LayerAccelMoveModule' || f.參數.module=='LayerDecelMoveModule'"]
[line title="目標坐標" x=30 y=220]
[pos valuex="f.參數.x" valuey="f.參數.y" x=45 y=250]
[endif]
[if exp="f.參數.module=='LayerParabolaMoveModule'"]
[line title="頂點坐標" x=30 y=220]
[pos valuex="f.參數.x" valuey="f.參數.y" x=45 y=250]
[line title="頂點時間" name="f.參數.toptime" x=30 y=310]
[endif]
;----------------------------------------------------------------------------------------------
;往返運動動作組
[if exp="f.參數.module=='LayerVibrateActionModule'"]
[line title="振動設定" x=30 y=220]
[line title="振幅" name="f.參數.vibration" x=30 y=250]
[line title="間隔時間" name="f.參數.waittime" x=30 y=280]
[endif]

[if exp="f.參數.module=='LayerFallActionModule'"]
[line title="落下設定" x=30 y=220]
[line title="距離" name="f.參數.distance" x=30 y=250]
[line title="時間" name="f.參數.falltime" x=30 y=280]
[endif]

[if exp="f.參數.module=='LayerJumpActionModule' || f.參數.module=='LayerJumpOnceActionModule' || f.參數.module=='LayerWaveActionModule' || f.參數.module=='LayerWaveOnceActionModule'"]
[line title="振動設定" x=30 y=220]
[line title="振幅" name="f.參數.vibration" x=30 y=250]
[line title="週期時間" name="f.參數.cycle" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;放大，縮小動作組
[if exp="f.參數.module=='LayerNormalZoomModule' || f.參數.module=='LayerHeartBeatZoomModule'"]
[line title="縮放設定" x=30 y=220]
[line title="放大率" name="f.參數.zoom" x=30 y=250]
[endif]

[if exp="f.參數.module=='LayerVRotateZoomModule' || f.參數.module=='LayerHRotateZoomModule'"]
[line title="3D變形設定" x=30 y=220]
[line title="角速度" name="f.參數.angvel" x=30 y=250]
[endif]

[if exp="f.參數.module=='LayerVibrateZoomModule'"]
[line title="縮放振動設定" x=30 y=220]
[line title="振幅" name="f.參數.vibration" x=30 y=250]
[line title="間隔時間" name="f.參數.waittime" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;旋轉動作組
[if exp="f.參數.module=='LayerNormalRotateModule'"]
[line title="旋轉設定" x=30 y=220]
[line title="角速度" name="f.參數.angvel" x=30 y=250]
[endif]

[if exp="f.參數.module=='LayerVibrateRotateModule'"]
[line title="振動旋轉設定" x=30 y=220]
[line title="振幅" name="f.參數.vibration" x=30 y=250]
[line title="週期時間" name="f.參數.cycle" x=30 y=280]
[endif]

[if exp="f.參數.module=='LayerFalldownRotateModule' || f.參數.module=='LayerToRotateModule'"]
[line title="指定角度" x=30 y=220]
[line title="角度" name="f.參數.angle" x=30 y=250]
[endif]
;----------------------------------------------------------------------------------------------
;漸變動作組
[if exp="f.參數.module=='LayerBlinkModeModule'"]
[line title="閃爍設定" x=30 y=220]
[line title="顯示時間" name="f.參數.showtime" x=30 y=250]
[line title="消失時間" name="f.參數.hidetime" x=30 y=280]
[endif]

[if exp="f.參數.module=='LayerFadeModeModule'"]
[line title="漸變設定" x=30 y=220]
[line title="漸入時間" name="f.參數.intime" x=30 y=250]
[line title="漸出時間" name="f.參數.outtime" x=30 y=280]
[endif]

[if exp="f.參數.module=='LayerFadeToModeModule'"]
[line title="透明設定" x=30 y=220]
[line title="透明度" name="f.參數.opacity" x=30 y=250]
[endif]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
;-----------------------------------------------------------------
*選擇圖層
[list_layer x=34 y=50]
[s]

*關閉下拉菜單
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*選擇效果
[commit]
[list x=34 y=190 line=16 layer="message6"]
[font color="0xFF8080"]移動[resetfont][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerNormalMoveModule'"]通常移動[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerAccelMoveModule'"]加速移動[endlink]
[r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerDecelMoveModule'"]減速移動[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerParabolaMoveModule'"]拋物線移動[endlink]
[r]
[font color="0xFF8080"]往返運動[resetfont][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerVibrateActionModule'"]振動動作[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerFallActionModule'"]落下動作[endlink]
[r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerJumpActionModule'"]上下振動[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerJumpOnceActionModule'"]單次上下振動[endlink]
[r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerWaveActionModule'"]左右振動[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerWaveOnceActionModule'"]單次左右振動[endlink]
[r]
[font color="0xFF8080"]縮放變形[resetfont][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerNormalZoomModule'"]單純縮放[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerVibrateZoomModule'"]縮放振動[endlink]
[r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerVRotateZoomModule'"]3D縱軸[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerHRotateZoomModule'"]3D橫軸[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerHeartBeatZoomModule'"]心跳[endlink]
[r]
[font color="0xFF8080"]旋轉[resetfont][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerNormalRotateModule'"]單純旋轉[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerVibrateRotateModule'"]旋轉振動[endlink]
[r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerFalldownRotateModule'"]旋轉倒下[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerToRotateModule'"]到指定角度[endlink]
[r]
[font color="0xFF8080"]漸變[resetfont][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerBlinkModeModule'"]閃爍效果[endlink] 
[link target=*關閉下拉菜單 exp="f.參數.module='LayerFadeModeModule'"]漸入漸出[endlink][r]
[link target=*關閉下拉菜單 exp="f.參數.module='LayerFadeToModeModule'"]改變透明度[endlink]
[s]

