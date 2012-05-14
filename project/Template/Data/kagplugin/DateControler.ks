@if exp="typeof(global.datecontroler_object) == 'undefined'"
@iscript
// 虛擬時間控制器

//by 希德船長 2007-03-20

class DateControlerPlugin extends KAGPlugin
{
        var datetime; // 時間對象，用於虛擬時間的計算。
        var autorun; // 時間是否自動流逝。
        var secondticks; // 虛擬時間中1秒的長度，單位為毫秒，可以為小數。時間自動流逝時有效。
        var lasttick; // 上一次記錄的時間戳，用於自動流逝時的時間計算。

        function DateControlerPlugin()
        {
                // 構造函數
                super.KAGPlugin();
                datetime = new Date();
                autorun = true;
                secondticks = 1000;
                lasttick = System.getTickCount();
                refreshDate();
        }

        function finalize()
        {
                invalidate datetime;
                super.finalize(...);
        }

        // 設置工作模式和當前時間，注意，該函數的刷新時間戳是默認行為
        function setOption(autorun, secondticks, resetlasttick, year, month, date, hours, minutes, seconds)
        {
                if(autorun !== void)
                        this.autorun = +autorun;
                if(secondticks !== void)
                        this.secondticks = +secondticks;
                if(resetlasttick !== false) // 刷新時間戳
                        lasttick = System.getTickCount();
                if(year !== void)
                        datetime.setYear(+year);
                if(month !== void)
                        datetime.setMonth(+(month-1));
                if(date !== void)
                        datetime.setDate(+date);
                if(hours !== void)
                        datetime.setHours(+hours);
                if(minutes !== void)
                        datetime.setMinutes(+minutes);
                if(seconds !== void)
                        datetime.setSeconds(+seconds);
                refreshDate();
        }
        
        // 刷新時間變量
        function refreshDate()
        {
                if(autorun)
                {
                        //計算自動流逝狀態的虛擬時間
                        var newtick = System.getTickCount();
                        dm("newtick=" + newtick);
                        var ticktemp = datetime.getTime();
                        dm("ticktemp=" + ticktemp);
                        ticktemp += int((newtick - lasttick) / secondticks * 1000);
                        dm("ticktemp=" + ticktemp);
                        datetime.setTime(ticktemp);
                        lasttick = newtick;
                }
                f.Year = datetime.getYear();
                f.Month = datetime.getMonth()+1;
                f.Date = datetime.getDate();
                f.Hours = datetime.getHours();
                f.Minutes = datetime.getMinutes();
                f.Seconds = datetime.getSeconds();
                var numday = datetime.getDay();
                switch(numday)
                {
                case 0:
                        f.Day = "星期日";
                        break;
                case 1:
                        f.Day = "星期一";
                        break;
                case 2:
                        f.Day = "星期二";
                        break;
                case 3:
                        f.Day = "星期三";
                        break;
                case 4:
                        f.Day = "星期四";
                        break;
                case 5:
                        f.Day = "星期五";
                        break;
                case 6:
                        f.Day = "星期六";
                        break;
                }
        }

        // 手動讓虛擬時間前進
        function elapse(date, hours, minutes, seconds, milliseconds)
        {
                if(date !== void)
                        datetime.setTime(datetime.getTime() + (+date) * 24 * 60 * 60 * 1000);
                if(hours !== void)
                        datetime.setTime(datetime.getTime() + (+hours) * 60 * 60 * 1000);
                if(minutes !== void)
                        datetime.setTime(datetime.getTime() + (+minutes) * 60 * 1000);
                if(seconds !== void)
                        datetime.setTime(datetime.getTime() + (+seconds) * 1000);
                if(milliseconds !== void)
                        datetime.setTime(datetime.getTime() + (+milliseconds));
                refreshDate();
        }

}

kag.addPlugin(global.datecontroler_object = new DateControlerPlugin());
        // 插件對象的創建和註冊

@endscript
@endif

; 宏註冊

; 手動讓虛擬時間前進,同時刷新時間變量
;        參數: date, hours, minutes, seconds, milliseconds
;        分別為前進的天數，小時數，分鐘數，秒數和毫秒數，均為可選參數
@macro name="dateElapse"
@eval exp="datecontroler_object.elapse(mp.date, mp.hours, mp.minutes, mp.seconds, mp.milliseconds)"
@endmacro

; 刷新時間變量
;        無參數
;        注意，月份是從0開始的！！！！！！！
@macro name="refreshDate"
@eval exp="datecontroler_object.refreshDate()"
@endmacro

; 設置工作模式和當前時間,同時刷新時間變量
;        參數(均為可選參數): 
;        autorun                        時間是否自動流逝 默認為true
;        secondticks                虛擬時間中1秒的長度，單位為毫秒，可以為小數。時間自動流逝時有效 默認為1000
;        resetlasttick        是否刷新時間戳 默認為true
;        year, month, date, hours, minutes, seconds 新的「當前時間」
@macro name="setDateControlerOption"
@eval exp="datecontroler_object.setOption(mp.autorun, mp.secondticks, mp.resetlasttick, mp.year, mp.month, mp.date, mp.hours, mp.minutes, mp.seconds)"
@endmacro


@return

;@call storage="DateControler.ks"
;
;*start|測試開始
;[nowait]
;當前時間為[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]時 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;@refreshDate
;當前時間為[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]時 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;@refreshDate
;當前時間為[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]時 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;
;@setDateControlerOption autorun=false year=2000 month=0 date=1 hours=0 minutes=0 seconds=0
;關閉自動時間流逝，並設定虛擬時間為2000年1月1日0點整[l][r]
;
;@refreshDate
;當前時間為[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]時 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;手動讓時間前進1天零2個小時[l][r]
;@dateElapse date=1 hours=2
;
;當前時間為[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]時 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
