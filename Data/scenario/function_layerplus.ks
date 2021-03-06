;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------
;特殊描绘:使用/不使用设定(+标签自定义)
;--------------------------------------------------------------
[iscript]
function drawSLsetting(title,layer,x,y,target)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       if (target!=void)
       {
         //空格
          kag.tagHandlers.ch(%["text"=>" "]);
         //连接
          var setting=new Dictionary();
          setting.target=target;
          setting.hint="点此打开详细设定窗口";
          kag.tagHandlers.link(setting);
          //方块
          kag.tagHandlers.ch(%["text"=>"□"]);
          kag.tagHandlers.endlink(%[]);
       }
}
[endscript]
;-----------------------------------------------------------------------------------
;界面设定用的显示层2-SL系统用
;包含：
;只有位置显示的上下翻按钮及返回按钮
;悬停显示的图片位置
;悬停显示的文字位置
;独立ＳＬ按钮（上面会根据样式描绘文字并可以刷新）
;-----------------------------------------------------------------------------------
;SL按钮
;-----------------------------------------------------------------------------------
[iscript]
class uiSLButton extends uiButtonLayer
{
   var normal;
   var over;
   var on;
   var num;
   
   function uiSLButton(num)
   {
      super.Layer(kag, parent);
      //图象
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      //编号
      this.num=num;
      //载入图片
	  loadImages(normal);
      setSizeToImageSize();
      
	  //根据locate显示位置
	  left=f.config_slpos.locate[num][0];
	  top=f.config_slpos.locate[num][1];
	  visible=true;
	  
	  hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
   }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,color="normal")
  {
    this.loadImages(state);
    this.setSizeToImageSize();
    //默认字体
    this.font.face=f.setting.font.face;
    this.font.bold=f.config_slpos.pagefont.bold;
    this.font.italic=f.config_slpos.pagefont.italic;
    var sha=f.config_slpos.pagefont.shadow;
    var shac=f.config_slpos.pagefont.shadowcolor;
    var edg=f.config_slpos.pagefont.edge;
    var edgc=f.config_slpos.pagefont.edgecolor;
    
    //默认颜色
    var color1=f.config_sl.num.normal;
    var color2=f.config_sl.bookmark.normal;
    var color3=f.config_sl.date.normal;
    var color4=f.config_sl.history.normal;
    
//其他颜色
if (color=="over")
{
       color1=f.config_sl.num.over;
       color2=f.config_sl.bookmark.over;
       color3=f.config_sl.date.over;
       color4=f.config_sl.history.over;
}
if (color=="on")
{
       color1=f.config_sl.num.on;
       color2=f.config_sl.bookmark.on;
       color3=f.config_sl.date.on;
       color4=f.config_sl.history.on;
}
//--------------------------------------------
    if (f.config_slpos.num.use)
{
    //描绘档案名
   this.font.height=f.config_slpos.num.height;
   
   var mapp=f.setting.mapp_num;
   if (mapp!=void) this.font.mapPrerenderedFont(mapp);
   
   var x=(int)f.config_slpos.num.x;
   var y=(int)f.config_slpos.num.y;
   var str=f.config_slpos.num.pre+(num*1+1)+f.config_slpos.num.after;
   if (sha) drawText(x,y, str, color1,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color1,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color1);
 }
 //--------------------------------------------
    if (f.config_slpos.bookmark.use)
{
    //描绘章节名
   this.font.height=f.config_slpos.bookmark.height;
   
   var mapp=f.setting.mapp_label;
   if (mapp!=void) this.font.mapPrerenderedFont(mapp);   
   
   var x=(int)f.config_slpos.bookmark.x;
   var y=(int)f.config_slpos.bookmark.y;
   var str="第"+num+"章 見出し";
   if (sha) drawText(x,y, str, color2,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color2,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color2);
 }
 //--------------------------------------------
    if (f.config_slpos.date.use)
{
    //描绘日期
   this.font.height=f.config_slpos.date.height;
   
   var mapp=f.setting.mapp_date;
   if (mapp!=void) this.font.mapPrerenderedFont(mapp);   
   
   var x=(int)f.config_slpos.date.x;
   var y=(int)f.config_slpos.date.y;
   var str="0000/00/00 00:00";
   if (sha) drawText(x,y, str, color3,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color3,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color3);
 }
    if (f.config_slpos.history.use)
{
    //描绘对话记录
   this.font.height=f.config_slpos.history.height;
   
   var mapp=f.setting.mapp_talk;
   if (mapp!=void) this.font.mapPrerenderedFont(mapp);   
   
   var x=(int)f.config_slpos.history.x;
   var y=(int)f.config_slpos.history.y;
   var str="THE NVL Makerとは……";
   if (sha) drawText(x,y, str, color4,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color4,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color4);
 }
    if (f.config_slpos.smallsnap.use)
{
   //描绘按钮小截图
   var width=f.setting.savedata.thumbnailwidth;
   var height=width*3/4;
   fillRect(f.config_slpos.smallsnap.x,f.config_slpos.smallsnap.y,width,height,0xFFFFFFFF);
}

 //--------------------------------------------
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //---------------------------------------------------悬停---------------------------------------------------
   function onMouseEnter()
   {
      drawSelect(over,"over");

      if (f.config_sl.button.enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.enterse,
         "loop" => false
         ]);
      }

   }
   function onMouseLeave()
   {
      drawSelect(normal,"normal");
   }
   function onClick()
   {
      drawSelect(on,"on");

      if (f.config_sl.button.clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.clickse,
         "loop" => false
         ]);
      }

   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(num)
   {
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      this.num=num;
	  drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
;只有位置显示的上下翻按钮及返回按钮
;-----------------------------------------------------------------------------------
[iscript]
class uiSLLayer extends uiButtonLayer
{
    var normal;
    var over;
    var on;

    var enterse;
    var clickse;

   //---------------------------------------------------创建---------------------------------------------------
   function uiSLLayer(pic,pos)
   {
      super.Layer(kag, parent);
      //图象描绘
      normal=pic.normal;
      over=pic.over;
      on=pic.on;

      //音声读取
      enterse=pic.enterse;
      clickse=pic.clickse;

      //位置
      left=pos[0];
      top=pos[1];
      visible=pos[2];
      hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
      drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
      function SLlayerElm()
   {
      var array=[];
      array[0]=this.left;
      array[1]=this.top;
      array[2]=this.visible;
      return array;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(pic)
   {
    this.normal=pic.normal;
    this.over=pic.over;
    this.on=pic.on;
    this.drawSelect();
   }
}
[endscript]

;-----------------------------------------------------------------------------------
;悬停显示的图片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiSnapLayer extends uiLayer
{
  //---------------------------------------------------创建---------------------------------------------------
  function uiSnapLayer(elm)
  {
        super.Layer(kag, parent);
        width=f.setting.savedata.thumbnailwidth;
        height=width*3/4;
        fillRect(0,0,width,height,0xFFFFFFFF);
		left=elm.x;
		top=elm.y;
		visible=elm.visible;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
    //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
    width=f.setting.savedata.thumbnailwidth;
    height=width*3/4;
    fillRect(0,0,width,height,0xFFFFFFFF);
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //---------------------------------------------------输出---------------------------------------------------
      function SnapElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.visible=this.visible;
      return dic;
   }
}
[endscript]

;-----------------------------------------------------------------------------------
;悬停显示的文字位置
;-----------------------------------------------------------------------------------
[iscript]
class uiTextLayer extends uiLayer
{
var str;
var color;
var mapp;
 //---------------------------------------------------创建---------------------------------------------------
  function uiTextLayer(str,elm,color,mapp)
  {
        super.Layer(kag, parent);
        font.height=elm.size;
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		
    //字体
    font.face=f.setting.font.face;//字体名字
    font.bold=f.config_slpos.pagefont.bold;
    font.italic=f.config_slpos.pagefont.italic;
    this.str=str;
    this.color=color;

     this.mapp=mapp;
     
	//假如对应预渲染文字
	if (mapp!=void) 
	{
		dm("有对应预渲染字体："+mapp);
		font.mapPrerenderedFont(mapp);
	}
	
    //取得宽度
    width=this.font.getTextWidth(str);
    height=this.font.getTextHeight(str);
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
 //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {

    //取得宽度
    width=this.font.getTextWidth(str);
    height=this.font.getTextHeight(str);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (f.config_slpos.pagefont.shadow)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.shadowcolor,0,2,2);
    }
    else if (f.config_slpos.pagefont.edge)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, str,color);
    }
     //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
 //---------------------------------------------------重设---------------------------------------------------
 function Reset(color)
 {
       this.color=color;
       drawSelect();
 }
 //---------------------------------------------------输出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      dic.size=this.font.height;
      return dic;
 }
}
[endscript]

;-----------------------------------------------------------------------------------
;悬停显示的图片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiCgThumLayer extends uiLayer
{
  //---------------------------------------------------创建---------------------------------------------------
  function uiCgThumLayer(elm)
  {
        super.Layer(kag, parent);

        loadImages(f.config_cgmode.thum.normal);
        setSizeToImageSize();
        
        fillRect(0,0,width,height,0xFFFFFFFF);
        
		left=elm[0];
		top=elm[1];
		visible=true;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
    //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
  
    width=this.width;
    height=this.height;
    
    fillRect(0,0,width,height,0xFFFFFFFF);
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }

}
[endscript]
;-----------------------------------------------------------------------------------
[return]
