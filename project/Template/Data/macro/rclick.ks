*隱藏對話框
[history enabled="false"]
[rclick enabled="false"]
[hidemes]
[rclick enabled="true" jump="true" storage="rclick.ks" target=*顯示對話框]
[eval exp="kag.leftClickHook.add(onLeftClick)"]
[s]

*顯示對話框
[eval exp="kag.leftClickHook.remove(onLeftClick)"]
[showmes]
[history enabled="true"]
[rclick enabled="true" call="true" storage="rclick.ks" target=*隱藏對話框]
[eval exp="tf.clicked=System.getTickCount()"]
[return]
