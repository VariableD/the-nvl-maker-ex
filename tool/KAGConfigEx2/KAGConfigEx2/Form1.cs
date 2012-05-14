using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Collections;
using System.Text.RegularExpressions;
using System.Runtime.InteropServices;

namespace KAGConfigEx2
{
    public partial class Form1 : Form
    {
        string config_file_name;
        string[] args;

        public Form1(string[] args)
        {
            this.args = args;
            InitializeComponent();
        }

        //拖動文件處理
        private void Form1_DragEnter(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.All;
        }

        private void Form1_DragOver(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.All;
        }

        private void Form1_DragDrop(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop, false))
            {
                String[] files = (String[])e.Data.GetData(DataFormats.FileDrop);
                //
                //MessageBox.Show(files[0]);
                //取得文件名
                if (Path.GetFileName(files[0]) == "Config.tjs")
                {
                    //記錄文件名並載入config.tjs
                    config_file_name = files[0];
                    loadTjs(config_file_name);
                    tabControl1.Enabled = true;
                    button1.Enabled = true;
                    label19.Text = config_file_name;
                    
                }

            }
        }

        //讀取config.tjs並進行處理
        private void loadTjs(string filename)
        {
            StreamReader objReader = new StreamReader(filename);
            string sLine = "";
            ArrayList arrText = new ArrayList();

            while (sLine != null)
            {
                sLine = objReader.ReadLine();
                if (sLine != null)
                    arrText.Add(sLine);
            }
            objReader.Close();

            foreach (string sOutput in arrText)
            {
                Regex exp = new Regex("^;");
                //判斷讀入的是否是參數（行頭有;）
                if (exp.IsMatch(sOutput))
                {
                    getelm(sOutput);
                }  
                
            }

        }

        //寫入函數
        private ArrayList writeTjs(string filename)
        {
            StreamReader objReader = new StreamReader(filename);
            string sLine = "";
            ArrayList arrText = new ArrayList();

            while (sLine != null)
            {
                sLine = objReader.ReadLine();
                if (sLine != null)
                    arrText.Add(sLine);
            }
            objReader.Close();

            for (int i=0;i<arrText.Count;i++)
            {
                string sOutput = arrText[i].ToString();

                Regex exp = new Regex("^;");
                //判斷讀入的是否是參數（行頭有;）
                if (exp.IsMatch(sOutput))
                {
                    arrText[i]=setelm(sOutput);
                }

            }

            //返回值
            return arrText;

        }

        //寫入參數
        private string setelm(string line)
        {
            //拆分處理
            Regex r = new Regex(";|=");
            string[] s = r.Split(line);

            string a = s[1].Trim();
            string b = s[2].Trim();

            #region 根據能識別的參數名進行處理

            switch (a)
            {
                case "System.title":
                    b = "\"" + title + "\"";
                    break;
                case "global.useconfigMappfont":
                    b = useconfigMappfont.ToString();
                    break;
                case "global.configMappfont":
                    b = "\"" + configMappfont + "\"";
                    break;
                case "scWidth":
                    b = scWidth.ToString();
                    break;
                case "scHeight":
                    b = scHeight.ToString();
                    break;
                case "readOnlyMode":
                    b = readOnlyMode.ToString();
                    break;
                case "freeSaveDataMode":
                    b = freeSaveDataMode.ToString();
                    break;
                case "saveThumbnail":
                    b = saveThumbnail.ToString();
                    break;
                case "thumbnailWidth":
                    b = thumbnailWidth.ToString();
                    break;
                case "thumbnailDepth":
                    b = thumbnailDepth.ToString();
                    break;
                //savedata所在位置，如果有特殊路徑參數，則不加引號
                case "saveDataLocation":
                    if (saveDataLocation.Contains(".")) b = saveDataLocation;
                    else b = "\"" + saveDataLocation + "\"";
                    break;
                case "dataName":
                    b =  "\"" + dataName + "\"";
                    break;
                case "saveDataID":
                    b =  "\"" + saveDataID + "\"";
                    break;
                case "saveDataMode":
                    b =  "\"" + saveDataMode + "\"";
                    break;
                case "saveMacros":
                    b = saveMacros.ToString();
                    break;

                case "chSpeeds.fast":
                    b = chSpeeds_fast.ToString();
                    break;
                case "chSpeeds.normal":
                    b = chSpeeds_normal.ToString();
                    break;
                case "chSpeeds.slow":
                    b = chSpeeds_slow.ToString();
                    break;

                case "autoModePageWaits.fast":
                    b = autoModePageWaits_fast.ToString();
                    break;
                case "autoModePageWaits.faster":
                    b = autoModePageWaits_faster.ToString();
                    break;
                case "autoModePageWaits.medium":
                    b =  autoModePageWaits_medium.ToString();
                    break;
                case "autoModePageWaits.slower":
                    b =  autoModePageWaits_slower.ToString();
                    break;
                case "autoModePageWaits.slow":
                    b =  autoModePageWaits_slow.ToString();
                    break;

                case "autoModeLineWaits.fast":
                    b = autoModeLineWaits_fast.ToString();
                    break;
                case "autoModeLineWaits.faster":
                    b = autoModeLineWaits_faster.ToString();
                    break;
                case "autoModeLineWaits.medium":
                    b = autoModeLineWaits_medium.ToString();
                    break;
                case "autoModeLineWaits.slower":
                    b = autoModeLineWaits_slower.ToString();
                    break;
                case "autoModeLineWaits.slow":
                    b = autoModeLineWaits_slow.ToString();
                    break;

                //鼠標文件是否為文件名
                case "cursorDefault":
                    if (cursorDefault.Contains(".")) b =  "\"" + cursorDefault + "\"";
                    else b = cursorDefault;
                break;
                case "cursorPointed":
                    if (cursorPointed.Contains(".")) b =  "\"" + cursorPointed + "\"";
                    else b = cursorPointed;
                break;
                case "cursorWaitingClick":
                    if (cursorWaitingClick.Contains(".")) b =  "\"" + cursorWaitingClick + "\"";
                    else b = cursorWaitingClick;
                break;
                case "cursorDraggable":
                    if (cursorDraggable.Contains(".")) b =  "\"" + cursorDraggable + "\"";
                    else b = cursorDraggable;
                break;

                case "autoRecordPageShowing":
                    b = autoRecordPageShowing.ToString();
                    break;
                case "recordHistoryOfStore":
                    b = recordHistoryOfStore.ToString();
                    break;
                case "maxHistoryOfStore":
                    b = maxHistoryOfStore.ToString();
                    break;
                case "quakeMessageLayer":
                    b = quakeMessageLayer.ToString();
                    break;

                case "numSEBuffers":
                    b = numSEBuffers.ToString();
                    break;
                case "numMovies":
                    b = numMovies.ToString();
                    break;
                case "numCharacterLayers":
                    b = numCharacterLayers.ToString();
                    break;
                case "scPositionX.left":
                    b = scPositionX_left.ToString();
                    break;
                case "scPositionX.left_center":
                    b = scPositionX_left_center.ToString();
                    break;
                case "scPositionX.center":
                    b = scPositionX_center.ToString();
                    break;
                case "scPositionX.right_center":
                    b = scPositionX_right_center.ToString();
                    break;
                case "scPositionX.right":
                    b = scPositionX_right.ToString();
                    break;

                case "numMessageLayers":
                    b = numMessageLayers.ToString();
                    break;
                case "initialMessageLayerVisible":
                    b = initialMessageLayerVisible.ToString();
                    break;
                case "numBookMarks":
                    b = numBookMarks.ToString();
                    break;
                case "showBookMarkDate":
                    b = showBookMarkDate.ToString();
                    break;
                case "showFixedPitchOnlyInFontSelector":
                    b = showFixedPitchOnlyInFontSelector.ToString();
                    break;
                case "helpFile":
                    b =  "\"" + helpFile + "\"";
                    break;
                case "aboutWidth":
                    b = aboutWidth.ToString();
                    break;
                case "aboutHeight":
                    b = aboutHeight.ToString();
                    break;
                case "autoLabelMode":
                    b = autoLabelMode.ToString();
                    break;
                case "autoLabelType":
                    b = autoLabelType.ToString();
                    break;
                case "defaultName":
                    b =  "\"" + defaultName + "\"";
                    break;
                case "defaultFamily":
                    b =  "\"" + defaultFamily + "\"";
                    break;
                case "menu.visible":
                    b = menu_visible.ToString();
                    break;
                case "rightClickMenuItem.visible":
                    b = rightClickMenuItem_visible.ToString();
                    break;
                case "showHistoryMenuItem.visible":
                    b = showHistoryMenuItem_visible.ToString();
                    break;
                case "skipToNextStopMenuItem.visible":
                    b = skipToNextStopMenuItem_visible.ToString();
                    break;
                case "autoModeMenuItem.visible":
                    b = autoModeMenuItem_visible.ToString();
                    break;
                case "autoModeWaitMenu.visible":
                    b = autoModeWaitMenu_visible.ToString();
                    break;
                case "goBackMenuItem.visible":
                    b = goBackMenuItem_visible.ToString();
                    break;
                case "goToStartMenuItem.visible":
                    b = goToStartMenuItem_visible.ToString();
                    break;
                case "characterMenu.visible":
                    b = characterMenu_visible.ToString();
                    break;
                case "chNonStopToPageBreakItem.visible":
                    b = chNonStopToPageBreakItem_visible.ToString();
                    break;
                case "ch2ndSpeedMenu.visible":
                    b = ch2ndSpeedMenu_visible.ToString();
                    break;
                case "ch2ndNonStopToPageBreakItem.visible":
                    b = ch2ndNonStopToPageBreakItem_visible.ToString();
                    break;
                case "chAntialiasMenuItem.visible":
                    b = chAntialiasMenuItem_visible.ToString();
                    break;
                case "chChangeFontMenuItem.visible":
                    b = chChangeFontMenuItem_visible.ToString();
                    break;
                case "restoreMenu.visible":
                    b = restoreMenu_visible.ToString();
                    break;
                case "storeMenu.visible":
                    b = storeMenu_visible.ToString();
                    break;
                case "displayMenu.visible":
                    b = displayMenu_visible.ToString();
                    break;
                case "helpMenu.visible":
                    b = helpMenu_visible.ToString();
                    break;
                case "helpIndexMenuItem.visible":
                    b = helpIndexMenuItem_visible.ToString();
                    break;
                case "helpAboutMenuItem.visible":
                    b = helpAboutMenuItem_visible.ToString();
                    break;
                case "debugMenu.visible":
                    b = debugMenu_visible.ToString();
                    break;

                case "layerType":
                    b = layerType.ToString();
                    break;
                case "frameGraphic":
                    b = "\""+frameGraphic+"\"";
                    break;
                case "frameColor":
                    b = frameColor.ToString();
                    break;
                case "frameOpacity":
                    b = frameOpacity.ToString();
                    break;
                case "marginL":
                    b = marginL.ToString();
                    break;
                case "marginT":
                    b = marginT.ToString();
                    break;
                case "marginR":
                    b = marginR.ToString();
                    break;
                case "marginB":
                    b = marginB.ToString();
                    break;
                case "ml":
                    b = ml.ToString();
                    break;
                case "mt":
                    b = mt.ToString();
                    break;
                case "mw":
                    b = mw.ToString();
                    break;
                case "mh":
                    b = mh.ToString();
                    break;
                case "defaultAutoReturn":
                    b = defaultAutoReturn.ToString();
                    break;
                case "marginRCh":
                    b = marginRCh.ToString();
                    break;
                case "defaultFontSize":
                    b = defaultFontSize.ToString();
                    break;
                case "defaultLineSpacing":
                    b = defaultLineSpacing.ToString();
                    break;
                case "defaultPitch":
                    b = defaultPitch.ToString();
                    break;
                case "userFace":
                    b =  "\"" + userFace + "\"";
                    break;

                case "defaultChColor":
                    b = defaultChColor.ToString();
                    break;
                case "defaultBold":
                    b = defaultBold.ToString();
                    break;
                case "defaultRubySize":
                    b = defaultRubySize.ToString();
                    break;
                case "defaultRubyOffset":
                    b = defaultRubyOffset.ToString();
                    break;
                case "defaultAntialiased":
                    b = defaultAntialiased.ToString();
                    break;
                case "defaultShadowColor":
                    b = defaultShadowColor.ToString();
                    break;
                case "defaultEdgeColor":
                    b = defaultEdgeColor.ToString();
                    break;
                case "defaultShadow":
                    b = defaultShadow.ToString();
                    break;
                case "defaultEdge":
                    b = defaultEdge.ToString();
                    break;
                case "lineBreakGlyph":
                    b =  "\"" + lineBreakGlyph + "\"";
                    break;

                case "lineBreakBaseLine":
                    b = lineBreakBaseLine.ToString();
                    break;
                case "pageBreakGlyph":
                    b =  "\"" + pageBreakGlyph + "\"";
                    break;
                case "pageBreakBaseLine":
                    b = pageBreakBaseLine.ToString();
                    break;
                case "glyphFixedPosition":
                    b = glyphFixedPosition.ToString();
                    break;
                case "glyphFixedLeft":
                    b = glyphFixedLeft.ToString();
                    break;
                case "glyphFixedTop":
                    b = glyphFixedTop.ToString();
                    break;
                case "defaultLinkColor":
                    b = defaultLinkColor.ToString();
                    break;
                case "defaultLinkOpacity":
                    b = defaultLinkOpacity.ToString();
                    break;
                case "vertical":
                    b = vertical.ToString();
                    break;
                case "draggable":
                    b = draggable.ToString();
                    break;

                case "type":
                    b =  "\"" + type + "\"";
                    break;
                case "cdVolume":
                    b =  "\"" + cdVolume + "\"";
                    break;

                case "doubleBuffered":
                    b = doubleBuffered.ToString();
                    break;
                case "midiInitialMessage":
                    b = midiInitialMessage.ToString();
                    break;

                case "fontName":
                    b =  "\"" + fontName + "\"";
                    break;


                case "fontBold":
                    b = fontBold.ToString();
                    break;
                case "fontHeight":
                    b = fontHeight.ToString();
                    break;
                case "lineHeight":
                    b = lineHeight.ToString();
                    break;
                case "verticalView":
                    b = verticalView.ToString();
                    break;
                case "everypage":
                    b = everypage.ToString();
                    break;
                case "autoReturn":
                    b = autoReturn.ToString();
                    break;
                case "maxPages":
                    b = maxPages.ToString();
                    break;
                case "maxLines":
                    b = maxLines.ToString();
                    break;
                case "storeState":
                    b = storeState.ToString();
                    break;

            }
            #endregion

            //因為kr不認識大寫的true/false，強制轉換小寫
            if (b == "True") b = "true";
            else if (b == "False") b = "false";

            //處理完畢以後，返回完整的一行內容
            string c=";" + a + " = " + b + ";" + s[3];
            //Console.WriteLine(c);
            return c;


        }

        //讀入參數
        private void getelm(string line)
        {
            //Console.WriteLine(line);
            //拆分處理
            Regex r = new Regex(";|=");
            string[] s = r.Split(line);
            
            //去掉雙引號後取值
            s[2]=s[2].Replace("\"","");

            string a = s[1].Trim();
            string b = s[2].Trim();

            switch (a)
            {

                #region 系統設定

                case "System.title":
                    title = b;
                    break;
                case "global.ignoreCR":
                    ignoreCR = Convert.ToBoolean(b);
                    break;
                case "global.useconfigMappfont":
                    useconfigMappfont = Convert.ToBoolean(b);
                    break;
                case "global.configMappfont":
                    configMappfont = b;
                    break;
                case "System.graphicCacheLimit":
                    graphicCacheLimit = b;
                    break;
                #endregion

                #region 系統與存檔

                case "scWidth":
                    scWidth = Convert.ToInt32(b);
                    break;
                case "scHeight":
                    scHeight = Convert.ToInt32(b);
                    break;

                case "readOnlyMode":
                    readOnlyMode = Convert.ToBoolean(b);
                    break;
                case "freeSaveDataMode":
                    freeSaveDataMode = Convert.ToBoolean(b);
                    break;
                case "saveDataID":
                    saveDataID = b;
                    break;
                case "saveThumbnail":
                    saveThumbnail = Convert.ToBoolean(b);
                    break;
                case "thumbnailWidth":
                    thumbnailWidth = Convert.ToInt32(b);
                    break;
                case "thumbnailDepth":
                    thumbnailDepth = b;
                    break;
                case "saveDataLocation":
                    saveDataLocation = b;
                    break;
                case "dataName":
                    dataName = b;
                    break;
                case "saveDataMode":
                    saveDataMode = b;
                    break;
                case "saveMacros":
                    saveMacros = Convert.ToBoolean(b);
                    break;
                #endregion

                #region 文字與等待速度

                case "chSpeeds.fast":
                    chSpeeds_fast = Convert.ToInt32(b);
                    break;
                case "chSpeeds.normal":
                    chSpeeds_normal = Convert.ToInt32(b);
                    break;
                case "chSpeeds.slow":
                    chSpeeds_slow = Convert.ToInt32(b);
                    break;

                case "autoModePageWaits.fast":
                    autoModePageWaits_fast = Convert.ToInt32(b);
                    break;
                case "autoModePageWaits.faster":
                    autoModePageWaits_faster = Convert.ToInt32(b);
                    break;
                case "autoModePageWaits.medium":
                    autoModePageWaits_medium = Convert.ToInt32(b);
                    break;
                case "autoModePageWaits.slower":
                    autoModePageWaits_slower = Convert.ToInt32(b);
                    break;
                case "autoModePageWaits.slow":
                    autoModePageWaits_slow = Convert.ToInt32(b);
                    break;

                case "autoModeLineWaits.fast":
                    autoModeLineWaits_fast = Convert.ToInt32(b);
                    break;
                case "autoModeLineWaits.faster":
                    autoModeLineWaits_faster = Convert.ToInt32(b);
                    break;
                case "autoModeLineWaits.medium":
                    autoModeLineWaits_medium = Convert.ToInt32(b);
                    break;
                case "autoModeLineWaits.slower":
                    autoModeLineWaits_slower = Convert.ToInt32(b);
                    break;
                case "autoModeLineWaits.slow":
                    autoModeLineWaits_slow = Convert.ToInt32(b);
                    break;

                #endregion

                #region 鼠標
                case "cursorDefault":
                    cursorDefault = b;
                    break;
                case "cursorPointed":
                    cursorPointed = b;
                    break;
                case "cursorWaitingClick":
                    cursorWaitingClick = b;
                    break;
                case "cursorDraggable":
                    cursorDraggable = b;
                    break;
                #endregion

                #region 通過記錄/震動
                case "autoRecordPageShowing":
                    autoRecordPageShowing = Convert.ToBoolean(b);
                    break;
                case "maxHistoryOfStore":
                    maxHistoryOfStore = Convert.ToInt32(b);
                    break;


                case "defaultQuakeTimeInChUnit":
                    defaultQuakeTimeInChUnit = Convert.ToBoolean(b);
                    break;
                case "quakeMessageLayer":
                    quakeMessageLayer = Convert.ToBoolean(b);
                    break;

                #endregion

                #region 音頻、視頻、圖層
                case "numSEBuffers":
                    numSEBuffers = Convert.ToInt32(b);
                    break;
                case "numMovies":
                    numMovies = Convert.ToInt32(b);
                    break;
                case "numCharacterLayers":
                    numCharacterLayers = Convert.ToInt32(b);
                    break;

                case "scPositionX.left":
                    scPositionX_left = Convert.ToInt32(b);
                    break;
                case "scPositionX.left_center":
                    scPositionX_left_center = Convert.ToInt32(b);
                    break;
                case "scPositionX.center":
                    scPositionX_center = Convert.ToInt32(b);
                    break;
                case "scPositionX.right_center":
                    scPositionX_right_center = Convert.ToInt32(b);
                    break;
                case "scPositionX.right":
                    scPositionX_right = Convert.ToInt32(b);
                    break;

                case "numMessageLayers":
                    numMessageLayers = Convert.ToInt32(b);
                    break;
                case "initialMessageLayerVisible":
                    initialMessageLayerVisible = Convert.ToBoolean(b);
                    break;


                #endregion

                #region 存檔、標籤、菜單、WORLD

                case "numBookMarks":
                    numBookMarks = Convert.ToInt32(b);
                    break;
                case "showBookMarkDate":
                    showBookMarkDate = Convert.ToBoolean(b);
                    break;
                case "showFixedPitchOnlyInFontSelector":
                    showFixedPitchOnlyInFontSelector = Convert.ToBoolean(b);
                    break;
                case "helpFile":
                    helpFile = b;
                    break;

                case "aboutWidth":
                    aboutWidth = Convert.ToInt32(b);
                    break;
                case "aboutHeight":
                    aboutHeight = Convert.ToInt32(b);
                    break;

                case "autoLabelMode":
                    autoLabelMode = Convert.ToBoolean(b);
                    break;
                case "autoLabelType":
                    autoLabelType = b;
                    break;

                case "defaultName":
                    defaultName = b;
                    break;
                case "defaultFamily":
                    defaultFamily = b;
                    break;

                #endregion

                #region 菜單顯示

                case "menu.visible":
                    menu_visible = Convert.ToBoolean(b);
                    break;

                case "rightClickMenuItem.visible":
                    rightClickMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "showHistoryMenuItem.visible":
                    showHistoryMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "skipToNextStopMenuItem.visible":
                    skipToNextStopMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "autoModeMenuItem.visible":
                    autoModeMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "autoModeWaitMenu.visible":
                    autoModeWaitMenu_visible = Convert.ToBoolean(b);
                    break;

                case "goBackMenuItem.visible":
                    goBackMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "goToStartMenuItem.visible":
                    goToStartMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "characterMenu.visible":
                    characterMenu_visible = Convert.ToBoolean(b);
                    break;

                case "chNonStopToPageBreakItem.visible":
                    chNonStopToPageBreakItem_visible = Convert.ToBoolean(b);
                    break;

                case "ch2ndSpeedMenu.visible":
                    ch2ndSpeedMenu_visible = Convert.ToBoolean(b);
                    break;

                case "ch2ndNonStopToPageBreakItem.visible":
                    ch2ndNonStopToPageBreakItem_visible = Convert.ToBoolean(b);
                    break;

                case "chAntialiasMenuItem.visible":
                    chAntialiasMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "chChangeFontMenuItem.visible":
                    chChangeFontMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "restoreMenu.visible":
                    restoreMenu_visible = Convert.ToBoolean(b);
                    break;

                case "storeMenu.visible":
                    storeMenu_visible = Convert.ToBoolean(b);
                    break;

                case "displayMenu.visible":
                    displayMenu_visible = Convert.ToBoolean(b);
                    break;

                case "helpMenu.visible":
                    helpMenu_visible = Convert.ToBoolean(b);
                    break;

                case "helpIndexMenuItem.visible":
                    helpIndexMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "helpAboutMenuItem.visible":
                    helpAboutMenuItem_visible = Convert.ToBoolean(b);
                    break;

                case "debugMenu.visible":
                    debugMenu_visible = Convert.ToBoolean(b);
                    break;

                #endregion

                #region 文字層
                
                case "layerType":
                    layerType = b;
                    break;
                case "frameGraphic":
                    frameGraphic = b;
                    break;
                case "frameColor":
                    frameColor = b;
                    break;
                case "frameOpacity":
                    frameOpacity = Convert.ToInt32(b);
                    break;
                case "marginL":
                    marginL = Convert.ToInt32(b);
                    break;
                case "marginT":
                    marginT = Convert.ToInt32(b);
                    break;
                case "marginR":
                    marginR = Convert.ToInt32(b);
                    break;
                case "marginB":
                    marginB = Convert.ToInt32(b);
                    break;
                case "ml":
                    ml = Convert.ToInt32(b);
                    break;
                case "mt":
                    mt = Convert.ToInt32(b);
                    break;
                case "mw":
                    mw = Convert.ToInt32(b);
                    break;
                case "mh":
                    mh = Convert.ToInt32(b);
                    break;
                case "defaultAutoReturn":
                    defaultAutoReturn = Convert.ToBoolean(b);
                    break;
                case "marginRCh":
                    marginRCh = Convert.ToInt32(b);
                    break;
                case "defaultFontSize":
                    defaultFontSize = Convert.ToInt32(b);
                    break;
                case "defaultLineSpacing":
                    defaultLineSpacing = Convert.ToInt32(b);
                    break;
                case "defaultPitch":
                    defaultPitch = Convert.ToInt32(b);
                    break;
                case "userFace":
                    userFace = b;
                    break;
                case "defaultChColor":
                    defaultChColor = b;
                    break;
                case "defaultBold":
                    defaultBold = Convert.ToBoolean(b);
                    break;
                case "defaultRubySize":
                    defaultRubySize = Convert.ToInt32(b);
                    break;
                case "defaultRubyOffset":
                    defaultRubyOffset = Convert.ToInt32(b);
                    break;
                case "defaultAntialiased":
                    defaultAntialiased = Convert.ToBoolean(b);
                    break;
                case "defaultShadowColor":
                    defaultShadowColor = b;
                    break;
                case "defaultEdgeColor":
                    defaultEdgeColor = b;
                    break;
                case "defaultShadow":
                    defaultShadow = Convert.ToBoolean(b);
                    break;
                case "defaultEdge":
                    defaultEdge = Convert.ToBoolean(b);
                    break;
                case "lineBreakGlyph":
                    lineBreakGlyph = b;
                    break;
                case "lineBreakBaseLine":
                    lineBreakBaseLine = Convert.ToInt32(b);
                    break;
                case "pageBreakGlyph":
                    pageBreakGlyph = b;
                    break;
                case "pageBreakBaseLine":
                    pageBreakBaseLine = Convert.ToInt32(b);
                    break;
                case "glyphFixedPosition":
                    glyphFixedPosition = Convert.ToBoolean(b);
                    break;
                case "glyphFixedLeft":
                    glyphFixedLeft = Convert.ToInt32(b);
                    break;
                case "glyphFixedTop":
                    glyphFixedTop = Convert.ToInt32(b);
                    break;
                case "defaultLinkColor":
                    defaultLinkColor = b;
                    break;
                case "defaultLinkOpacity":
                    defaultLinkOpacity = Convert.ToInt32(b);
                    break;
                case "vertical":
                    vertical = Convert.ToBoolean(b);
                    break;
                case "draggable":
                    draggable = Convert.ToBoolean(b);
                    break;
                
                #endregion

                #region 音頻

                case "type":
                    type = b;
                    break;

                case "cdVolume":
                    cdVolume = b;
                    break;

                case "doubleBuffered":
                    doubleBuffered = Convert.ToBoolean(b);
                    break;

                case "midiInitialMessage":
                    midiInitialMessage = b;
                    break;

                #endregion

                #region 歷史記錄

                case "fontName":
                    fontName = b;
                    break;
                case "fontBold":
                    fontBold = Convert.ToBoolean(b);
                    break;
                case "fontHeight":
                    fontHeight = Convert.ToInt32(b);
                    break;
                case "lineHeight":
                    lineHeight = Convert.ToInt32(b);
                    break;
                case "verticalView":
                    verticalView = Convert.ToBoolean(b);
                    break;
                case "everypage":
                    everypage = Convert.ToBoolean(b);
                    break;
                case "autoReturn":
                    autoReturn = Convert.ToBoolean(b);
                    break;
                case "maxPages":
                    maxPages = Convert.ToInt32(b);
                    break;
                case "maxLines":
                    maxLines = Convert.ToInt32(b);
                    break;
                case "storeState":
                    storeState = Convert.ToBoolean(b);
                    break;

                #endregion


            }
        }

        //property

        #region property 基礎設定

        string title 
        {
            set { textBox1.Text = value; }
            get { return textBox1.Text; }
        }

        bool ignoreCR
        {
            set { checkBox1.Checked = value; }
            get { return checkBox1.Checked;  }
        }

        bool useconfigMappfont
        {
            set { checkBox2.Checked = value; }
            get { return checkBox2.Checked; }
        }

        string configMappfont
        {
            set { textBox2.Text = value; }
            get { return textBox2.Text; }
        }

        string graphicCacheLimit
        {
            set { textBox3.Text = value; }
            get { return textBox3.Text; }
        }

        int scWidth
        {
            set { numericUpDown9.Value = value; }
            get { return Convert.ToInt32(numericUpDown9.Value); }
        }

        int scHeight
        {
            set { numericUpDown10.Value = value; }
            get { return Convert.ToInt32(numericUpDown10.Value); }
        }

        bool readOnlyMode
        {
            set { checkBox3.Checked = value; }
            get { return checkBox3.Checked; }
        }

        bool freeSaveDataMode
        {
            set { checkBox4.Checked = value; }
            get { return checkBox4.Checked; }
        }

        bool saveThumbnail
        {
            set { checkBox5.Checked = value; }
            get { return checkBox5.Checked; }
        }

        int thumbnailWidth
        {
            set { numericUpDown31.Value = value; }
            get { return Convert.ToInt32(numericUpDown31.Value); }
        }

        string thumbnailDepth
        {
            set {  comboBox6.SelectedValue=value; }
            get { return comboBox6.SelectedValue.ToString();}
        }

        string saveDataID
        {
            set { textBox10.Text = value; }
            get { return textBox10.Text; }
        }

        string saveDataLocation
        {
            set { textBox8.Text = value; }
            get { return textBox8.Text; }
        }

        string dataName
        {
            set { textBox9.Text = value; }
            get { return textBox9.Text; }
        }

        string saveDataMode
        {
            set { comboBox1.SelectedValue = value; }
            get { return comboBox1.SelectedValue.ToString(); }
        }

        bool saveMacros
        {
            set { checkBox6.Checked = value; }
            get { return checkBox6.Checked; }
        }
        #endregion

        #region property 文字速度

        int chSpeeds_fast
        {
            set { numericUpDown11.Value = value; }
            get { return Convert.ToInt32(numericUpDown11.Value); }
        }
        int chSpeeds_normal
        {
            set { numericUpDown12.Value = value; }
            get { return Convert.ToInt32(numericUpDown12.Value); }
        }
        int chSpeeds_slow
        {
            set { numericUpDown13.Value = value; }
            get { return Convert.ToInt32(numericUpDown13.Value); }
        }

        int autoModePageWaits_fast
        {
            set { numericUpDown19.Value = value; }
            get { return Convert.ToInt32(numericUpDown19.Value); }
        }
        int autoModePageWaits_faster
        {
            set { numericUpDown20.Value = value; }
            get { return Convert.ToInt32(numericUpDown20.Value); }
        }
        int autoModePageWaits_medium
        {
            set { numericUpDown21.Value = value; }
            get { return Convert.ToInt32(numericUpDown21.Value); }
        }
        int autoModePageWaits_slower
        {
            set { numericUpDown22.Value = value; }
            get { return Convert.ToInt32(numericUpDown22.Value); }
        }
        int autoModePageWaits_slow
        {
            set { numericUpDown23.Value = value; }
            get { return Convert.ToInt32(numericUpDown23.Value); }
        }

        int autoModeLineWaits_fast
        {
            set { numericUpDown14.Value = value; }
            get { return Convert.ToInt32(numericUpDown14.Value); }
        }
        int autoModeLineWaits_faster
        {
            set { numericUpDown15.Value = value; }
            get { return Convert.ToInt32(numericUpDown15.Value); }
        }
        int autoModeLineWaits_medium
        {
            set { numericUpDown16.Value = value; }
            get { return Convert.ToInt32(numericUpDown16.Value); }
        }
        int autoModeLineWaits_slower
        {
            set { numericUpDown17.Value = value; }
            get { return Convert.ToInt32(numericUpDown17.Value); }
        }
        int autoModeLineWaits_slow
        {
            set { numericUpDown18.Value = value; }
            get { return Convert.ToInt32(numericUpDown18.Value); }
        }

        #endregion

        #region 鼠標

        string cursorDefault
        {
            set { textBox33.Text = value; }
            get { return textBox33.Text; }
        }
        string cursorPointed
        {
            set { textBox32.Text = value; }
            get { return textBox32.Text; }
        }
        string cursorWaitingClick
        {
            set { textBox31.Text = value; }
            get { return textBox31.Text; }
        }
        string cursorDraggable
        {
            set { textBox30.Text = value; }
            get { return textBox30.Text; }
        }

        #endregion

        #region 通過記錄/震動
        bool autoRecordPageShowing
        {
            set { checkBox7.Checked = value; }
            get { return checkBox7.Checked; }
        }

        string recordHistoryOfStore
        {
            set { comboBox2.SelectedValue = value; }
            get { return comboBox2.SelectedValue.ToString(); }
        }

        int maxHistoryOfStore
        {
            set { numericUpDown1.Value = value; }
            get { return Convert.ToInt32(numericUpDown1.Value); }
        }

        bool defaultQuakeTimeInChUnit
        {
            set { checkBox8.Checked = value; }
            get { return checkBox8.Checked; }
        }
        bool quakeMessageLayer
        {
            set { checkBox9.Checked = value; }
            get { return checkBox9.Checked; }
        }

        #endregion

        #region 音頻、視頻、圖層

        //圖層緩衝數量
        int numSEBuffers
        {
            set { numericUpDown2.Value = value; }
            get { return Convert.ToInt32(numericUpDown2.Value); }
        }
        int numMovies
        {
            set { numericUpDown3.Value = value; }
            get { return Convert.ToInt32(numericUpDown3.Value); }
        }
        int numCharacterLayers
        {
            set { numericUpDown4.Value = value; }
            get { return Convert.ToInt32(numericUpDown4.Value); }
        }

        //圖層默認對齊位置
        int scPositionX_left
        {
            set { numericUpDown24.Value = value; }
            get { return Convert.ToInt32(numericUpDown24.Value); }
        }
        int scPositionX_left_center
        {
            set { numericUpDown25.Value = value; }
            get { return Convert.ToInt32(numericUpDown25.Value); }
        }
        int scPositionX_center
        {
            set { numericUpDown26.Value = value; }
            get { return Convert.ToInt32(numericUpDown26.Value); }
        }
        int scPositionX_right_center
        {
            set { numericUpDown27.Value = value; }
            get { return Convert.ToInt32(numericUpDown27.Value); }
        }
        int scPositionX_right
        {
            set { numericUpDown28.Value = value; }
            get { return Convert.ToInt32(numericUpDown28.Value); }
        }

        //消息層
        int numMessageLayers
        {
            set { numericUpDown5.Value = value; }
            get { return Convert.ToInt32(numericUpDown5.Value); }
        }

        bool initialMessageLayerVisible
        {
            set { checkBox10.Checked = value; }
            get { return checkBox10.Checked; }
        }

        #endregion

        #region 存檔、菜單

        int numBookMarks
        {
            set { numericUpDown6.Value = value; }
            get { return Convert.ToInt32(numericUpDown6.Value); }
        }
        bool showBookMarkDate
        {
            set { checkBox11.Checked = value; }
            get { return checkBox11.Checked; }
        }

        bool showFixedPitchOnlyInFontSelector
        {
            set { checkBox12.Checked = value; }
            get { return checkBox12.Checked; }
        }

        string helpFile
        {
            set { textBox11.Text = value; }
            get { return textBox11.Text; }
        }
        int aboutWidth
        {
            set { numericUpDown29.Value = value; }
            get { return Convert.ToInt32(numericUpDown29.Value); }
        }
        int aboutHeight 
        {
            set { numericUpDown30.Value = value; }
            get { return Convert.ToInt32(numericUpDown30.Value); }
        }

        bool autoLabelMode
        {
            set { checkBox13.Checked = value; }
            get { return checkBox13.Checked; }
        }

        string autoLabelType
        {
            set { comboBox3.SelectedValue = value; }
            get { return comboBox3.SelectedValue.ToString(); }
        }

        string defaultName
        {
            set { textBox15.Text = value; }
            get { return textBox15.Text; }
        }
        string defaultFamily
        {
            set { textBox14.Text = value; }
            get { return textBox14.Text; }
        }


        #endregion

        #region 菜單顯示
        bool menu_visible
        {
            set { checkBox14.Checked = value; }
            get { return checkBox14.Checked; }
        }
        bool rightClickMenuItem_visible
        {
            set { checkBox15.Checked = value; }
            get { return checkBox15.Checked; }
        }
        bool showHistoryMenuItem_visible
        {
            set { checkBox16.Checked = value; }
            get { return checkBox16.Checked; }
        }
        bool skipToNextStopMenuItem_visible
        {
            set { checkBox17.Checked = value; }
            get { return checkBox17.Checked; }
        }
        bool autoModeMenuItem_visible
        {
            set { checkBox18.Checked = value; }
            get { return checkBox18.Checked; }
        }
        bool autoModeWaitMenu_visible
        {
            set { checkBox19.Checked = value; }
            get { return checkBox19.Checked; }
        }
        bool goBackMenuItem_visible
        {
            set { checkBox20.Checked = value; }
            get { return checkBox20.Checked; }
        }
        bool goToStartMenuItem_visible
        {
            set { checkBox21.Checked = value; }
            get { return checkBox21.Checked; }
        }


        bool characterMenu_visible
        {
            set { checkBox22.Checked = value; }
            get { return checkBox22.Checked; }
        }
        bool chNonStopToPageBreakItem_visible
        {
            set { checkBox23.Checked = value; }
            get { return checkBox23.Checked; }
        }
        bool ch2ndSpeedMenu_visible
        {
            set { checkBox24.Checked = value; }
            get { return checkBox24.Checked; }
        }
        bool ch2ndNonStopToPageBreakItem_visible
        {
            set { checkBox25.Checked = value; }
            get { return checkBox25.Checked; }
        }
        bool chAntialiasMenuItem_visible
        {
            set { checkBox26.Checked = value; }
            get { return checkBox26.Checked; }
        }
        bool chChangeFontMenuItem_visible
        {
            set { checkBox27.Checked = value; }
            get { return checkBox27.Checked; }
        }
        bool restoreMenu_visible
        {
            set { checkBox28.Checked = value; }
            get { return checkBox28.Checked; }
        }
        bool storeMenu_visible
        {
            set { checkBox29.Checked = value; }
            get { return checkBox29.Checked; }
        }
        bool displayMenu_visible
        {
            set { checkBox30.Checked = value; }
            get { return checkBox30.Checked; }
        }
        bool debugMenu_visible 
        {
            set { checkBox31.Checked = value; }
            get { return checkBox31.Checked; }
        }

        bool helpMenu_visible
        {
            set { checkBox32.Checked = value; }
            get { return checkBox32.Checked; }
        }
        bool helpIndexMenuItem_visible
        {
            set { checkBox33.Checked = value; }
            get { return checkBox33.Checked; }
        }
        bool helpAboutMenuItem_visible
        {
            set { checkBox34.Checked = value; }
            get { return checkBox34.Checked; }
        }
        
        #endregion

        #region 文字層
        
        string layerType
        {
            set { comboBox4.SelectedValue = value; }
            get { return comboBox4.SelectedValue.ToString(); }
        }
        string frameGraphic
        {
            set { textBox38.Text = value; }
            get { return textBox38.Text; }
        }
        string frameColor
        {
            set { textBox39.Text = value; }
            get { return textBox39.Text; }
        }
        int frameOpacity
        {
            set { numericUpDown42.Value = value; }
            get { return Convert.ToInt32(numericUpDown42.Value); }
        }
        int marginL
        {
            set { numericUpDown32.Value = value; }
            get { return Convert.ToInt32(numericUpDown32.Value); }
        }
        int marginT
        {
            set { numericUpDown33.Value = value; }
            get { return Convert.ToInt32(numericUpDown33.Value); }
        }
        int marginR
        {
            set { numericUpDown34.Value = value; }
            get { return Convert.ToInt32(numericUpDown34.Value); }
        }
        int marginB
        {
            set { numericUpDown35.Value = value; }
            get { return Convert.ToInt32(numericUpDown35.Value); }
        }
        int ml
        {
            set { numericUpDown36.Value = value; }
            get { return Convert.ToInt32(numericUpDown36.Value); }
        }
        int mt
        {
            set { numericUpDown37.Value = value; }
            get { return Convert.ToInt32(numericUpDown37.Value); }
        }
        int mw
        {
            set { numericUpDown38.Value = value; }
            get { return Convert.ToInt32(numericUpDown38.Value); }
        }
        int mh
        {
            set { numericUpDown39.Value = value; }
            get { return Convert.ToInt32(numericUpDown39.Value); }
        }

        bool defaultAutoReturn
        {
            set { checkBox35.Checked = value; }
            get { return checkBox35.Checked; }
        }
        int marginRCh
        {
            set { numericUpDown7.Value = value; }
            get { return Convert.ToInt32(numericUpDown7.Value); }
        }
        int defaultFontSize
        {
            set { numericUpDown8.Value = value; }
            get { return Convert.ToInt32(numericUpDown8.Value); }
        }
        int defaultLineSpacing
        {
            set { numericUpDown40.Value = value; }
            get { return Convert.ToInt32(numericUpDown40.Value); }
        }
        int defaultPitch
        {
            set { numericUpDown41.Value = value; }
            get { return Convert.ToInt32(numericUpDown41.Value); }
        }
        string userFace
        {
            set { textBox4.Text = value; }
            get { return textBox4.Text; }
        }
        string defaultChColor
        {
            set { textBox5.Text = value; }
            get { return textBox5.Text; }
        }
        bool defaultBold
        {
            set { checkBox36.Checked = value; }
            get { return checkBox36.Checked; }
        }
        int defaultRubySize
        {
            set { numericUpDown43.Value = value; }
            get { return Convert.ToInt32(numericUpDown43.Value); }
        }
        int defaultRubyOffset
        {
            set { numericUpDown44.Value = value; }
            get { return Convert.ToInt32(numericUpDown44.Value); }
        }
        bool defaultAntialiased
        {
            set { checkBox37.Checked = value; }
            get { return checkBox37.Checked; }
        }
        string defaultShadowColor
        {
            set { textBox6.Text = value; }
            get { return textBox6.Text; }
        }
        string defaultEdgeColor
        {
            set { textBox12.Text = value; }
            get { return textBox12.Text; }
        }
        bool defaultShadow
        {
            set { checkBox47.Checked = value; }
            get { return checkBox47.Checked; }
        }
        bool defaultEdge
        {
            set { checkBox48.Checked = value; }
            get { return checkBox48.Checked; }
        }
        string lineBreakGlyph
        {
            set { textBox13.Text = value; }
            get { return textBox13.Text; }
        }
        int lineBreakBaseLine
        {
            set { numericUpDown45.Value = value; }
            get { return Convert.ToInt32(numericUpDown45.Value); }
        }
        string pageBreakGlyph
        {
            set { textBox16.Text = value; }
            get { return textBox16.Text; }
        }
        int pageBreakBaseLine
        {
            set { numericUpDown46.Value = value; }
            get { return Convert.ToInt32(numericUpDown46.Value); }
        }
        bool glyphFixedPosition
        {
            set { checkBox38.Checked = value; }
            get { return checkBox38.Checked; }
        }
        int glyphFixedLeft
        {
            set { numericUpDown48.Value = value; }
            get { return Convert.ToInt32(numericUpDown48.Value); }
        }
        int glyphFixedTop
        {
            set { numericUpDown47.Value = value; }
            get { return Convert.ToInt32(numericUpDown47.Value); }
        }

        string defaultLinkColor
        {
            set { textBox17.Text = value; }
            get { return textBox17.Text; }
        }
        int defaultLinkOpacity
        {
            set { numericUpDown49.Value = value; }
            get { return Convert.ToInt32(numericUpDown49.Value); }
        }
        bool vertical
        {
            set { checkBox39.Checked = value; }
            get { return checkBox39.Checked; }
        }
        bool draggable
        {
            set { checkBox40.Checked = value; }
            get { return checkBox40.Checked; }
        }

        #endregion

        #region 音頻
        
        string type
        {
            set { comboBox5.SelectedValue = value; }
            get { return comboBox5.SelectedValue.ToString(); }
        }
        string cdVolume
        {
            set { textBox18.Text = value; }
            get { return textBox18.Text; }
        }
        bool doubleBuffered
        {
            set { checkBox41.Checked = value; }
            get { return checkBox41.Checked; }
        }
        string midiInitialMessage 
        {
            set { textBox19.Text = value; }
            get { return textBox19.Text; }
        }

        #endregion

        #region 歷史記錄
        
        string fontName
        {
            set { textBox20.Text = value; }
            get { return textBox20.Text; }
        }
        bool fontBold
        {
            set { checkBox42.Checked = value; }
            get { return checkBox42.Checked; }
        }
        int fontHeight
        {
            set { numericUpDown50.Value = value; }
            get { return Convert.ToInt32(numericUpDown50.Value); }
        }
        int lineHeight
        {
            set { numericUpDown51.Value = value; }
            get { return Convert.ToInt32(numericUpDown51.Value); }
        }
        bool verticalView
        {
            set { checkBox43.Checked = value; }
            get { return checkBox43.Checked; }
        }
        bool everypage
        {
            set { checkBox44.Checked = value; }
            get { return checkBox44.Checked; }
        }
        bool autoReturn
        {
            set { checkBox45.Checked = value; }
            get { return checkBox45.Checked; }
        }
        int maxPages
        {
            set { numericUpDown53.Value = value; }
            get { return Convert.ToInt32(numericUpDown53.Value); }
        }
        int maxLines
        {
            set { numericUpDown52.Value = value; }
            get { return Convert.ToInt32(numericUpDown52.Value); }
        }
        bool storeState
        {
            set { checkBox46.Checked = value; }
            get { return checkBox46.Checked; }
        }
        
        #endregion


        //comboBox用CLASS
        class TextAndValue
        {
            private string _RealValue = "";
            private string _DisplayText = "";

            public string DisplayText
            {
                get
                {
                    return _DisplayText;
                }
            }
            public string RealValue
            {
                get
                {
                    return _RealValue;
                }
            }
            public TextAndValue(string ShowText, string RealVal)
            {
                _DisplayText = ShowText;
                _RealValue = RealVal;
            }
            public override string ToString()
            {
                return _RealValue.ToString();
            }

        }

        //comboBox下拉菜單設置
        private void Form1_Load(object sender, EventArgs e)
        {
            if (args.Length != 0)
            {
                config_file_name = args[0];
                loadTjs(config_file_name);
                tabControl1.Enabled = true;
                button1.Enabled = true;
                label19.Text = config_file_name;

            }

            //縮略圖格式
            ArrayList al = new ArrayList();
            al.Add(new TextAndValue("256色位圖", "8"));
            al.Add(new TextAndValue("24位色位圖", "24"));

            comboBox6.DataSource = al;
            comboBox6.DisplayMember = "DisplayText";
            comboBox6.ValueMember = "RealValue";
            
            //檔案格式
            ArrayList a2 = new ArrayList();
            a2.Add(new TextAndValue("普通", ""));
            a2.Add(new TextAndValue("壓縮", "z"));
            a2.Add(new TextAndValue("加密", "c"));

            comboBox1.DataSource = a2;
            comboBox1.DisplayMember = "DisplayText";
            comboBox1.ValueMember = "RealValue";
            
            //通過記錄模式
            ArrayList a3 = new ArrayList();
            a3.Add(new TextAndValue("手動記錄", "0"));
            a3.Add(new TextAndValue("可存檔標籤處記錄", "1"));
            a3.Add(new TextAndValue("選項分支時記錄", "2"));

            comboBox2.DataSource = a3;
            comboBox2.DisplayMember = "DisplayText";
            comboBox2.ValueMember = "RealValue";
            
            //自動標籤模式
            ArrayList a4 = new ArrayList();
            a4.Add(new TextAndValue("臨時標籤模式", "0"));
            a4.Add(new TextAndValue("行號模式(推薦)", "1"));

            comboBox3.DataSource = a4;
            comboBox3.DisplayMember = "DisplayText";
            comboBox3.ValueMember = "RealValue";
            
            //對話框顯示模式
            ArrayList a5 = new ArrayList();
            a5.Add(new TextAndValue("兼容模式", "ltAlpha"));
            a5.Add(new TextAndValue("特殊模式", "ltAddAlpha"));

            comboBox4.DataSource = a5;
            comboBox4.DisplayMember = "DisplayText";
            comboBox4.ValueMember = "RealValue";

            //音頻格式
            ArrayList a6 = new ArrayList();
            a6.Add(new TextAndValue("波形文件", "Wave"));
            a6.Add(new TextAndValue("MIDI文件", "MIDI"));
            a6.Add(new TextAndValue("CD音軌", "CDDA"));
            comboBox5.DataSource = a6;
            comboBox5.DisplayMember = "DisplayText";
            comboBox5.ValueMember = "RealValue";


        }

        //保存
        private void button1_Click(object sender, EventArgs e)
        {

            ArrayList a;

            a=writeTjs(config_file_name);

            //保存
            StreamWriter sw;
            sw = new StreamWriter(config_file_name, false, Encoding.Unicode);

            foreach (string i in a)
            {
                sw.WriteLine(i);
            }

            sw.Close();

        }
        //關閉
        private void button17_Click(object sender, EventArgs e)
        {
            Close();
        }

        //鼠標指針們
        private void button2_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "鼠標指針   (*.CUR;*.ANI)|*.CUR;*.ANI";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                cursorDefault = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            openFileDialog1.Filter = "鼠標指針   (*.CUR;*.ANI)|*.CUR;*.ANI";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                cursorPointed = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "鼠標指針   (*.CUR;*.ANI)|*.CUR;*.ANI";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                cursorWaitingClick = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "鼠標指針   (*.CUR;*.ANI)|*.CUR;*.ANI";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                cursorDraggable = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        //幫助文件
        private void button6_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "所有文件   (*.*)|*.*";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                helpFile = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        //對話框圖形
        private void button7_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "圖像文件   (*.BMP;*.JPG;*.PNG;*.TLG)|*.BMP;*.JPG;*.PNG;*.TLG";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                frameGraphic = Path.GetFileName(openFileDialog1.FileName);
            }
        }
        //換行等待
        private void button13_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "圖像文件   (*.BMP;*.JPG;*.PNG;*.TLG)|*.BMP;*.JPG;*.PNG;*.TLG";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                lineBreakGlyph = Path.GetFileName(openFileDialog1.FileName);
            }
        }
        //分頁等待
        private void button14_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "圖像文件   (*.BMP;*.JPG;*.PNG;*.TLG)|*.BMP;*.JPG;*.PNG;*.TLG";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                pageBreakGlyph = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        //字體預渲染文件
        private void button12_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Filter = "字體圖形文件   (*.TFT)|*.TFT";
            //返回
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                configMappfont = Path.GetFileName(openFileDialog1.FileName);
            }
        }

        #region 定義ChooseFont函數（沒有用到的代碼）
        private const int CF_SCREENFONTS = 0x00000001;
        private const int CF_EFFECTS = 0x00000100;
        private const int CF_INITTOLOGFONTSTRUCT = 0x00000040;
        private const int LF_FACESIZE = 32 / 2;

        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        private struct LOGFONT
        {
            public int lfHeight;
            public int lfWidth;
            public int lfEscapement;
            public int lfOrientation;
            public int lfWeight;
            public byte lfItalic;
            public byte lfUnderline;
            public byte lfStrikeOut;
            public byte lfCharSet;
            public byte lfOutPrecision;
            public byte lfClipPrecision;
            public byte lfQuality;
            public byte lfPitchAndFamily;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = LF_FACESIZE)]
            public string lfFaceName;
        }

        //typedef struct {
        //  DWORD        lStructSize;
        //  HWND         hwndOwner;
        //  HDC          hDC;
        //  LPLOGFONT    lpLogFont;
        //  INT          iPointSize;
        //  DWORD        Flags;
        //  COLORREF     rgbColors;
        //  LPARAM       lCustData;
        //  LPCFHOOKPROC lpfnHook;
        //  LPCTSTR      lpTemplateName;
        //  HINSTANCE    hInstance;
        //  LPTSTR       lpszStyle;
        //  WORD         nFontType;
        //  INT          nSizeMin;
        //  INT          nSizeMax;
        //} CHOOSEFONT, *LPCHOOSEFONT;

        //structure size in C is equal to 60, so I use int instead of IntPtr
        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        private struct CHOOSEFONT
        {
            public Int32 lStructSize;
            public IntPtr hwndOwner;
            public IntPtr hDC;
            public IntPtr lpLogFont;
            public Int32 iPointSize;
            public Int32 Flags;
            public Int32 rgbColors;
            public Int32 lCustData;
            public IntPtr lpfnHook;
            public IntPtr lpTemplateName;
            public IntPtr hInstance;
            public IntPtr lpszStyle;
            public Int16 nFontType;
            public Int16 ___MISSING_ALIGNMENT__;
            public Int32 nSizeMin;
            public Int32 nSizeMax;
        }

        [DllImport("comdlg32.dll", CharSet = CharSet.Auto, EntryPoint = "ChooseFont")]
        private extern static bool ChooseFont(IntPtr lpcf);
        private void ChooseFontDlg()
        {
            LOGFONT lf = new LOGFONT();
            IntPtr lplf = Marshal.AllocHGlobal(Marshal.SizeOf(lf));
            Marshal.StructureToPtr(lf, lplf, false);

            int xxx = Marshal.SizeOf(typeof(LOGFONT));

            CHOOSEFONT cf = new CHOOSEFONT();
            cf.lStructSize = Marshal.SizeOf(typeof(CHOOSEFONT));
            cf.Flags = CF_EFFECTS | CF_SCREENFONTS;
            cf.hwndOwner = this.Handle;//.ToInt32();
            cf.lpLogFont = lplf;//.ToInt32();
            IntPtr lpcf = Marshal.AllocHGlobal(Marshal.SizeOf(cf));
            Marshal.StructureToPtr(cf, lpcf, false);

            //fails with CDERR_STRUCTSIZE
            bool ret = ChooseFont(lpcf);//.ToInt32());

            Marshal.FreeHGlobal(lpcf);
            Marshal.FreeHGlobal(lplf);
        }
        #endregion

        //字體選擇
        private void button8_Click(object sender, EventArgs e)
        {
            //ChooseFontDlg();
            //if (fontDialog1.ShowDialog() == DialogResult.OK)
            //{
            //    userFace = fontDialog1.Font.Name;
            //}
            Form2 font_form = new Form2();

            if (font_form.ShowDialog() == DialogResult.OK)
            {
                userFace = font_form.font_name;
            }
        }

        //歷史記錄字體選擇
        private void button16_Click(object sender, EventArgs e)
        {

            //if (fontDialog1.ShowDialog() == DialogResult.OK)
            //{
            //    fontName = fontDialog1.Font.Name;

            //}
            Form2 font_form = new Form2();

            if (font_form.ShowDialog() == DialogResult.OK)
            {
                fontName = font_form.font_name;
            }
        }

        //對話框顏色選擇
        private void button18_Click(object sender, EventArgs e)
        {
            if (colorDialog1.ShowDialog() == DialogResult.OK)
            {
                //字體顏色轉換

                string r = colorDialog1.Color.R.ToString("X2");
                string g = colorDialog1.Color.G.ToString("X2");
                string b = colorDialog1.Color.B.ToString("X2");

                frameColor="0x" + r + g + b;

            }
        }

        //文字連接顏色
        private void button15_Click(object sender, EventArgs e)
        {
            if (colorDialog1.ShowDialog() == DialogResult.OK)
            {
                //字體顏色轉換

                string r = colorDialog1.Color.R.ToString("X2");
                string g = colorDialog1.Color.G.ToString("X2");
                string b = colorDialog1.Color.B.ToString("X2");

                defaultLinkColor = "0x" + r + g + b;
            }
        }

        //文字層字體顏色
        private void button9_Click(object sender, EventArgs e)
        {
            if (colorDialog1.ShowDialog() == DialogResult.OK)
            {
                //字體顏色轉換

                string r = colorDialog1.Color.R.ToString("X2");
                string g = colorDialog1.Color.G.ToString("X2");
                string b = colorDialog1.Color.B.ToString("X2");

                defaultChColor = "0x" + r + g + b;
            }
        }

        //陰影顏色
        private void button10_Click(object sender, EventArgs e)
        {
            if (colorDialog1.ShowDialog() == DialogResult.OK)
            {
                //字體顏色轉換

                string r = colorDialog1.Color.R.ToString("X2");
                string g = colorDialog1.Color.G.ToString("X2");
                string b = colorDialog1.Color.B.ToString("X2");

                defaultShadowColor = "0x" + r + g + b;
            }
        }

        //描邊顏色
        private void button11_Click(object sender, EventArgs e)
        {
            if (colorDialog1.ShowDialog() == DialogResult.OK)
            {
                //字體顏色轉換

                string r = colorDialog1.Color.R.ToString("X2");
                string g = colorDialog1.Color.G.ToString("X2");
                string b = colorDialog1.Color.B.ToString("X2");

                defaultEdgeColor = "0x" + r + g + b;
            }
        }


