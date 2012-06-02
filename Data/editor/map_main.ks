;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;地图编辑
;---------------------------------------------------------------
[eval exp="drawPageBoard(285)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮
[if exp="sf.project!=void"]
[frame title="地图" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建地图]
[eval exp="drawButtonCaption('新建地图',16)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打开地图]
[eval exp="drawButtonCaption('打开地图',16)"]
[endif]

[frame title="养成" line=1 x=15 y=90]
[locate x=50 y=115]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建面板]
[eval exp="drawButtonCaption('新建面板',16)"]

[locate x=190 y=115]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打开面板]
[eval exp="drawButtonCaption('打开面板',16)"]
[endif]

[frame title="数据库" line=1 x=15 y=165]
[locate x=50 y=190]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*词典编辑]
[eval exp="drawButtonCaption('词典编辑',16)"]
[locate x=190 y=190]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*道具编辑]
[eval exp="drawButtonCaption('道具编辑',16)"]
[s]

*新建地图
;清空地图名
[eval exp="tf.mapname=void"]
[input name="tf.mapname" title="新規作成" prompt="ファイル名（拡張子なし）：        "]
;假如有输入地图名，开始创建新地图
[iscript]
if (tf.mapname!=void)
{

if (Storages.isExistentStorage(sf.path+"map/"+tf.mapname+".map"))
{
   System.inform("既に同名のファイルが存在しています。");
}
else
{
   var array=Scripts.evalStorage("temp_Map.tjs");

   for (var i=1;i<16;i++)
   {
      var dic=new Dictionary();
      dic.normal=array[0].normal;
      dic.over=array[0].over;
      dic.on=array[0].on;
      dic.use=0;
      dic.x=i*50;
      dic.y=100;
      dic.place="場所"+(int)(i);
      array.add(dic);
   }
   //保存
   var path=sf.path+"map/"+tf.mapname+".map";
   array.saveStruct(path);
   System.inform("地図を作成しました","新規作成");
}
}
[endscript]
[jump storage="map_main.ks"]

*打开地图
[iscript]
f.mapname=void;
f.list=getsozai("map","map");
tf.当前编辑值="f.mapname";
[endscript]
[call storage="window_file.ks"]
;假如选择了地图，打开
[if exp="f.mapname!=void"]
[eval exp="f.config_map=Scripts.evalStorage(sf.path+'map/'+f.mapname)"]
[jump storage="gui_map.ks"]
[endif]

[jump storage="map_main.ks"]


*新建面板
;清空面板名
[eval exp="tf.eduname=void"]
[input name="tf.eduname" title="新規作成" prompt="ファイル名（拡張子なし）：       "]
;假如有输入面板名，开始创建新面板
[iscript]
if (tf.eduname!=void)
{

if (Storages.isExistentStorage(sf.path+"map/"+tf.eduname+".edu"))
{
   System.inform("既に同名のファイルが存在しています。");
}
else
{
   var array=Scripts.evalStorage("temp_Edu.tjs");

   for (var i=1;i<11;i++)
   {
   
      var dic=new Dictionary();
      
      dic.normal=array[0].normal;
      dic.over=array[0].over;
      dic.on=array[0].on;
      
      dic.use=0;
      dic.x=(i)*50;
      dic.y=100;
      dic.name="ボタン"+(int)(i);
      array.add(dic);
   }
   
    for (var i=11;i<21;i++)
   {
   
      var dic=new Dictionary();

      dic.use=0;
      dic.x=(i-11)*50;
      dic.y=200;
      dic.name="文字"+(int)(i-10);
      dic.size=f.setting.font.size;
      dic.color=f.setting.font.color;
      
      array.add(dic);
   }
 
     for (var i=21;i<31;i++)
   {
   
      var dic=new Dictionary();
      
      dic.num=array[0].num;
      dic.space=array[0].space;
      
      dic.use=0;
      dic.x=(i-21)*50;
      dic.y=300;
      dic.name="画像"+(int)(i-20);
      array.add(dic);
   }
   
   //保存
   var path=sf.path+"map/"+tf.eduname+".edu";
   array.saveStruct(path);
   System.inform("パネルを作成しました","新規作成");
   
}
}
[endscript]
[jump storage="map_main.ks"]

*打开面板
[iscript]
f.eduname=void;
f.list=getsozai("edu","map");
tf.当前编辑值="f.eduname";
[endscript]
[call storage="window_file.ks"]
;假如选择了面板，打开
[if exp="f.eduname!=void"]
[eval exp="f.config_edu=Scripts.evalStorage(sf.path+'map/'+f.eduname)"]
[jump storage="gui_edu.ks"]
[endif]

[jump storage="map_main.ks"]

*词典编辑
;启动软件
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'DicEditor.exe')"]
[jump storage="map_main.ks"]

*道具编辑
;启动软件
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'tool/') + 'ItemEditor.exe')"]
[jump storage="map_main.ks"]
