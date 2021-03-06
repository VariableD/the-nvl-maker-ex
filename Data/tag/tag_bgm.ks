;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="播放音乐"]
[line title="文件" name="f.参数.storage" x=30 y=50 type="music"]
[line title="渐入时间" name="f.参数.time" x=30 y=80]
[line title="交叉时间" name="f.参数.overlap" x=30 y=110]
[check title="循环" name="f.参数.loop" x=30 y=140]
[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]
