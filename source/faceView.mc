import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Communications;
import Toybox.Application.Storage;
import Toybox.UserProfile;


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
        var zhFont = WatchUi.loadResource(Rez.Fonts.zhFont);
        var chillFont = WatchUi.loadResource(Rez.Fonts.chillFont);

         var guoqingRes = WatchUi.loadResource(Rez.Drawables.guoqing) as BitmapResource;
        dc.drawBitmap( 50, 50, guoqingRes);
        // dc.drawBitmap2( 100, 100, guoqingRes, {
        //     :bitmapX => 10,
        //     :bitmapY => 10,
        // });

        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        // 设置小时、分钟 动态加载图片资源，然后直接设置在指定坐标位置
        var hourText = clockTime.hour.format("%02d");
        // var hourView = View.findDrawableById("hourLabel") as Text;
        // hourView.setText(hourText);
        var hourTextFirst = hourText.substring(0, 1);
        var hourTextFirstRes = Utils.loadNumberResource(hourTextFirst);
        var hourTextSecond = hourText.substring(1, 2);
        var hourTextSecondRes = Utils.loadNumberResource(hourTextSecond);
        // dc.drawBitmap( 21, 90, hourTextFirstRes );
        // dc.drawBitmap( 70, 90, hourTextSecondRes );

        var minuteText = clockTime.min.format("%02d");
        // var minuteView = View.findDrawableById("minuteLabel") as Text;
        // minuteView.setText(minuteText);
        var minuteTextFirst = minuteText.substring(0, 1);
        var minuteTextFirstRes = Utils.loadNumberResource(minuteTextFirst);
        var minuteTextSecond = minuteText.substring(1, 2);
        var minuteTextSecondRes = Utils.loadNumberResource(minuteTextSecond);
        // dc.drawBitmap( 21, 130, minuteTextFirstRes );
        // dc.drawBitmap( 70, 130, minuteTextSecondRes );
        dc.setColor(0x57bca7, Graphics.COLOR_TRANSPARENT);
        dc.drawText(70, 65, chillFont, clockTime.hour.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(70, 100, chillFont, clockTime.min.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);


        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        // 最外层的电量
        var myStats = System.getSystemStats();
        var battery = myStats.battery.toNumber();
        // battery = 90;
        Utils.drawCircle(dc, {
            :width=>14,
            :x=>130,
            :y=>130,
            :r=>130,
            :fullStart=>75,
            :fullEnd=>105,
            :max=>100,
            :current=>battery,
            :color=>0x57bca7,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var batteryView = View.findDrawableById("batteryLabel") as Text;
        batteryView.setText(battery.toString() + "%");
        var batteryRes = WatchUi.loadResource(Rez.Drawables.battery) as BitmapResource;
        dc.drawBitmap( 105, 2, batteryRes );

        // 心率
        var heartRate = "";
        if (ActivityMonitor has :getHeartRateHistory) {
            var activityInfo = Activity.getActivityInfo();
            heartRate = activityInfo.currentHeartRate;
            if(heartRate==null) {
                var HRH=ActivityMonitor.getHeartRateHistory(1, true);
                var HRS=HRH.next();
                if(HRS!=null && HRS.heartRate!= ActivityMonitor.INVALID_HR_SAMPLE){
                    heartRate = HRS.heartRate;
                }
            }

            if(heartRate!=null) {
                heartRate = heartRate.toString();
            } else{
                heartRate = "--";
            }
        }

        // 身体电量
        var bodyBattery="";
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getBodyBatteryHistory)) {
            bodyBattery= Toybox.SensorHistory.getBodyBatteryHistory({:period=>1});
            if (bodyBattery!=null){
                bodyBattery = bodyBattery.next();
            }
            if (bodyBattery!=null){
                bodyBattery = bodyBattery.data;
            }
            if (bodyBattery!=null){
                bodyBattery = bodyBattery.toNumber().toString();
            } else {
                bodyBattery = "--";
            }
        }

        // 用户信息
        var profile = UserProfile.getProfile();
        // 步数 get ActivityMonitor info
        var info = ActivityMonitor.getInfo();

        var steps = info.steps;
        Utils.drawCircle(dc, {
            :width=>4,
            :x=>195,
            :y=>80,
            :r=>24,
            :fullStart=>60,
            :fullEnd=>120,
            :max=>info.stepGoal,
            :current=>steps,
            :color=>0x57bca7,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var stepView = View.findDrawableById("stepText") as Text;
        stepView.setText(steps.toString());
        var stepRes = WatchUi.loadResource(Rez.Drawables.step) as BitmapResource;
        dc.drawBitmap( 185, 52, stepRes);

        var heartrateView = View.findDrawableById("heartrateText") as Text;
        heartrateView.setText(heartRate);
        var heartrateRes = WatchUi.loadResource(Rez.Drawables.heartrate) as BitmapResource;
        dc.drawBitmap( 105, 180, heartrateRes);
        // 最大摄氧量
        var vo2max = profile.vo2maxRunning;
        if (vo2max != null) {
            vo2max = vo2max.toString();
        } else {
            vo2max = "--";
        }
        var vo2maxView = View.findDrawableById("vo2maxText") as Text;
        vo2maxView.setText(vo2max);
        var vo2maxRes = WatchUi.loadResource(Rez.Drawables.vo2max) as BitmapResource;
        dc.drawBitmap( 175, 180, vo2maxRes);
        
        var distance = info.distance; // cm
        distance = distance/100;
        var distView = View.findDrawableById("distText") as Text;
        distView.setText(Utils.filledK(distance));
        var distanceRes = WatchUi.loadResource(Rez.Drawables.distance) as BitmapResource;
        dc.drawBitmap( 205, 180, distanceRes);

        var calories = info.calories; // kCal
        var caloryView = View.findDrawableById("caloryText") as Text;
        caloryView.setText(Utils.filledK(calories));
        var caloryRes = WatchUi.loadResource(Rez.Drawables.calory) as BitmapResource;
        dc.drawBitmap( 45, 180, caloryRes);
        // 身体电量
        var bodyBatteryView = View.findDrawableById("bodyBatteryText") as Text;
        bodyBatteryView.setText(bodyBattery);
        var bodyBatteryRes = WatchUi.loadResource(Rez.Drawables.bodyBattery) as BitmapResource;
        dc.drawBitmap( 75, 180, bodyBatteryRes);

        var notificationCount = devSettings.notificationCount;
        var msgView = View.findDrawableById("msgText") as Text;
        msgView.setText(notificationCount.toString());
        var messageRes = WatchUi.loadResource(Rez.Drawables.message) as BitmapResource;
        dc.drawBitmap( 140, 182, messageRes); // 要比正常的+2

    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var dateStr = Lang.format("$1$/$2$", [today.month, today.day]);

        var storedKey = Utils.getStoredKey();
        var dateInfo = Storage.getValue(storedKey) as Lang.Dictionary;
        if (dateInfo != null) {
            // 农历
            dc.drawText(130, 230, zhFont, Lang.format("$1$ $2$", [dateInfo["yearTips"], dateInfo["lunarCalendar"]]), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

            // 天气
            var _weatherData = dateInfo["_weatherData"] as Dictionary;
            var weatherView = View.findDrawableById("weatherLabel") as Text;
            dc.drawText(130, 40, zhFont, Lang.format("$1$ $2$", [_weatherData["weather"], _weatherData["temp"]]), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
        var weekStr = Utils.getWeekStr(today.day_of_week);
        dc.drawText(130, 210, zhFont, Lang.format("$1$ $2$", [dateStr, weekStr]), Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);


        
        

        

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
