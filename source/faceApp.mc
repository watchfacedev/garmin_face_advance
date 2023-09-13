import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

var bgdata="none";

(:background)
class faceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        //register for temporal events if they are supported
        if(Toybox.System has :ServiceDelegate) {
            // canDoBG=true;
            Background.registerForTemporalEvent(new Time.Duration(5 * 60));
            System.println("****background is registered****");
        } else {
            System.println("****background not available on this device****");
        }

        return [ new faceView() ] as Array<Views or InputDelegates>;
    }

     function getServiceDelegate(){
    	var now=System.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");    
    	System.println("getServiceDelegate: "+ts);
        return [new MyServiceDelegate()];
    }

    function onBackgroundData(data){
        System.println("****onBackgroundData****");
        bgdata = "12b";
    }

}

function getApp() as faceApp {
    return Application.getApp() as faceApp;
}