*隐藏对话框
[history enabled="false"]
[rclick enabled="false"]
[hidemes]
[rclick enabled="true" jump="true" storage="rclick.ks" target=*显示对话框]
[eval exp="kag.leftClickHook.add(onLeftClick)"]
[s]

*显示对话框
[eval exp="kag.leftClickHook.remove(onLeftClick)"]
[showmes]
[history enabled="true"]
[rclick enabled="true" call="true" storage="rclick.ks" target=*隐藏对话框]
[eval exp="tf.clicked=System.getTickCount()"]
[return]
