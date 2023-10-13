import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.ActivityMonitor;
import Toybox.Communications;
import Toybox.Application.Storage;
import Toybox.Application.Properties;

(:background)
class DateHttpRequest {
    protected var onAfterReceive;
    public function initialize(onAfterReceiveArg) {
        onAfterReceive = onAfterReceiveArg;
    }
    
    function onReceive(responseCode as Number, responseData as Null or Dictionary or String) as Void {
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var ts = Lang.format("$1$-$2$-$3$ $4$:$5$ ", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u"),
            today.hour.format("%02u"),
            today.min.format("%02u"),
        ]);
    	System.println(ts + " onReceive: " + responseCode);
        System.println("responseData: " + responseData);
        if (responseCode == 200) {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            System.println("Request Successful:" + responseData["msg"]);
            if (responseData["code"] == 1) {
                var storedKey = Utils.getStoredKey();
                var dateInfo = responseData["data"] as Dictionary;
                var sn = dateInfo["_sn"];
                // 保存sn和dateInfo，触发onStorageChanged事件
                Storage.setValue(Utils.getStoredSnKey(), sn);
                System.println("sn saved:" + sn);
                Storage.setValue(storedKey, dateInfo);
                // self.onAfterReceive.invoke();
            }
        } else {
            // Ui.popView(Ui.SLIDE_IMMEDIATE);
            // self.onAfterReceive.invoke("Can't connect:" + responseCode + "\n" + Storage.getValue("test1"));
        }        
    }

    function makeRequest(date as String) as Void {
        // Ui.pushView( new LoadingView(), null, Ui.SLIDE_IMMEDIATE);
        var url = "https://gateway.daozhao.com.cn/garmin/daily";
        var app = Application.getApp();
        
        var params = {
            "sn" => Properties.getValue("sn"),
            "key" => Properties.getValue("key"),
        };
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_POST,
            // :headers => {
            //     "Authorization" => app.getProperty("apikey"),
            //     "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            // },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        var responseCallback = method(:onReceive);
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var ts = Lang.format("$1$-$2$-$3$ $4$:$5$ ", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u"),
            today.hour.format("%02u"),
            today.min.format("%02u"),
        ]);
    	System.println(ts + " makeRequest: " + url);
        Communications.makeWebRequest(url, params, options, responseCallback);
    }
}