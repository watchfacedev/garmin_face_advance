using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

function clamp(value, max, min) {
   if(value > max) {
	   return max;
   }
   else if(value < min) {
	   return min;
   }
   return value;
}
    
class MyProgressBar extends Ui.Drawable {

    hidden var color, locX, locY, width, height, percentage;

    function initialize(params) {
        Drawable.initialize(params);

        color = params.get(:color);
        locX = params.get(:locX);
        locY = params.get(:locY);
        width = params.get(:width);
        height = params.get(:height);
        percentage = 0.0;
    }
    
    function setPercent(value) {
        percentage = clamp(value, 1.0, 0.0);
    }
    
    function draw(dc) {
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_LT_GRAY);
        // dc.drawRectangle(locX, locY, width, height);
        // dc.setColor(color, color);
        // dc.fillRectangle(locX + 2, locY + 2, (width - 4) * percentage, height - 4);

        dc.drawCircle(locX, locY, 20);
        // dc.setColor(color, color);
        // dc.fillRectangle(locX + 2, locY + 2, (width - 4) * percentage, height - 4);
    }
}