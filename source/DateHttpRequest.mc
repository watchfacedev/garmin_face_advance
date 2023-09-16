import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.ActivityMonitor;
import Toybox.Communications;
import Toybox.Application.Storage;

(:background)
class DateHttpRequest {
    protected var onAfterReceive;
    public function initialize(onAfterReceiveArg) {
        onAfterReceive = onAfterReceiveArg;
    }
    
    function onReceive(responseCode as Number, responseData as Null or Dictionary or String) as Void {
        System.println("responseData: " + responseData);
        if (responseCode == 200) {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            System.println("Request Successful:" + responseData["msg"]);
            if (responseData["code"] == 1) {
                Storage.setValue("dateInfo", responseData["data"]);
                var dateInfo = Storage.getValue("dateInfo");
                System.println("get set dateInfo: " + dateInfo);
                // self.onAfterReceive.invoke();
            }
        } else {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            System.println("responseCode: " + responseCode);
            // self.onAfterReceive.invoke("Can't connect:" + responseCode + "\n" + Storage.getValue("test1"));
        }        
    }

    function makeRequest(date as String) as Void {
        // Ui.pushView( new LoadingView(), null, Ui.SLIDE_IMMEDIATE);
        var url = "https://www.mxnzp.com/api/holiday/single/" + date + "?ignoreHoliday=false&app_id=ktxnjmfvhcpoponl&app_secret=QUdGaVZJTzZreTZoZitzVUlrTGVoZz09";
        var app = Application.getApp();
        
        var params = {
            // "definedParams" => "123456789abcdefg"
        };
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            // :headers => {
            //     "Authorization" => app.getProperty("apikey"),
            //     "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            // },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        var responseCallback = method(:onReceive);
        Communications.makeWebRequest(url, params, options, responseCallback);
    }
}