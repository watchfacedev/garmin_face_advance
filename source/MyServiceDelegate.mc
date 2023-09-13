using Toybox.Background;
using Toybox.Communications;
using Toybox.System;
import Toybox.Lang;


(:background)
class MyServiceDelegate extends System.ServiceDelegate {
    function initialize() {
		System.ServiceDelegate.initialize();
	}
    // When a scheduled background event triggers, make a request to
    // a service and handle the response with a callback function
    // within this delegate.
    function onTemporalEvent() {
        new HttpRequest("abc").makeRequest();
    }

    function responseCallback(responseCode as Number, data as Null or Dictionary or String) as Void {
        // Do stuff with the response data here and send the data
        // payload back to the app that originated the background
        // process.
        Background.exit(110);
    }
}