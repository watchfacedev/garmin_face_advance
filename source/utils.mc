import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;

class Utils {
    // 在指定位置话圆圈
    static function drawCircle(dc, options as Dictionary) {
        dc.setPenWidth(options.get(:width));
        dc.setColor(options.get(:bgColor), options.get(:bgColor));
        dc.drawArc(options.get(:x), options.get(:y), options.get(:r), Graphics.ARC_CLOCKWISE, options.get(:fullStart),  options.get(:fullEnd));
        dc.setColor(options.get(:color), options.get(:bgColor));
        dc.drawArc(options.get(:x), options.get(:y), options.get(:r), Graphics.ARC_CLOCKWISE, options.get(:fullStart),  options.get(:end));
    }

    static function loadNumberResource(numberText) {
        var number = numberText.toNumber();
        if (number == 0) {
            return WatchUi.loadResource(Rez.Drawables.number0) as BitmapResource;
        } else if (number == 1) {
            return WatchUi.loadResource(Rez.Drawables.number1) as BitmapResource;
        } else if (number == 2) {
            return WatchUi.loadResource(Rez.Drawables.number2) as BitmapResource;
        } else if (number == 3) {
            return WatchUi.loadResource(Rez.Drawables.number3) as BitmapResource;
        } else if (number == 4) {
            return WatchUi.loadResource(Rez.Drawables.number4) as BitmapResource;
        } else if (number == 5) {
            return WatchUi.loadResource(Rez.Drawables.number5) as BitmapResource;
        } else if (number == 6) {
            return WatchUi.loadResource(Rez.Drawables.number6) as BitmapResource;
        } else if (number == 7) {
            return WatchUi.loadResource(Rez.Drawables.number7) as BitmapResource;
        } else if (number == 8) {
            return WatchUi.loadResource(Rez.Drawables.number8) as BitmapResource;
        } else if (number == 9) {
            return WatchUi.loadResource(Rez.Drawables.number9) as BitmapResource;
        } else {
            return WatchUi.loadResource(Rez.Drawables.number0) as BitmapResource;
        }
    }
}