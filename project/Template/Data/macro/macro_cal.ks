;用於顯示和選擇日曆的工具
;-----------------------------------------------------------------------------------------
;創建一個虛擬date，設定時間，根據返回值創建時間格
;-----------------------------------------------------------------------------------------
[iscript]
//f.test=new Date(2011,0,1);//0代表一月，1代表2月……
//while(f.test.getMonth()==0)
//{
//	dm(f.test.getDate());
//	f.test.setTime(f.test.getTime() + (+1) * 24 * 60 * 60 * 1000);
//}
//描繪一個月的日曆
function drawCal(year,month)
{
//kag.tagHandlers.image(%["storage" => "white","visible" => true,"left"=>0,"top"=>0,"layer"=>"base","page"=>"fore"]);
   
	month=month-1;
	var calender=new Date(year,month,1);
	var x;
	var y=100;
	var date=1;
	
	var color;
	
	while(calender.getMonth()==month)
	{
		x=70+calender.getDay()*120;
		
		kag.tagHandlers.locate(
		  %[
			"x" => x,
			"y" => y
		  ]);
		  
		if (calender.getDay()==0 || calender.getDay()==6) color=0xFF0000;
		else color=0x000000;
		
	 	drawDay(year,month,calender.getDate(),color);
	 	calender.setTime(calender.getTime() + (+1) * 24 * 60 * 60 * 1000);
	 	
		if (calender.getDay()==0) y+=120;
		if (y==120*5+100) y=100;
	}

	
}
function drawDay(year,month,date,color)
{  
	var mybutton=new Dictionary();
	mybutton.normal="sample_off";
	if (color==0xFF0000) mybutton.over="sample_on";
	
	//將選擇的日期計入字典
	mybutton.exp="f.chooseday=%["
	+"\"year\"=>"+year+","
	+"\"month\"=>"+(month+1)+","
	+"\"date\"=>"+date+"]";
	
	kag.tagHandlers.button(mybutton);
	
	//日曆上描繪日期
	var button=kag.current.links[kag.current.links.count-1].object;
	button.font.height=25;
	var x=25;
	var y=25;
	button.drawText(x,y,date,color,255,true);
	button.drawText(x+button.width,y,date,color,255,true);
	button.drawText(x+button.width*2,y,date,color,255,true);
}

//drawCal(2011,6);

[endscript]
;[s]

[return]