#region 註釋：讀取的參數記錄

/*
System.title
global.useconfigMappfont
global.configMappfont
scWidth
scHeight
readOnlyMode
freeSaveDataMode
saveThumbnail
thumbnailWidth
thumbnailDepth
saveDataLocation
dataName
saveDataID
saveDataMode
saveMacros
chSpeeds.fast
chSpeeds.normal
chSpeeds.slow
autoModePageWaits.fast
autoModePageWaits.faster
autoModePageWaits.medium
autoModePageWaits.slower
autoModePageWaits.slow
autoModeLineWaits.fast
autoModeLineWaits.faster
autoModeLineWaits.medium
autoModeLineWaits.slower
autoModeLineWaits.slow
cursorDefault
cursorPointed
cursorWaitingClick
cursorDraggable
autoRecordPageShowing
recordHistoryOfStore
maxHistoryOfStore
quakeMessageLayer
numSEBuffers
numMovies
numCharacterLayers
scPositionX.left
scPositionX.left_center
scPositionX.center
scPositionX.right_center
scPositionX.right
numMessageLayers
initialMessageLayerVisible
numBookMarks
showBookMarkDate
showFixedPitchOnlyInFontSelector
helpFile
aboutWidth
aboutHeight
autoLabelMode
autoLabelType
defaultName
defaultFamily
menu.visible
rightClickMenuItem.visible
showHistoryMenuItem.visible
skipToNextStopMenuItem.visible
autoModeMenuItem.visible
autoModeWaitMenu.visible
goBackMenuItem.visible
goToStartMenuItem.visible
characterMenu.visible
chNonStopToPageBreakItem.visible
ch2ndSpeedMenu.visible
ch2ndNonStopToPageBreakItem.visible
chAntialiasMenuItem.visible
chChangeFontMenuItem.visible
restoreMenu.visible
storeMenu.visible
displayMenu.visible
helpMenu.visible
helpIndexMenuItem.visible
helpAboutMenuItem.visible
debugMenu.visible
layerType
frameGraphic
frameColor
frameOpacity
marginL
marginT
marginR
marginB
ml
mt
mw
mh
defaultAutoReturn
marginRCh
defaultFontSize
defaultLineSpacing
defaultPitch
userFace
defaultChColor
defaultBold
defaultRubySize
defaultRubyOffset
defaultAntialiased
defaultShadowColor
defaultEdgeColor
defaultShadow
defaultEdge
lineBreakGlyph
lineBreakBaseLine
pageBreakGlyph
pageBreakBaseLine
glyphFixedPosition
glyphFixedLeft
glyphFixedTop
defaultLinkColor
defaultLinkOpacity
vertical
draggable
type
cdVolume
doubleBuffered
midiInitialMessage
fontName
fontBold
fontHeight
lineHeight
verticalView
everypage
autoReturn
maxPages
maxLines
storeState
*/

#endregion




    }
}
