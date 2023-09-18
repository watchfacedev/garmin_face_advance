import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Communications;

class Utils {
    (:background)
    static function getStoredKey() as String {
        return "guoba";
    }

    static function getNumber(data, defaultData as Number) {
        return data has :toNumber ? data.toNumber() : defaultData;
    }
    static function getWeekStr(number as Number) {
        if(number == 1) {
            return "周日";
        } else if (number == 2) {
            return "周一";
        } else if (number == 3) {
            return "周二";
        } else if (number == 4) {
            return "周三";
        } else if (number == 5) {
            return "周四";
        } else if (number == 6) {
            return "周五";
        } else {
            return "周六";
        }
    }
    static function filledK(number as Number | Float) as String {
        if (number > 1000) {
            number = number.toFloat();
            number = (number/1000).format("%.1f");
            number = number + "K";
        }
        return number.toString();
    }
    // 在指定位置话圆圈
    static function drawCircle(dc, options as Dictionary) {
        dc.setPenWidth(options.get(:width));

        var fullStart = getNumber(options.get(:fullStart), 0);
        var fullEnd = getNumber(options.get(:fullEnd), 100);
        dc.setColor(options.get(:bgColor), options.get(:bgColor)); // 设置总进度颜色
        dc.drawArc(options.get(:x), options.get(:y), options.get(:r), Graphics.ARC_CLOCKWISE, fullStart, fullEnd);
        // 计算当前进度画图位置
        var current = getNumber(options.get(:current), 0);
        if (current > 0) {
            var max = getNumber(options.get(:max), 100);
            if (current > max) {
                current = max;
            }

            var currentProgress = ((360 - (fullEnd - fullStart))*current/max).toNumber();
            var currentPosition = fullStart - currentProgress;
            if (currentPosition < 0) {
                currentPosition = currentPosition + 360;
            }
            dc.setColor(options.get(:color), options.get(:bgColor)); // 设置当前进度颜色
            dc.drawArc(options.get(:x), options.get(:y), options.get(:r), Graphics.ARC_CLOCKWISE, fullStart, currentPosition);
        }
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