;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;腳本編輯器的行操作
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------
;快捷鍵操作
;------------------------------------------------------------
;ALL FOR SCRIPT
[iscript]
function ScriptKey(key, shift)
{
   if (f.window!="script") return false;
   //刪除
   if (key==VK_DELETE)
   {
         deleteLine();
   }
   //選中上一行
   else if (key==VK_UP)
   {
           if (f.當前腳本行>0)
        {
           f.當前腳本行--;
           if (f.索引行>f.當前腳本行) f.索引行--;
           updateScript();
         }
   }
   //選中下一行
   else if (key==VK_DOWN)
   {
           if (f.當前腳本行<f.script.count-1)
        {
           f.當前腳本行++;
           if (f.索引行+24<f.當前腳本行) f.索引行++;
           updateScript();
         }
   }
   //剪切
   else if (key==VK_X && shift==ssCtrl)
   {
          cutLine();
          kag.process("gui_script.ks","*window");
   }   
   //複製
   else if (key==VK_C && shift==ssCtrl)
   {
          tf.複製行=copyLine();
          kag.process("gui_script.ks","*window");
   }
   //粘貼
   else if (key==VK_V && shift==ssCtrl)
   {
         pasteLine(tf.複製行);
   }
   //新增
   else if (key==VK_N && shift==ssCtrl)
   {
         insertLine();
   }
   //return false;
}
// 押下時登錄
//如果沒有添加過鍵盤鉤子，添加
if (tf.hookloaded==false) kag.keyDownHook.add(ScriptKey);
tf.hookloaded=true;
[endscript]
;------------------------------------------------------------
;函數
;------------------------------------------------------------
[iscript]

//---------------------------------------------------------------------
//將字典轉為編輯用格式
//---------------------------------------------------------------------
function dictoForm(dic)
{
   var arr=[];
   arr[0]=dic.tagname;
   var elm=[];
   //將對照表複製成數組
   elm.assign(dic);
           for (var i=0;i<elm.count;i+=2)
        {
           if (elm[i]!="tagname") arr.add(%["elm"=>elm[i],"value"=>elm[i+1]]);
        }
    return arr;
}
//---------------------------------------------------------------------
//將編輯完的參數格式轉為字典
//---------------------------------------------------------------------
function formtoDic(form)
{
    var dic=%[];
    dic.tagname=form[0];
for (var i=1;i<form.count;i++)
{
   if (form[i].elm!=void && form[i].value!=void)
   {
       dic[form[i].elm]=form[i].value;
   }
}
    return dic;
}
//---------------------------------------------------------------------
//將字典寫入當前行
//---------------------------------------------------------------------
function commitLine(dic)
{
    //複製
    f.script[f.當前腳本行]=dic;
    f.腳本顯示[f.當前腳本行]=expLine(dic);
}
//---------------------------------------------------------------------
//處理4-編輯器用多行文本寫入
//---------------------------------------------------------------------
function spiltLine()
{
    var text=f.文本框.text.split('\r\n',,true);
    if (text.count>0)
   {
     //循環添加自動符號
      for (var i=0;i<text.count;i++)
       {
         var line=text[i];
         if (f.參數.autor==true && text[i].charAt(0)!="[" &&  text[i].charAt(0)!="@") line+="[lr]";
         else if (f.參數.autow==true && text[i].charAt(0)!="[" && text[i].charAt(0)!="@") line+="[w]";
         text[i]=line;
       }
       return text;
   }
   else return [""];
}

function multiLine(text)
{
   //參數寫入第一行
   f.參數=%[];
   f.參數.tagname="_msg";
   f.參數.text=text[0];
   commitLine(f.參數);
   
   //附加多行
      if (text.count>1)
   {
      //循環寫入
      for (var i=1;i<text.count;i++)
      {
         var line=text[i];
         f.參數=%[];
         f.參數.tagname="_msg";
         f.參數.text=text[i];
         //下方加入一行
         addLine(f.參數);
      }
   }

}
//---------------------------------------------------------------------
//增加一行(下方)
//---------------------------------------------------------------------
function addLine(dic=%["tagname"=>"_blank"])
{
//假如不是最後一行，加在下方
  if (f.當前腳本行<f.script.count-1)
 {
   f.script.insert(f.當前腳本行+1,dic);
   f.腳本顯示.insert(f.當前腳本行+1,expLine(dic));
   //重新選中增加的那行
   f.當前腳本行++;
   if (f.當前腳本行>f.索引行+24) f.索引行++;
   updateScript();
 }
//假如是最後一行，加在上方
 else
 {
    insertLine(dic);
 }
}
//---------------------------------------------------------------------
//增加一行（上方）
//---------------------------------------------------------------------
function insertLine(dic=%["tagname"=>"_blank"])
{
   f.script.insert(f.當前腳本行,dic);
   f.腳本顯示.insert(f.當前腳本行,expLine(dic));
    updateScript();
}
//---------------------------------------------------------------------
//刪除一行
function deleteLine()
{
//刪除的不是最後一行
    if (f.當前腳本行!=f.script.count-1)
  {
     f.script.erase(f.當前腳本行);
     f.腳本顯示.erase(f.當前腳本行);
     updateScript();
   }
}
//---------------------------------------------------------------------
//複製一行
function copyLine()
{
   var tagname=f.script[f.當前腳本行].tagname;
   
   //不是末尾行，返回行內容
   if (tagname!="_end")
   {
     return f.script[f.當前腳本行];
   }
   //是末尾行，返回空
   else
   {
      return void;
   }
}

//---------------------------------------------------------------------
//粘貼一行(在選中行位置)
function pasteLine(line)
{
//假如存在粘貼對像
   if (line!=void)
   {
        insertLine(line);
   }
}
//---------------------------------------------------------------------
//剪切一行
function cutLine()
{
      //複製
      tf.複製行=copyLine();
      //刪除
      deleteLine();
}
[endscript]
;------------------------------------------------------------------------------------------------
[return]
