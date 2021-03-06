;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------
;特殊描绘:edu图形设定
;--------------------------------------------------------------
[iscript]
function drawEduPicSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*图形设定";
        setting.hint="点此打开养成面板图形&数值设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".PicElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:edu文字设定
;--------------------------------------------------------------
[iscript]
function drawEduTextSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*文字设定";
        setting.hint="点此打开养成面板文字设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".TextElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:edu按钮设定
;--------------------------------------------------------------
[iscript]
function drawEduButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint="点此打开养成按钮设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]

;--------------------------------------------------------------------------------------------------------------
;可选择显示图形的面板x,y,name,use(visible),flagname,cond
;类型pic/num,数值演示图形num,字间距space
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduPicLayer extends uiLayer
{
var name;
var flagname;
var pic;
var num;
var space;
var cond;
var enterse;
var clickse;
  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
 //---------------------------------------------------创建---------------------------------------------------
   function uiEduPicLayer(name,elm)
  {
         super.Layer(kag, parent);

	  left=elm.x;
	  top=elm.y;
	  visible=elm.use;
	  
         this.name=name;
         this.flagname=elm.flagname;
         this.pic=elm.pic;
         this.num=elm.num;
         this.space=elm.space;
         this.cond=elm.cond;
         
         this.enterse=elm.enterse;
         this.clickse=elm.clickse;
         
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		
	drawSelect();
		
  }
 //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;
    
    //根据不同类型描绘演示图形或者描绘数字
    if (pic!=void)
    {
      loadImages(pic);
      setSizeToImageSize();
    }
    else
    {
      //读取数字图片大小
      var sizelayer=new global.Layer(window, parent);
      sizelayer.loadImages(num+0);
      sizelayer.setSizeToImageSize();
      
      this.width=space*3;
      this.height=sizelayer.height;
      
      //设定图层本身大小
      var sw=sizelayer.width;
      var sh=sizelayer.height;
      this.fillRect(0,0,width,height,0x00FFFFFF);
      
      //在图片上进行描绘
      this.operateRect(0, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+1);
      this.operateRect(space, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+2);
      this.operateRect(space*2, 0, sizelayer, 0, 0, sw, sh);
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
   //---------------------------------------------------输出---------------------------------------------------
   function PicElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.use=this.visible;
      
      dic.x=this.left;
      dic.y=this.top;

      dic.name=this.name;
      dic.flagname=this.flagname;
      dic.cond=this.cond;
      
      dic.pic=this.pic;
      dic.num=this.num;
      dic.space=this.space;
      
      dic.enterse=this.enterse;
      dic.clickse=this.clickse;
      
      return dic;

   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
   
   this.visible=elm.use;
   this.left=elm.x;
   this.top=elm.y;
   
   this.name=elm.name;
   this.flagname=elm.flagname;
   this.cond=elm.cond;
   
   this.pic=elm.pic;
   this.num=elm.num;
   this.space=elm.space;
   
   this.enterse=elm.enterse;
   this.clickse=elm.clickse;
   
    this.drawSelect();
   }
   
   

}
[endscript]
;--------------------------------------------------------------------------------------------------------------
;可选择文字描绘效果的面板x,y,name,use(visible),flagname,cond
;color,fontname,size,bold,shadow,shadowcolor,edge,edgecolor
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduTextLayer extends uiLayer
{

var name;
var flagname;
var fontname;
var size;
var color;
var bold;
var shadow;
var shadowcolor;
var edge;
var edgecolor;
var cond;
  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
 //---------------------------------------------------创建---------------------------------------------------
  function uiEduTextLayer(name,elm)
  {
        super.Layer(kag, parent);

	  left=elm.x;
	  top=elm.y;
	  visible=elm.use;
         this.name=elm.name;
         this.flagname=elm.flagname;
         this.cond=elm.cond;
         
         //工程下的默认设定读取
         fontname=f.setting.font.face;
         size=f.setting.font.size;
         color=f.setting.font.color;
         shadowcolor=f.setting.font.shadowcolor;
         edgecolor=f.setting.font.edgecolor;
         
        //文字层默认值设定
         this.font.face=f.setting.font.face;
         this.font.height=f.setting.font.size;

        //改变设定
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor; 
        
    //取得宽度
    width=this.font.getTextWidth(name);
    height=this.font.getTextHeight(name);
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
 //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;
    
    this.font.face=fontname;
    this.font.height=size;
    this.font.bold=bold;

    //取得宽度
    width=this.font.getTextWidth(name);
    height=this.font.getTextHeight(name);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (shadow)
    {
      drawText(0,0, name, color,255,true,255,shadowcolor,0,2,2);
    }
    else if (edge)
    {
      drawText(0,0, name, color,255,true,255,edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, name,color);
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
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
        name=elm.name;
        left=elm.x;
        top=elm.y;
        flagname=elm.flagname;
        cond=elm.cond;
     
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor;
        
    this.drawSelect();
   }
 //---------------------------------------------------输出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.use=this.visible;
      
      dic.x=this.left;
      dic.y=this.top;

      dic.name=this.name;
      dic.flagname=this.flagname;
      dic.cond=this.cond;
      
      dic.fontname=this.fontname;      
      dic.size=this.size;
      dic.color=this.color;
      
      dic.bold=this.bold;
      dic.shadow=this.shadow;
      dic.shadowcolor=this.shadowcolor;
      dic.edge=this.edge;
      dic.edgecolor=this.edgecolor;
      
      return dic;
      
 }
}
[endscript]

;--------------------------------------------------------------------------------------------------------------
;带悬停效果的养成按钮层,输出x,y,normal,over,on,use(visible),name,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduButtonLayer extends uiLayer
{
var normal;
var over;
var on;

var name;
var storage;
var target;
var cond;
var exp;

var enterse;
var clickse;

  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
 with(kag.fore.layers[3])
 {
   .font.height=18;
   .fillRect(sf.gs.width+230,565,100,20,0xFFD4D0C8);
   .drawText(sf.gs.width+230,565, "("+left+","+top+")", 0x000000);
 }
}
  //---------------------------------------------------创建---------------------------------------------------
  function uiEduButtonLayer(elm)
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
    name=elm.name;
    storage=elm.storage;
    target=elm.target;
    cond=elm.cond;
    exp=elm.exp;

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
      
      dic.name=this.name;
      dic.storage=this.storage;
      dic.target=this.target;
      dic.cond=this.cond;
      dic.exp=this.exp;

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
    
    this.name=elm.name;
    this.storage=elm.storage;
    this.target=elm.target;
    this.cond=elm.cond;
    this.exp=elm.exp;

    this.enterse=elm.enterse;
    this.clickse=elm.clickse;
      
    this.drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
