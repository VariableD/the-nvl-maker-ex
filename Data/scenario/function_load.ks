;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;搜索及讀入文件夾下的文件,縮略圖列表
;-----------------------------------------------------------------------------------
[iscript]
//---------------------------------------------------------------
//讀取某文件夾下文件名
//---------------------------------------------------------------
function getfile(path)
{
  var list = getDirList(Storages.getLocalName(sf.path+path+"/")+"/");
  return list;
}
//---------------------------------------------------------------
//讀取其他類文件名(連同擴展名)[類型，位置]
//---------------------------------------------------------------
function getsozai(type,path)
{
  var list=getfile(path);
  var file=[];
     for (var i=0;i<list.count;i++)
   {
      //取得擴展名
      var ext=Storages.extractStorageExt(list[i]);
      var chop=Storages.chopStorageExt(list[i]);
      dm(ext);
      //根據不同類型，返回需求的文件全名
      switch (type)
      {
        //劇本檔
        case "ks":
             if (ext=='.ks') file.add(list[i]);
             break;
        //鼠標
        case "cur":
             if (ext=='.cur') file.add(list[i]);
             if (ext=='.ani') file.add(list[i]);
             break;
       case "map":
             if (ext=='.map') file.add(list[i]);
             break;
       case "edu":
             if (ext=='.edu') file.add(list[i]);
             break;
       case "bgm":
             if (ext=='.ogg') file.add(chop);
             if (ext=='.mp3') file.add(chop);
             if (ext=='.wav') file.add(chop);
             if (ext=='.mid') file.add(chop);
             break;
       case "se":
             if (ext=='.ogg') file.add(chop);
             if (ext=='.mp3') file.add(chop);
             if (ext=='.wav') file.add(chop);
             break;
      }
   }
   file.sort('a');
   return file;
}
//---------------------------------------------------------------
//讀取圖片類文件名(不要擴展名)[位置]
//---------------------------------------------------------------
function getpic(path)
{
   var list=getfile(path);
   var file=[];
   for (var i=0;i<list.count;i++)
   {
      var ext=Storages.extractStorageExt(list[i]);
      dm(ext);
      //將圖片讀入
                 switch (ext)
            {
                case ".png":
                case ".jpg":
                case ".tlg":
                case ".bmp":
                case ".eri":
                file.add(Storages.chopStorageExt(list[i]));
                break;
           }
   }
   //按照文件名順序排列圖片
   file.sort('a');
   return file;
}
//---------------------------------------------------------------
//讀入圖片縮略圖
//---------------------------------------------------------------
function loadpic(path)
{

     //描繪文件夾名
       with(kag.fore.event)
      {
         //文字
         .font.height=18;
         .fillRect(110,90,210,40,0xFFFFFFFF);
         .drawText(120,100,path+"文件夾讀取完畢", 0x000000);
         .update();
       }
       
   var list=getpic(path);
   var files=[];
   
    //取得文件名及縮略圖
      for (var i=0;i<list.count;i++)
   {
        files[i]=new Dictionary();
        files[i].name=list[i];
        files[i].layer=new Layer(kag, kag.fore.base);
        
        //臨時圖層
        var temp=new Layer(kag, kag.fore.base);
        temp.loadImages(sf.path+path+"/"+files[i].name);
        temp.setSizeToImageSize();
		
        var zw=temp.width;
        var zh=temp.height;
		 
        //設定縮略圖比例
        if ((zw > 240) && (temp.height/temp.width)<=0.75)
        {
            zw=240;
            zh=zw*temp.height/temp.width;
        }
        else if ((zh > 180) && (temp.height/temp.width)>0.75)
        {
            zh=180;
            zw=zh*temp.width/temp.height;
        }
        
       //將圖片縮放複製到層上
       files[i].layer.width=240;
       files[i].layer.height=180;
	   
       files[i].layer.stretchCopy(0, 0, zw, zh, temp, 0, 0, temp.width, temp.height, stNearest);
   }
   
   return files;
}
[endscript]
;-----------------------------------------------------------------------------------
;搜索及讀入遊戲工程
;-----------------------------------------------------------------------------------
[iscript]
//---------------------------------------------------------------
//檢查工程合法性
//---------------------------------------------------------------
function checkProject(fold)
{
   var result=true;
   //設定路徑
   var path=System.exePath + "project/"+fold+"/Data/macro/";
   //所有配置文件是否存在
   if (!Storages.isExistentStorage(path+'setting.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uisave.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uiload.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uislpos.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uihistory.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uioption.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uititle.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'uimenu.tjs')) result=false;
   if (!Storages.isExistentStorage(path+'namelist.tjs')) result=false;
   return result;
}
//---------------------------------------------------------------
//讀取project文件夾下的遊戲工程
//---------------------------------------------------------------
function getProject()
{
   var list=getDirList(Storages.getLocalName(System.exePath + "project/")+"/");
   f.project=[];
   f.title=[];
   for (var i=0;i<list.count;i++)
   {
      if (list[i].indexOf('/')!=-1 && list[i].charAt(0)!='.') 
      {
         var fold=list[i].substring(0,list[i].length-1);
         var path=System.exePath + "project/"+fold+"/Data/";
         if (checkProject(fold))
         {
            //添加工程文件夾名
            f.project.add(fold);
            //添加遊戲名
            var setting=Scripts.evalStorage(path+"macro/"+'setting.tjs');
            f.title.add(setting.title);
         }
      }   
   }

//計算頁數
countPage(f.project.count,10);
}

//---------------------------------------------------------------
//讀取遊戲工程全設定
//---------------------------------------------------------------
function getConfig()
{

	
	//建立字典
	var setting=Scripts.evalStorage(sf.path+"macro/"+'setting.tjs');
	
	//取得必要信息
	//讀入Config.tjs
	var cont;
	cont=loadScript(sf.path+"Config.tjs");
	
	for (var i=0;i<cont.count;i++)
	{
		//標題
		if (cont[i].indexOf(";System.title")!=-1) setting.title=getConfigElm(cont[i]);
		//窗口大小
		if (cont[i].indexOf(";scWidth")!=-1) setting.width=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";scHeight")!=-1) setting.height=(int)getConfigElm(cont[i]);
		
		//存檔部分
		if (cont[i].indexOf(";numBookMarks")!=-1) setting.savedata.num=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";thumbnailWidth")!=-1) setting.savedata.thumbnailwidth=(int)getConfigElm(cont[i]);
		
		//默認字體部分
		if (cont[i].indexOf(";userFace")!=-1) setting.font.face=getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultFontSize")!=-1) setting.font.size=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultChColor")!=-1) setting.font.color=getConfigElm(cont[i]);
		
		if (cont[i].indexOf(";defaultShadowColor")!=-1) setting.font.shadowcolor=getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultEdgeColor")!=-1) setting.font.edgecolor=getConfigElm(cont[i]);
		
		if (cont[i].indexOf(";global.useconfigMappfont")!=-1) setting.usemappfont=(int)getConfigElm(cont[i]);
		
		//歷史記錄部分
		if (cont[i].indexOf(";fontName")!=-1) setting.history.face=getConfigElm(cont[i]);
		if (cont[i].indexOf(";fontBold")!=-1) setting.history.bold=getConfigElm(cont[i]);
		if (cont[i].indexOf(";fontHeight")!=-1) setting.history.size=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";lineHeight")!=-1) setting.history.linespace=(int)getConfigElm(cont[i]);

	}
	//返回信息
	return setting;
	
}

