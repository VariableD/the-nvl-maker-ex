;------------------------------------------------------------
;物品系统专用宏
;------------------------------------------------------------
[iscript]

f.abc=[
"测试1",
"测试2",
"测试3",
"测试4",
"测试5",
"测试6",
"测试7",
"测试8",
"测试9",
"测试10",
"测试11",
"测试12",
];

function draw_item()
{
	//描绘底板
//	var layer=kag.fore.layers[15];
//	layer.width=100;
//	layer.height=100;
//	layer.fillRect(0,0,100,100,0xFFFFFF,0);
	//layer.visible=true;
	kag.tagHandlers.image(%["storage" => "empty","visible" => true,"left"=>0,"top"=>0,"layer"=>"15","page"=>"fore"]);
	//写字
	kag.fore.layers[15].font.height=25;
	
	dm("页数："+f.index);
	
	for (var i=0;i<6;i++)
	{
		if (f.index+i>=f.abc.count) break;
		
		kag.fore.layers[15].drawText(100,100+i*25,f.abc[f.index+i],0xFFFFFF);
		dm(f.abc[f.index+i]);
	}

}

f.index=0;
[endscript]
;------------------------------------------------------------
[return]
