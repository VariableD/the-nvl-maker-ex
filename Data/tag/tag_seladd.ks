*window
[window_middle width=500 height=420 title="添加选项"]
[iscript]
drawFrame("按钮参数",3,15,40,kag.fore.layers[5],314);

drawFrame("执行操作",3,15,180,kag.fore.layers[5],314);

[endscript]

[line title="选项文字" name="f.参数.text" x=30 y=60]
[line title="显示条件" name="f.参数.eval" x=30 y=90  type="cond"]
[line title="已选变数" name="f.参数.onceflag" x=30 y=120]

;[line title="一般" name="f.参数.normal" x=30 y=90 type="pic" path="others"]
;[line title="选中" name="f.参数.over" x=30 y=120 type="pic" path="others" copyfrom="f.参数.normal"]
;[line title="按下" name="f.参数.on" x=30 y=150 type="pic" path="others" copyfrom="f.参数.over"]
;[line title="选中SE" name="f.参数.enterse" x=30 y=180 type="sound"]
;[line title="按下SE" name="f.参数.clickse" x=30 y=210 type="sound"]

[line title="标签" name="f.参数.target" x=30 y=200]
[line title="文件" name="f.参数.storage" x=30 y=230 type="script"]
[line title="表达式" name="f.参数.exp" x=30 y=260]


[s]

*确认
[commit]
[iscript]
//防止出错用——假如参数开头不是星号，强制加入星号
if (f.参数.target!=void && f.参数.target[0]!="*") f.参数.target="*"+f.参数.target;
[endscript]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]
