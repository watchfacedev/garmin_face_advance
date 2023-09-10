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

    static function loadNumberResource(number) {
        if (number == 1) {
            return WatchUi.loadResource(Rez.Drawables.number1) as BitmapResource;
        } else {
            return WatchUi.loadResource(Rez.Drawables.LauncherIcon) as BitmapResource;
        }
    }
}