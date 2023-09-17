import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Communications;
import Toybox.Application.Storage;


class faceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // 在imageContainer中预设图片的位置
        // var imageContainer = new Rez.Drawables.ImageContainer();
        // imageContainer.draw( dc );
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // var bgRes = WatchUi.loadResource(Rez.Drawables.bg) as BitmapResource;
        // dc.drawBitmap( 0, 0, bgRes );

        // Get and show the current time
        var devSettings = System.getDeviceSettings();
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        // 设置小时、分钟 动态加载图片资源，然后直接设置在指定坐标位置
        var hourText = clockTime.hour.format("%02d");
        // var hourView = View.findDrawableById("hourLabel") as Text;
        // hourView.setText(hourText);
        var hourTextFirst = hourText.substring(0, 1);
        var hourTextFirstRes = Utils.loadNumberResource(hourTextFirst);
        var hourTextSecond = hourText.substring(1, 2);
        var hourTextSecondRes = Utils.loadNumberResource(hourTextSecond);
        dc.drawBitmap( 31, 90, hourTextFirstRes );
        dc.drawBitmap( 80, 90, hourTextSecondRes );

        var minuteText = clockTime.min.format("%02d");
        // var minuteView = View.findDrawableById("minuteLabel") as Text;
        // minuteView.setText(minuteText);
        var minuteTextFirst = minuteText.substring(0, 1);
        var minuteTextFirstRes = Utils.loadNumberResource(minuteTextFirst);
        var minuteTextSecond = minuteText.substring(1, 2);
        var minuteTextSecondRes = Utils.loadNumberResource(minuteTextSecond);
        dc.drawBitmap( 31, 130, minuteTextFirstRes );
        dc.drawBitmap( 80, 130, minuteTextSecondRes );

        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        System.println(Lang.format("$1$-$2$-$3$", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u")
        ]));

        // 最外层的电量
        var myStats = System.getSystemStats();
        var battery = myStats.battery.toNumber();
        Utils.drawCircle(dc, {
            :width=>14,
            :x=>130,
            :y=>130,
            :r=>130,
            :fullStart=>75,
            :fullEnd=>105,
            :max=>100,
            :current=>battery,
            :color=>Graphics.COLOR_DK_GREEN,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var batteryView = View.findDrawableById("batteryLabel") as Text;
        batteryView.setText(battery.toString() + "%");
        var batteryRes = WatchUi.loadResource(Rez.Drawables.battery) as BitmapResource;
        dc.drawBitmap( 110, 10, batteryRes );

        // 心率
        // var heartRate;
        // if (ActivityMonitor has :getHeartRateHistory) {
        //     var activityInfo = Activity.getActivityInfo();
        //     heartRate = activityInfo.currentHeartRate;
        //     if(heartRate==null) {
        //         var HRH=ActivityMonitor.getHeartRateHistory(1, true);
        //         var HRS=HRH.next();
        //         if(HRS!=null && HRS.heartRate!= ActivityMonitor.INVALID_HR_SAMPLE){
        //             heartRate = HRS.heartRate;
        //         }
        //     }

        //     if(heartRate!=null) {
        //         heartRate = heartRate.toString();
        //     } else{
        //         heartRate = "--";
        //     }
        // }

         // 步数 get ActivityMonitor info
        var info = ActivityMonitor.getInfo();

        Utils.drawCircle(dc, {
            :width=>4,
            :x=>180,
            :y=>80,
            :r=>24,
            :fullStart=>80,
            :fullEnd=>120,
            :max=>info.stepGoal,
            :current=>info.steps,
            :color=>Graphics.COLOR_DK_GREEN,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var stepView = View.findDrawableById("stepText") as Text;
        stepView.setText(info.steps.toString());
        var stepRes = WatchUi.loadResource(Rez.Drawables.step) as BitmapResource;
        dc.drawBitmap( 170, 52, stepRes);


        var distView = View.findDrawableById("distText") as Text;
        distView.setText(Utils.filledK(info.distance));

        var caloryView = View.findDrawableById("caloryText") as Text;
        distView.setText(Utils.filledK(info.calories));

        var msgView = View.findDrawableById("msgText") as Text;
        msgView.setText(devSettings.notificationCount.toString());

        var zhFont=WatchUi.loadResource(Rez.Fonts.zhFont);
    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var dateStr = Lang.format("$1$/$2$", [today.month, today.day]);

        var storedKey = Utils.getStoredKey();
        var dateInfo = Storage.getValue(storedKey) as Lang.Dictionary;
        var lunarStr = "";
        if (dateInfo != null) {
            lunarStr = dateInfo["lunarCalendar"];
            // 天气
            var _weatherData = dateInfo["_weatherData"] as Dictionary;
            var weatherView = View.findDrawableById("weatherLabel") as Text;
            weatherView.setText(_weatherData["cityCode"]);
        }
        
        var weekStr = Utils.getWeekStr(today.day_of_week);
        dc.drawText(130, 210, zhFont, Lang.format("$1$ $2$ $3$", [dateStr, lunarStr, weekStr]), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);


        
        

        

        // var moveBar = new MyProgressBar({
        //     :locX=>90,
        //     :locY=>180,
        //     :width=>100,
        //     :height=>10,
        //     :color=>Graphics.COLOR_DK_BLUE
        // });
        // moveBar.setPercent(0.75);
        // moveBar.draw( dc );

        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }
}
