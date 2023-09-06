import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class CustomMoveBar extends WatchUi.Drawable {

    private var _color, _string;

    public function initialize(params as Dictionary) {
        // You should always call the parent's initializer and
        // in this case you should pass the params along as size
        // and location values may be defined.
        Drawable.initialize(params);

        // Get any extra values you wish to use out of the params Dictionary
        _color = params.get(:color);
        _string = params.get(:string);
    }

    function draw(dc as Dc) as Void {
        // Draw the move bar here
       dc.setColor(_color);
       dc.setText(_string);
    }
}