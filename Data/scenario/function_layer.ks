;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;界面设定用的显示层(拖拽移动等效果及界面编辑窗口控件)
;-----------------------------------------------------------------------------------
[iscript]
//描绘伪历史记录
function demoHistory()
{
     //描绘边框
     var x1=f.config_history.marginl;
     var x2=f.setting.width-f.config_history.marginr;
     var y1=f.config_history.margint;
     var y2=f.setting.height-f.config_history.marginb;
    
     var width=x2-x1;
     var height=y2-y1;
     
     kag.fore.layers[4].fillRect(x1,y1,width,1,0xCCFFFFFF);
     kag.fore.layers[4].fillRect(x1,y2,width,1,0xCCFFFFFF);
     kag.fore.layers[4].fillRect(x1,y1,1,height,0xCCFFFFFF);
     kag.fore.layers[4].fillRect(x2,y1,1,height,0xCCFFFFFF);
     
    var text_x=x1+5;
    var text_y=y1+10;
    var text="白框内为历史记录显示范围";
    var text_color=f.setting.font.color;

     if (f.setting.mapp_his!=void) 
     {
     		kag.fore.layers[4].font.mapPrerenderedFont(f.setting.mapp_his);
     }
     
     	kag.fore.layers[4].drawText(text_x,text_y,text,text_color);
     	text_y+=(int)f.setting.history.linespace;
     	kag.fore.layers[4].drawText(text_x,text_y,text,text_color);
     
     	kag.fore.layers[4].font.unmapPrerenderedFont();
       
//      //描绘用数组
//      var setting=new Dictionary();
//      //取得配置表里的值
//	(Dictionary.assign incontextof setting)(f.config_history.font);
//	
//	setting.layer="4";
//	setting.page="fore";
//	setting.color=f.setting.font.color;
//	
//	setting.face=f.setting.history.face;
//	setting.bold=f.setting.history.bold;
//	
//	setting.size=f.setting.history.size;
//	
//	setting.x=f.config_history.marginl+5;
//	setting.y=f.config_history.margint+5;
//	
//	//
//
//	setting.text="";
//	kag.tagHandlers.ptext(setting);
//	
//	setting.text="白框内为历史记录显示范围";
//	kag.tagHandlers.ptext(setting);
//	
//	setting.y+=(int)f.setting.history.linespace;
//	kag.tagHandlers.ptext(setting);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘-显示,隐藏对话框
;--------------------------------------------------------------
[iscript]
function drawView(title,layer,posX,posY,target)
{

//添加用语字典
title=LanguageDic(title);

  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+6]);
  var result=layer!.visible;
  //值为真
  if (result==true)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_visible",
    "exp"=>layer+".visible=false",
    "target"=>"*window"
    ]);
  }
  //值为假
  else if (result==false)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_invisible",
    "exp"=>layer+".visible=true",
    "target"=>"*window"
    ]);
  }
  //描绘提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  //描绘设定link
