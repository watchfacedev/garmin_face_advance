using Toybox.Background;
using Toybox.Communications;
using Toybox.System;
import Toybox.Lang;
import Toybox.Application.Storage;


(:background)
class DateServiceDelegate extends System.ServiceDelegate {
    function initialize() {
		System.ServiceDelegate.initialize();
	}
    // When a scheduled background event triggers, make a request to
    // a service and handle the response with a callback function
    // within this delegate.
    function onTemporalEvent() {
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dataArr = [today.year.format("%04u"), today.month.format("%02u"), today.day.format("%02u")];
        var storedDate = Lang.format("$1$-$2$-$3$", dataArr);
        // 如果当天已经存储过了，不再继续请求接口
        var dateInfo = Storage.getValue("dateInfo") as Lang.Dictionary<String, Lang.Dictionary>;
        if (dateInfo != null && storedDate.equals(dateInfo["date"])) {
    	    System.println("existed: " + dateInfo["date"]);
            return;
        }
        var requestDate = Lang.format("$1$$2$$3$", dataArr); // 请求和存储值的日期格式不太一样
        new DateHttpRequest("abc").makeRequest(requestDate);
    }

    function responseCallback(responseCode as Number, data as Null or Dictionary or String) as Void {
        // Do stuff with the response data here and send the data
        // payload back to the app that originated the background
        // process.
        Background.exit(110);
    }
}