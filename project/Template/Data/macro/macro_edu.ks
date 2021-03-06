;------------------------------------------------------------
;养成游戏专用宏
;和地图相同
;背景板显示在layer 7上
;按钮显示在message 1层上
;可刷新的数值显示面板显示在layer 9上
;------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//载入.edu文件
//------------------------------------------------------------
function loadedu(name)
{
//创建数组类并读入关键字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //载入背景
   kag.tagHandlers.image(%["storage" => dic[0]["bgd"],"visible" => true,"left"=>0,"top"=>0,"layer"=>"7","page"=>"back"]);
   
   //读取空白底图
   kag.back.layers[9].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);
   
////循环描绘按钮-------------------------------------------------------------------------------
   for (var i=1;i<11;i++)
   {
   //定义按钮位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   
   //创建按钮用字典
   var edubutton = new Dictionary();
   //取得数据
   edubutton["normal"]=dic[i]["normal"];
   edubutton["over"]=dic[i]["over"];
   edubutton["on"]=dic[i]["on"];
   edubutton["storage"]=dic[i]["storage"];
   edubutton["target"]=dic[i]["target"];
   edubutton["exp"]=dic[i]["exp"];
   
   edubutton["enterse"]=dic[i]["enterse"];
   edubutton["clickse"]=dic[i]["clickse"];
   
   //假如有条件，取得条件表达式
   if (dic[i]["cond"]!=void) edubutton["cond"]=dic[i]["cond"];
   
       //该据点在本地图上使用到
       if (dic[i]["use"]==1)
      {
           //满足条件
           if (Scripts.eval(edubutton["cond"])==true) kag.tagHandlers.button(edubutton);
           //或者无需条件
           if (edubutton["cond"]==void) kag.tagHandlers.button(edubutton);
      }
      
      
   }
//
// //-------------------------------------------------------------------------------
 
   //循环描绘文字
   for (var i=11;i<21;i++)
   {
   
    var draw_layer = kag.back.layers[9];

	draw_layer.font.face=dic[i].fontname;
	draw_layer.font.bold=dic[i].bold;
	draw_layer.font.height=dic[i].size;
	
	var sha=dic[i].shadow;
	var shac=dic[i].shadowcolor;
	var edg=dic[i].edge;
	var edgc=dic[i].edgecolor;
	
	var color=dic[i].color;
	var text=Scripts.eval(dic[i].flagname);
	
	var x=dic[i].x;
	var y=dic[i].y;

	//将文字对应成预渲染文字（默认）
	if ((global.useconfigMappfont) && (f.setting.mapp_def!=void))
	{
	  draw_layer.font.mapPrerenderedFont(f.setting.mapp_def);
	}

       //该据点在本地图上使用到
       if (dic[i]["use"]==1)
      {
           //满足条件
           if (Scripts.eval(dic[i]["cond"])==true)  
		   {
			  if (sha) {draw_layer.drawText(x,y,text,color, 255, true, 255, shac, 0, 2, 2);}
			  else if (edg) {draw_layer.drawText(x,y,text,color, 255, true, 255, edgc, 1, 0, 0);}
			  else {draw_layer.drawText(x,y,text,color, 255, true);}
		   }
           //或者无需条件
           if (dic[i]["cond"]==void)   
		   {
			  if (sha) {draw_layer.drawText(x,y,text,color, 255, true, 255, shac, 0, 2, 2);}
			  else if (edg) {draw_layer.drawText(x,y,text,color, 255, true, 255, edgc, 1, 0, 0);}
			  else {draw_layer.drawText(x,y,text,color, 255, true);}
		   }
      }
 
   }
   //-------------------------------------------------------------------------------
      //循环描绘图形
   for (var i=21;i<31;i++)
   {

     if (dic[i].pic!=void && dic[i]["use"]==1)
     {
       //图形的情况，创建图形用字典
        var edupic = new Dictionary();
        
              edupic["layer"]="9";
              edupic["page"]="back";
      
              edupic["dx"]=dic[i].x;
              edupic["dy"]=dic[i].y;
              
              edupic["storage"]=dic[i].pic;
              
              if (Scripts.eval(dic[i]["cond"])==true) kag.tagHandlers.pimage(edupic);
              if (dic[i]["cond"]==void)  kag.tagHandlers.pimage(edupic);
     
     }
     else if (dic[i].pic==void && dic[i]["use"]==1)
     {
         //假如是数字的情况
          if (Scripts.eval(dic[i]["cond"])==true) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"9","back",dic[i].x,dic[i].y);
          if (dic[i]["cond"]==void) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"9","back",dic[i].x,dic[i].y);  
     }
     
   }
   
   //-------------------------------------------------------------------------------
}
}
[endscript]
;------------------------------------------------------------
;显示养成面板
;------------------------------------------------------------
[macro name=edu]
[rclick enabled="false"]
[backlay]
;隐藏一般对话层
[layopt layer="message0" page="back" visible="false"]
;隐藏系统按钮层
[layopt layer="message2" page="back" visible="false"]
[position page="back" layer="message1" frame="empty" color="0xFFFFFF" opacity=0 left=0 top=0]
[layopt layer="message1" page="back" visible="true"]
[current layer="message1" page="back"]
[er]
;显示按钮
[eval exp=&"'loadedu(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|500]
[wt]
[s cond="mp.waitclick"]
[endmacro]

;------------------------------------------------------------
;清除面板
;------------------------------------------------------------
[macro name=cledu]
[backlay]
[freeimage layer=7 page="back"]
[freeimage layer=9 page="back"]
[current layer="message1" page="back"]
[er]
[layopt layer="message1" page="back" visible="false"]
;恢复对话框与系统按钮
[layopt layer="message0" visible="true" page=back]
[layopt layer="message2" visible="true" page="back"]
[trans * method=%method|crossfade time=%time|500]
[wt]
;返回对话
[current layer="message0"]
[rclick enabled="true"]
[endmacro]
;------------------------------------------------------------

[iscript]
//------------------------------------------------------------
//显示数字图片
//------------------------------------------------------------
function drawnum(flagname,num,sp=20,layer="9",page="back",x=0,y=0) //数值，图片，字间距，所在层,x,y
{

   //分析处理变数;
   var str=(string)flagname;
   //循环描绘数值;
   for (var i=0;i<str.length;i++)
   {
           kag.tagHandlers.pimage(
           %[
              "layer"=>layer,
              "page"=>page,
              "storage"=>num+str[i],
              "dx"=> (int)x+(int)i*sp,
              "dy"=> (int)y
           ]);
   
   }

}
[endscript]
;------------------------------------------------------------
;描绘数字显示的宏
;------------------------------------------------------------
;使用范例
;@draw_num num=&"f.test" pic="num-" x=100 y=150
[macro name=draw_num]
[eval exp="drawnum(mp.num,mp.pic,mp.sp,mp.layer,mp.page,mp.x,mp.y)"]
[endmacro]

[return]
