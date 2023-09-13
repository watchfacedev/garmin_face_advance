import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.ActivityMonitor;
import Toybox.Communications;

(:background)
class HttpRequest {
    protected var onAfterReceive;
    public function initialize(onAfterReceiveArg) {
        onAfterReceive = onAfterReceiveArg;
    }
    
    function onReceive(responseCode as Number, data as Null or Dictionary or String) as Void {
        if (responseCode == 200) {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            // System.println("Request Successful");
            // Extensions.setPropertyAndStorage("test", data["test"]);
            // Extensions.setPropertyAndStorage("test1", data["test1"] + "/" + data["test2"]);
            // self.onAfterReceive.invoke();
        } else {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            System.println("Response: " + responseCode);
            // self.onAfterReceive.invoke("Can't connect:" + responseCode + "\n" + Extensions.getPropertyOrStorage("test1"));
        }        
    }

    function makeRequest() as Void {
        // Ui.pushView( new LoadingView(), null, Ui.SLIDE_IMMEDIATE);
        var url = "https://removed";
        var app = Application.getApp();
        
        var params = {
            "definedParams" => "123456789abcdefg"
        };
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {
                "Authorization" => app.getProperty("apikey"),
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        var responseCallback = method(:onReceive);
        Communications.makeWebRequest(url, params, options, responseCallback);   // ERROR
    }
}