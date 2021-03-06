@if exp="typeof(global.datecontroler_object) == 'undefined'"
@iscript
// 虚拟时间控制器

//by 希德船长 2007-03-20

class DateControlerPlugin extends KAGPlugin
{
        var datetime; // 时间对象，用于虚拟时间的计算。
        var autorun; // 时间是否自动流逝。
        var secondticks; // 虚拟时间中1秒的长度，单位为毫秒，可以为小数。时间自动流逝时有效。
        var lasttick; // 上一次记录的时间戳，用于自动流逝时的时间计算。

        function DateControlerPlugin()
        {
                // 构造函数
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

        // 设置工作模式和当前时间，注意，该函数的刷新时间戳是默认行为
        function setOption(autorun, secondticks, resetlasttick, year, month, date, hours, minutes, seconds)
        {
                if(autorun !== void)
                        this.autorun = +autorun;
                if(secondticks !== void)
                        this.secondticks = +secondticks;
                if(resetlasttick !== false) // 刷新时间戳
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
        
        // 刷新时间变量
        function refreshDate()
        {
                if(autorun)
                {
                        //计算自动流逝状态的虚拟时间
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

        // 手动让虚拟时间前进
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
        // 插件对象的创建和注册

@endscript
@endif

; 宏注册

; 手动让虚拟时间前进,同时刷新时间变量
;        参数: date, hours, minutes, seconds, milliseconds
;        分别为前进的天数，小时数，分钟数，秒数和毫秒数，均为可选参数
@macro name="dateElapse"
@eval exp="datecontroler_object.elapse(mp.date, mp.hours, mp.minutes, mp.seconds, mp.milliseconds)"
@endmacro

; 刷新时间变量
;        无参数
;        注意，月份是从0开始的！！！！！！！
@macro name="refreshDate"
@eval exp="datecontroler_object.refreshDate()"
@endmacro

; 设置工作模式和当前时间,同时刷新时间变量
;        参数(均为可选参数): 
;        autorun                        时间是否自动流逝 默认为true
;        secondticks                虚拟时间中1秒的长度，单位为毫秒，可以为小数。时间自动流逝时有效 默认为1000
;        resetlasttick        是否刷新时间戳 默认为true
;        year, month, date, hours, minutes, seconds 新的“当前时间”
@macro name="setDateControlerOption"
@eval exp="datecontroler_object.setOption(mp.autorun, mp.secondticks, mp.resetlasttick, mp.year, mp.month, mp.date, mp.hours, mp.minutes, mp.seconds)"
@endmacro


@return

;@call storage="DateControler.ks"
;
;*start|测试开始
;[nowait]
;当前时间为[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]时 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;@refreshDate
;当前时间为[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]时 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;@refreshDate
;当前时间为[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]时 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;
;@setDateControlerOption autorun=false year=2000 month=0 date=1 hours=0 minutes=0 seconds=0
;关闭自动时间流逝，并设定虚拟时间为2000年1月1日0点整[l][r]
;
;@refreshDate
;当前时间为[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]时 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
;
;手动让时间前进1天零2个小时[l][r]
;@dateElapse date=1 hours=2
;
;当前时间为[ch text=&f.Year]年 [ch text=&(f.Month+1)]月 [ch text=&f.Date]日 ([ch text=&f.Day]) [ch text=&f.Hours]时 [ch text=&f.Minutes]分 [ch text=&f.Seconds]秒。[l][r]