//取得一行內的信息
function getConfigElm(line)
{
	var arr=line.split(';',,true);
	var elm=arr[0].split("=",,true);
	
	var re = new RegExp("\"","g");
	elm[1]=elm[1].replace(re,"");
	
	if (elm[1]=="true") return 1;
	else if (elm[1]=="false") return 0;
	
	return elm[1].trim();
}

function getSetting()
{
	f.setting=getConfig();

	 //根據設定改變分辨率
	if (f.setting.width!=void) sf.gs.width=f.setting.width;
	if (f.setting.height!=void) sf.gs.height=f.setting.height;

	//確保大小正確
	if (sf.gs.width<800) sf.gs.width=800;
	if (sf.gs.height<600) sf.gs.height=600;
             
	f.config_dia=Scripts.evalStorage(sf.path+"macro/"+'uidia.tjs');
	f.config_option=Scripts.evalStorage(sf.path+"macro/"+"uioption.tjs");
	f.config_history=Scripts.evalStorage(sf.path+"macro/"+"uihistory.tjs");
	f.config_slpos=Scripts.evalStorage(sf.path+"macro/"+"uislpos.tjs");
	f.config_save=Scripts.evalStorage(sf.path+"macro/"+"uisave.tjs");
	f.config_load=Scripts.evalStorage(sf.path+"macro/"+"uiload.tjs");
	
	f.config_title=Scripts.evalStorage(sf.path+"macro/"+"uititle.tjs");
	f.config_menu=Scripts.evalStorage(sf.path+"macro/"+"uimenu.tjs");
	
	f.config_name=Scripts.evalStorage(sf.path+"macro/"+"namelist.tjs");
              
}
[endscript]
;-----------------------------------------------------------------------------------
;自動路徑
;-----------------------------------------------------------------------------------
[iscript]
function AddPath()
{
//------------------------------------------
//添加自動路徑:圖片，音樂素材
Storages.addAutoPath(sf.path+"bgimage/");
Storages.addAutoPath(sf.path+"fgimage/");
Storages.addAutoPath(sf.path+"rule/");
Storages.addAutoPath(sf.path+"face/");
Storages.addAutoPath(sf.path+"image/");
Storages.addAutoPath(sf.path+"others/");
Storages.addAutoPath(sf.path+"bgm/");
Storages.addAutoPath(sf.path+"sound/");
Storages.addAutoPath(sf.path+"voice/");
Storages.addAutoPath(sf.path+"video/");
Storages.addAutoPath(sf.path+"map/");
//Storages.addAutoPath(sf.path+"macro/");
}

function RemovePath()
{
Storages.removeAutoPath(sf.path+"bgimage/");
Storages.removeAutoPath(sf.path+"fgimage/");
Storages.removeAutoPath(sf.path+"rule/");
Storages.removeAutoPath(sf.path+"face/");
Storages.removeAutoPath(sf.path+"image/");
Storages.removeAutoPath(sf.path+"others/");
Storages.removeAutoPath(sf.path+"bgm/");
Storages.removeAutoPath(sf.path+"sound/");
Storages.removeAutoPath(sf.path+"voice/");
Storages.removeAutoPath(sf.path+"video/");
Storages.removeAutoPath(sf.path+"map/");
//Storages.removeAutoPath(sf.path+"macro/");
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
