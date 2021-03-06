;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;预处理
;--------------------------------------------------
[iscript]
//将各层位置代入f.config_slpos.locate
for (var i=0;i<f.config_slpos.locate.count;i++)
{
  f.config_slpos.locate[i][0]=f.uilayer[i+7].left;
  f.config_slpos.locate[i][1]=f.uilayer[i+7].top;
}
//参数处理
f.参数=new Dictionary();
f.参数.num=f.config_slpos.locate.count;
f.参数.locate=[];
f.参数.locate.assign(f.config_slpos.locate);
[endscript]
;--------------------------------------------------
;档案设定
;档案数
;每个位置
;--------------------------------------------------
*window
[window_middle width=800 height=600 title="档案设定"]
[line title="每页" name="f.参数.num" x=30 y=50] [link target=*设定数量 hint="不超过30个且不超过总档案个数"]設定[endlink]
;根据数量设定locate
[iscript]
for (var i=0;i<f.参数.num;i++)
{
   if (f.参数.locate[i]==void)
  {
     f.参数.locate[i]=[];
     f.参数.locate[i][0]="0";
     f.参数.locate[i][1]="0";
   }
   //描绘text框
   if (i<15)
   {
     drawEdit((i*1+1)+" 左端位置 ","f.参数.locate["+i+"][0]",30,80*1+i*30,120);
     drawEdit("y","f.参数.locate["+i+"][1]",180,80*1+i*30,100);
   }
   else
   {
     drawEdit((i*1+1)+" 左端位置 ","f.参数.locate["+i+"][0]",320,80*1+(i-15)*30,120);
     drawEdit("y","f.参数.locate["+i+"][1]",470,80*1+(i-15)*30,100);
   }
}
//将多余删除
f.参数.locate.count=f.参数.num;
[endscript]
[s]

*设定数量
[commit]
[iscript]
if ((int)f.参数.num<1) f.参数.num=1;
if ((int)f.参数.num>30) f.参数.num=30;
if ((int)f.参数.num>(int)f.setting.savedata.num) f.参数.num=(int)f.setting.savedata.num;
[endscript]
[jump target=*window]

*确认
[commit]
[iscript]
f.config_slpos.locate.assign(f.参数.locate);
[endscript]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
