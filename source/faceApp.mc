import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;

var bgdata="none";

class faceApp extends Application.AppBase {

    var faceViewInstance;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    function onBackgroundData(data){
        System.println("****onBackgroundData****");
        bgdata = "12b";
    }

    function onSettingsChanged() { // triggered by settings change in GCM
        System.println("settings changed");
        faceViewInstance.handleSettingUpdate(); // 交由faceView那边处理配置更新后的逻辑
    }

    function onStorageChanged() {
        System.println("onStorageChanged");
        // 将在storage里面存储的sn存到Properties中
        var snKey = Utils.getStoredSnKey();
        var existedSn = Properties.getValue(snKey);
        // 当前Properties无值时写入
        if (existedSn != null) {
            if (existedSn.equals("") || existedSn.equals("abcxid")) {
                 var sn = Storage.getValue(snKey);
                if (sn != null) {
                    Properties.setValue(snKey, sn);
                }
            }
        }
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var ts = Lang.format("$1$-$2$-$3$ $4$:$5$ ", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u"),
            today.hour.format("%02u"),
            today.min.format("%02u"),
        ]);
        //register for temporal events if they are supported
        if(Toybox.System has :ServiceDelegate) {
            // canDoBG=true;
            Background.registerForTemporalEvent(new Time.Duration(5 * 60));
            System.println(ts + "****background is registered****");
        } else {
            System.println(ts + "****background not available on this device****");
        }
        
        faceViewInstance = new faceView();
        return [ faceViewInstance ] as Array<Views or InputDelegates>;
    }

     function getServiceDelegate(){
    	var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var ts = Lang.format("$1$-$2$-$3$ $4$:$5$ ", [
            today.year.format("%04u"),
            today.month.format("%02u"),
            today.day.format("%02u"),
            today.hour.format("%02u"),
            today.min.format("%02u"),
        ]);
    	System.println("getServiceDelegate: "+ts);
        return [new DateServiceDelegate()];
    }

    function getSettingsView() {
        return [new SLeanSettingsMenu(),new SLeanSettingsMenuDelegate()];
    }   
}

function getApp() as faceApp {
    return Application.getApp() as faceApp;
}