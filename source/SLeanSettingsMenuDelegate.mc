import Toybox.WatchUi;


class SLeanSettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

  	function onSelect(item) {
  		var id=item.getId();
        if(id.equals("sec")) {
  			// MySettings.showSecs=!MySettings.showSecs;
  			// MySettings.writeKey(MySettings.showSecsKey,MySettings.showSecs);
  		}
  	}
  	
  	function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		// return false;
    }
}