if (target!=void) 
  {     //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target=target;
        setting.hint="点此打开对话框详细设定窗口";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
    }
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:地图按钮设定
;--------------------------------------------------------------
[iscript]
function drawMapButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint="点此打开地图据点设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:系统按钮设定
;--------------------------------------------------------------
[iscript]
function drawButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint="点此打开按钮详细设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:滑动槽设定
;--------------------------------------------------------------
[iscript]
function drawSliderSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*滑动槽设定";
        setting.hint="点此打开滑动槽详细设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".SliderElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;自定义用于调整窗口margin的层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class getMarginLayer extends Layer
{
   //左上/右下点坐标定义
   var x1;
   var y1;
   var x2;
   var y2;
   //是否拖动中
   var pick;
   //父层
   var parent=kag.fore.layers[8];
   var frame;
   
function finalize() 
{
	this.visible=false;
	super.finalize(...);
}
//创建层
      function getMarginLayer(frame)
  {
     super.Layer(kag, parent);
     left=0;
	 top=0;
	 this.frame=frame;
	 loadImages(frame);
	 setSizeToImageSize();
	 
	 x1=f.参数.marginl;
	 y1=f.参数.margint;
	 x2=this.width-f.参数.marginr;
	 y2=this.height-f.参数.marginb;
	 
	 drawMargin();
	 visible=true;
	 
	 hitType = htMask;
	 hitThreshold =0;

  }
//按下
   function onMouseDown(x, y, button, shift)
{
   if (button==mbLeft)
   {
     x1=this.cursorX;
     y1=this.cursorY;
     pick=true;
     drawMargin();
    }
}
//抬起
function onMouseUp(x, y, button, shift)
{
   if (button==mbLeft)
   {
      pick=false;
      drawMargin();
    }
}
//移动
  function onMouseMove(x, y, shift)
  {
    if (pick)
    {
        x2=this.cursorX;
        y2=this.cursorY;
        drawMargin();
    }
  }
//描绘
   function drawMargin()
   {
	 loadImages(frame);
     var width=x2-x1;
     var height=y2-y1;
     fillRect(x1,y1,width,1,0xFFFF0000);
     fillRect(x1,y2,width,1,0xFFFF0000);
     fillRect(x1,y1,1,height,0xFFFF0000);
     fillRect(x2,y1,1,height,0xFFFF0000);
     drawMarginXY();
   }

//坐标
function drawMarginXY()
{
   with(kag.fore.layers[7])
   {
      .fillRect(sf.gs.width+55,75,120,80,0xFFD4D0C8);
      .font.height=18;
      .drawText(sf.gs.width+55,75,"marginl = "+x1 , 0x000000);
      .drawText(sf.gs.width+55,95,"marginr = "+(width-x2) , 0x000000);
      .drawText(sf.gs.width+55,115,"margint = "+y1 , 0x000000);
      .drawText(sf.gs.width+55,135,"marginb = "+(height-y2) , 0x000000);
   }
}
//输出
   function MarginElm()
   {
      f.参数.marginl=x1;
      f.参数.margint=y1;
      f.参数.marginr=this.width-x2;
      f.参数.marginb=this.height-y2;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;自定义的用于界面设定的层-总类
;传入参数为字典类
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiLayer extends Layer
{
  //是否选中
  var select=false;
  //是否拖拽中
  var pick=false;
  //和鼠标游标的相对距离
  var disX;
  var disY;
  //图片
  var frame;
  //父层
  var parent=kag.fore.layers[4];
  //---------------------------------------------------创建---------------------------------------------------
  function uiLayer(elm)
  {
     	super.Layer(kag, parent); 
		frame=elm.frame;     
		loadImages(frame);
		setSizeToImageSize();
		left=elm.left;
		top=elm.top;
		visible=true;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------消除---------------------------------------------------
   function finalize() 
   {
      this.visible=false;
      super.finalize(...);
   }
  //---------------------------------------------------按下---------------------------------------------------
  function onMouseDown(x, y, button, shift)
  {
     if (button==mbLeft)
     {

        disX=this.cursorX;
        disY=this.cursorY;
        setselect();
        drawSelect();
        pick=true;
      //描绘坐标
      drawXY();
     }
   }
   //---------------------------------------------------抬起---------------------------------------------------
  function onMouseUp(x, y, button, shift)
  {
     if (button==mbLeft)
     {
        pick=false;
      }
   }
 //---------------------------------------------------拖动---------------------------------------------------
  function onMouseMove(x, y, shift)
  {
    if (pick && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
    {
      this.left=kag.fore.base.cursorX-parent.left-disX;
      this.top=kag.fore.base.cursorY-parent.top-disY;
      //描绘坐标
      drawXY();
    }
  }
 //---------------------------------------------------键盘---------------------------------------------------
 function onKeyDown(key, shift)
 {
   if (select && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
   {
      if (key==VK_LEFT && shift==void) left--;
      if (key==VK_RIGHT && shift==void) left++;
      if (key==VK_UP && shift==void) top--;
      if (key==VK_DOWN && shift==void) top++;
      
      if (key==VK_LEFT && shift==ssRepeat) left--;
      if (key==VK_RIGHT && shift==ssRepeat) left++;
      if (key==VK_UP && shift==ssRepeat) top--;
      if (key==VK_DOWN && shift==ssRepeat) top++;
      
      if (key==VK_LEFT && shift==ssShift) left-=10;
      if (key==VK_RIGHT && shift==ssShift) left+=10;
      if (key==VK_UP && shift==ssShift) top-=10;
      if (key==VK_DOWN && shift==ssShift) top+=10;
      drawXY();
   }
 }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
    this.loadImages(frame);
    this.setSizeToImageSize();
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+70,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+70,565, "("+left+","+top+")", 0x000000);
 }
}
   //---------------------------------------------------选中---------------------------------------------------
   function setselect()
   {
      //所有层全部unset
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
      this.select=true;
      this.drawSelect();
      this.focus();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.left=this.left;
      dic.top=this.top;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;scroll层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiScrollLayer extends uiLayer
{
    var width;
    var height;
    var normal;
    var over;
   //---------------------------------------------------创建---------------------------------------------------
   function uiScrollLayer(elm)
   {
           	super.Layer(kag, parent);
              //loadImages("empty");
              //setSizeToImageSize();
           	left=elm.x;
           	top=elm.y;
           	height=elm.height;
           	width=elm.width;
           	setSize(width, height);
   
           	normal=elm.normal;
           	over=elm.over;
           	
           	visible=elm.use;
              hitType = htMask;
		hitThreshold =0;
		focusable=true;
           	drawSelect();
   }
   //---------------------------------------------------描绘---------------------------------------------------
   function drawSelect()
   {

       //底	
       fillRect(0,0,width,height,0xCCFFFFFF);
     	//按钮层
        var tabImage=new global.Layer(window, parent);
        
        tabImage.loadImages(normal);
        tabImage.setSizeToImageSize();
        var twidth  = tabImage.width;
        var theight = tabImage.height;
        operateRect(0, height-theight, tabImage, 0, 0, twidth, theight);
        
            //假如选中,带边框
            if (select)
         {
              fillRect(0,0,width,1,0xCCFF0000);
              fillRect(0,0,1,height,0xCCFF0000);
              fillRect(0,height-1,width,1,0xCCFF0000);
              fillRect(width-1,0,1,height,0xCCFF0000);
          }
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.height=elm.height;
    this.width=elm.width;
    this.left=elm.x;
    this.top=elm.y;
    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ScrollElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      dic.normal=this.normal;
      dic.over=this.over;
      dic.height=this.height;
      dic.width=this.width;
      
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带有拖动按钮(伪)的slider层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiSliderLayer extends uiLayer
{
   var base;
   var normal;
   var over;
   var on;
  //---------------------------------------------------创建---------------------------------------------------
  function uiSliderLayer(elm)
  {
     	super.Layer(kag, parent);
     	base=elm.base;
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		//复制图片层及按钮
              drawSelect();

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal)
  {
  //清空图层
    fillRect(0,0,width,height,0x00FFFFFF);
    //重载数据
        var baseImage=new global.Layer(window, parent);
        baseImage.loadImages(base);
        baseImage.setSizeToImageSize();
        width= baseImage.width;
        height=baseImage.height;
        this.operateRect(0, 0, baseImage, 0, 0, width, height);
        
        var tabImage=new global.Layer(window, parent);
        tabImage.loadImages(state);
        tabImage.setSizeToImageSize();
        var twidth  = tabImage.width;
        var theight = tabImage.height;
        this.operateRect((width - twidth) / 2, (height - theight) / 2, tabImage, 0, 0, twidth, theight);
    //假如选中,带边框
    if (select)
    {
      fillRect(0,0,width,1,0xCCFF0000);
      fillRect(0,0,1,height,0xCCFF0000);
      fillRect(0,height-1,width,1,0xCCFF0000);
      fillRect(width-1,0,1,height,0xCCFF0000);
    }
  }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.base=elm.base;
    this.left=elm.x;
    this.top=elm.y;
    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function SliderElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.base=this.base;
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.use=this.visible;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带有margin数据输出的对话框层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiMessageLayer extends uiLayer
{
var marginl;
var marginr;
var margint;
var marginb;
  //---------------------------------------------------创建---------------------------------------------------
  function uiMessageLayer(elm)
  {
    super.uiLayer(elm);
    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;
  }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;
    this.left=elm.left;
    this.top=elm.top;
    this.frame=elm.frame;
    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function MessageElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.frame=this.frame;
      dic.left=this.left;
      dic.top=this.top;
      dic.marginl=this.marginl;
      dic.marginr=this.marginr;
      dic.margint=this.margint;
      dic.marginb=this.marginb;
      return dic;
   }
}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的伪按钮层,输出x,y,normal,over,on,use(visible)
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiButtonLayer extends uiLayer
{
var normal;
var over;
var on;
var enterse;
var clickse;

  //---------------------------------------------------创建---------------------------------------------------
  function uiButtonLayer(elm)
  {
     	super.Layer(kag, parent); 
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		loadImages(normal);
		setSizeToImageSize();
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		
		enterse=elm.enterse;
		clickse=elm.clickse;
		
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal)
  {
    this.loadImages(state);
    this.setSizeToImageSize();
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
      drawSelect(over);

      if (enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => enterse,
         "loop" => false
         ]);
      }

   }
   function onMouseLeave()
   {
      drawSelect(normal);
   }
   function onClick()
   {
      drawSelect(on);

      if (clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => clickse,
         "loop" => false
         ]);
      }
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;

      dic.x=this.left;
      dic.y=this.top;

      dic.use=this.visible;

      dic.enterse=this.enterse;
      dic.clickse=this.clickse;

      return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.left=elm.x;
    this.top=elm.y;
    this.enterse=elm.enterse;
    this.clickse=elm.clickse;
    this.drawSelect();
   }
}
[endscript]

;--------------------------------------------------------------------------------------------------------------
;带悬停效果的地图按钮层,输出x,y,normal,over,on,use(visible),place,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiMapButtonLayer extends uiLayer
{
var normal;
var over;
var on;

var place;
var storage;
var target;
var cond;
var exp;

var clickse;
var enterse;
  //---------------------------------------------------创建---------------------------------------------------
  function uiMapButtonLayer(elm)
  {
     	super.Layer(kag, parent); 
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		loadImages(normal);
		setSizeToImageSize();
		left=elm.x;
		top=elm.y;
		visible=elm.use;
    //附加参数
    place=elm.place;
    storage=elm.storage;
    target=elm.target;
    cond=elm.cond;
    exp=elm.exp;
    
    clickse=elm.clickse;
    enterse=elm.enterse;
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal)
  {
    this.loadImages(state);
    this.setSizeToImageSize();
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
      drawSelect(over);
      
      if (enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => enterse,
         "loop" => false
         ]);
      }
      
   }
   function onMouseLeave()
   {
      drawSelect(normal);
   }
   function onClick()
   {
      drawSelect(on);
      
      if (clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => clickse,
         "loop" => false
         ]);
      }
      
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      
      dic.place=this.place;
      dic.storage=this.storage;
      dic.target=this.target;
      dic.cond=this.cond;
      dic.exp=this.exp;
      
      dic.clickse=this.clickse;
      dic.enterse=this.enterse;
      
      return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.left=elm.x;
    this.top=elm.y;
    
    this.place=elm.place;
    this.storage=elm.storage;
    this.target=elm.target;
    this.cond=elm.cond;
    this.exp=elm.exp;
    
    this.clickse=elm.clickse;
    this.enterse=elm.enterse;
    
    this.drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
