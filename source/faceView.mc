import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;


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
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        // 设置小时、分钟
        var hourView = View.findDrawableById("hourLabel") as Text;
        hourView.setText(clockTime.hour.format(("%02d")));

        var minuteView = View.findDrawableById("minuteLabel") as Text;
        minuteView.setText(clockTime.min.format(("%02d")));

        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        System.println(Lang.format("$1$-$2$-$3$", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u")
        ]));



       

        //  var _customMoveBar = new Rez.Drawables.CustomMoveBar();
        // _customMoveBar.draw(dc);

        
        // dc.drawArc(100,100,16, Graphics.ARC_CLOCKWISE ,90,360);


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

    
        // 最外层的电量
        Utils.drawCircle(dc, {
            :width=>10,
            :x=>130,
            :y=>130,
            :r=>130,
            :fullStart=>75,
            :fullEnd=>105,
            :end=>180,
            :color=>Graphics.COLOR_DK_BLUE,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var batteryView = View.findDrawableById("batteryLabel") as Text;
        batteryView.setText("73%");

         // 最外层的电量
        Utils.drawCircle(dc, {
            :width=>3,
            :x=>180,
            :y=>80,
            :r=>24,
            :fullStart=>100,
            :fullEnd=>120,
            :end=>60,
            :color=>Graphics.COLOR_DK_BLUE,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });
        var stepView = View.findDrawableById("stepLabel") as Text;
        stepView.setText("2800");

        var imageContainer = new Rez.Drawables.ImageContainer();
        imageContainer.draw( dc );


        
        // var ImageContainerView = View.findDrawableById("ImageContainer");

        // var mouthView = View.findDrawableById("mouth") as Bitmap;
        // mouthView.setBitmoumap(res);

        

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
