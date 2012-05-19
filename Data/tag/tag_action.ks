;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=480 title="动态效果"]
[eval exp="drawFrame('基本信息',3,15,40,kag.fore.layers[5],314)"]
[line title="编号" name="f.参数.layer" x=30 y=60 type=list target="*选择图层"]
[line title="时间" name="f.参数.time" x=30 y=90]
[line title="延迟" name="f.参数.delay" x=30 y=120]

[eval exp="drawFrame('效果设定',5,15,175,kag.fore.layers[5],314)"]
[line title="效果" name="f.参数.module" x=30 y=190 type=list target="*选择效果"]
;----------------------------------------------------------------------------------------------
;移动动作组
[if exp="f.参数.module=='LayerNormalMoveModule' || f.参数.module=='LayerAccelMoveModule' || f.参数.module=='LayerDecelMoveModule'"]
[line title="目标坐标" x=30 y=220]
[pos valuex="f.参数.x" valuey="f.参数.y" x=45 y=250]
[endif]
[if exp="f.参数.module=='LayerParabolaMoveModule'"]
[line title="顶点坐标" x=30 y=220]
[pos valuex="f.参数.x" valuey="f.参数.y" x=45 y=250]
[line title="顶点时间" name="f.参数.toptime" x=30 y=310]
[endif]
;----------------------------------------------------------------------------------------------
;往返运动动作组
[if exp="f.参数.module=='LayerVibrateActionModule'"]
[line title="振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="间隔时间" name="f.参数.waittime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFallActionModule'"]
[line title="落下设定" x=30 y=220]
[line title="距离" name="f.参数.distance" x=30 y=250]
[line title="时间" name="f.参数.falltime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerJumpActionModule' || f.参数.module=='LayerJumpOnceActionModule' || f.参数.module=='LayerWaveActionModule' || f.参数.module=='LayerWaveOnceActionModule'"]
[line title="振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="周期时间" name="f.参数.cycle" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;放大，缩小动作组
[if exp="f.参数.module=='LayerNormalZoomModule' || f.参数.module=='LayerHeartBeatZoomModule'"]
[line title="缩放设定" x=30 y=220]
[line title="放大率" name="f.参数.zoom" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVRotateZoomModule' || f.参数.module=='LayerHRotateZoomModule'"]
[line title="3D变形设定" x=30 y=220]
[line title="角速度" name="f.参数.angvel" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVibrateZoomModule'"]
[line title="缩放振动设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="间隔时间" name="f.参数.waittime" x=30 y=280]
[endif]
;----------------------------------------------------------------------------------------------
;旋转动作组
[if exp="f.参数.module=='LayerNormalRotateModule'"]
[line title="旋转设定" x=30 y=220]
[line title="角速度" name="f.参数.angvel" x=30 y=250]
[endif]

[if exp="f.参数.module=='LayerVibrateRotateModule'"]
[line title="振动旋转设定" x=30 y=220]
[line title="振幅" name="f.参数.vibration" x=30 y=250]
[line title="周期时间" name="f.参数.cycle" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFalldownRotateModule' || f.参数.module=='LayerToRotateModule'"]
[line title="指定角度" x=30 y=220]
[line title="角度" name="f.参数.angle" x=30 y=250]
[endif]
;----------------------------------------------------------------------------------------------
;渐变动作组
[if exp="f.参数.module=='LayerBlinkModeModule'"]
[line title="闪烁设定" x=30 y=220]
[line title="显示时间" name="f.参数.showtime" x=30 y=250]
[line title="消失时间" name="f.参数.hidetime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFadeModeModule'"]
[line title="渐变设定" x=30 y=220]
[line title="渐入时间" name="f.参数.intime" x=30 y=250]
[line title="渐出时间" name="f.参数.outtime" x=30 y=280]
[endif]

[if exp="f.参数.module=='LayerFadeToModeModule'"]
[line title="透明设定" x=30 y=220]
[line title="透明度" name="f.参数.opacity" x=30 y=250]
[endif]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
;-----------------------------------------------------------------
*选择图层
[list_layer x=34 y=50]
[s]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message6"]
[er]
[layopt layer="message6" visible="false"]
[jump target=*window]
;-----------------------------------------------------------------
*选择效果
[commit]
[list x=34 y=190 line=17 layer="message6"]
[font color="0xFF8080"]移動[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalMoveModule'"]通常移動[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerAccelMoveModule'"]加速移動[endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerDecelMoveModule'"]減速移動[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerParabolaMoveModule'"]放物線移動[endlink]
[r]
[font color="0xFF8080"]振動[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateActionModule'"]振動[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFallActionModule'"]落下[endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerJumpActionModule'"]縦ゆれ[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerJumpOnceActionModule'"]縦ゆれ（単発）[endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerWaveActionModule'"]横ゆれ[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerWaveOnceActionModule'"]横ゆれ（単発）[endlink]
[r]
[font color="0xFF8080"]拡大縮小[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalZoomModule'"]単純拡大[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateZoomModule'"]ズーム振動[endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVRotateZoomModule'"]3D回転（縦軸）[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerHRotateZoomModule'"]3D回転（横軸）[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerHeartBeatZoomModule'"]ハートビート[endlink]
[r]
[font color="0xFF8080"]回転[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerNormalRotateModule'"]単純回転[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerVibrateRotateModule'"]回転振動[endlink]
[r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFalldownRotateModule'"]転倒[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerToRotateModule'"]指定角度へ[endlink]
[r]
[font color="0xFF8080"]モード[resetfont][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerBlinkModeModule'"]点滅処理[endlink] 
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFadeModeModule'"]フェード[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.module='LayerFadeToModeModule'"]不透明度変更[endlink]
[s]

