import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


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
        var testView = View.findDrawableById("TextLabel") as Text;
        testView.setText("a watch face2?");

        
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // var mySmiley = new Rez.Drawables.Smiley2();
        // mySmiley.draw( dc );

        //  var _customMoveBar = new Rez.Drawables.CustomMoveBar();
        // _customMoveBar.draw(dc);

        
        // dc.drawArc(100,100,16, Graphics.ARC_CLOCKWISE ,90,360);


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        Utils.drawCircle(dc, {
            :width=>10,
            :x=>130,
            :y=>130,
            :r=>130,
            :fullStart=>90,
            :fullEnd=>90,
            :end=>180,
            :color=>Graphics.COLOR_RED,
            :bgColor=>Graphics.COLOR_DK_GRAY,
        });

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
