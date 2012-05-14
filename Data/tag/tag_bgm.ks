;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="播放音樂"]
[line title="文件" name="f.參數.storage" x=30 y=50 type="music"]
[line title="漸入時間" name="f.參數.time" x=30 y=80]
[line title="交叉時間" name="f.參數.overlap" x=30 y=110]
[check title="循環" name="f.參數.loop" x=30 y=140]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]

*選擇音聲
[call storage="window_bgm.ks"]
[jump target=*window]
