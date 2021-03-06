;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
f.参数.elsif1=false;
f.参数.elsif2=false;
f.参数.else=false;
[endscript]

*window
[window_middle width=400 height=330 title="创建分歧"]
[line title="条件" name="f.参数.exp" type="cond" x=30 y=50]

[check title="继续分歧" name="f.参数.elsif1" x=30 y=80]
[line true="f.参数.elsif1" title="条件" name="f.参数.exp1" type="cond" x=30 y=110]

[check title="继续分歧" name="f.参数.elsif2" x=30 y=140]
[line true="f.参数.elsif2" title="条件" name="f.参数.exp2" type="cond" x=30 y=170]

[check title="加入默认分歧的情况" name="f.参数.else" x=30 y=200]

[s]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*确认
[commit]
;[eval exp="commitLine(f.参数)"]
[iscript]
if (f.参数.exp!=void)
{
	//开始分歧
	var dic=%[];
	dic.tagname="if";
	dic.exp=f.参数.exp;
	commitLine(dic);

	//继续分歧
	if (f.参数.elsif1)
	{
		var dic=%[];
		dic.tagname="elsif";
		dic.exp=f.参数.exp1;
		
		addLine(dic);
	}
	//继续分歧
	if (f.参数.elsif2)
	{
		var dic=%[];
		dic.tagname="elsif";
		dic.exp=f.参数.exp2;
		
		addLine(dic);
	}
	
	//默认分歧
	if (f.参数.else)
	{
		var dic=%[];
		dic.tagname="else";		
		addLine(dic);
	}

	//分歧结束
	var dic=%[];
	dic.tagname="endif";
	addLine(dic);

}
[endscript]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
