;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="登錄CG"]
[line title="文件" name="f.參數.storage" x=30 y=60 type="pic" path="bgimage"]
[s]

*確認
[commit]
[eval exp="commitLine(f.參數)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*關閉選單
[jump storage="tag_direct.ks" target=*關閉選單]
;-----------------------------------------------------------------
*選擇圖片
[call storage="window_picture.ks"]
[jump target=*window]
