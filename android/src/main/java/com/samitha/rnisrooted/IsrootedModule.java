package com.samitha.rnisrooted;

import android.os.Build;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

// import io.fabric.sdk.android.services.common.CommonUtils;

public class IsrootedModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public IsrootedModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "Isrooted";
    }

    @ReactMethod
    public void isRooted(Promise promise) {
        try {
            //CommonUtils.isRooted(this.reactContext) || 
            Boolean isDeviceRooted = this.checkRootMethod1() || this.checkRootMethod2() || this.checkRootMethod3() || this.checkRootMethod4();
            promise.resolve(isDeviceRooted);
        }catch (Exception e){
            promise.reject(e);
        }

    }

    private static boolean checkRootMethod1() {
        String buildTags = android.os.Build.TAGS;
        return buildTags != null && buildTags.contains("test-keys");
    }

    private static boolean checkRootMethod2() {
        String[] paths = { "/system/app/Superuser.apk", "/sbin/su", "/system/bin/su", "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
                "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su"};
        for (String path : paths) {
            if (new File(path).exists()) return true;
        }
        return false;
    }

    private static boolean checkRootMethod3() {
        Process process = null;
        try {
            process = Runtime.getRuntime().exec(new String[] { "/system/xbin/which", "su" });
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            if (in.readLine() != null) return true;
            return false;
        } catch (Throwable t) {
            return false;
        } finally {
            if (process != null) process.destroy();
        }
    }

    private static boolean checkRootMethod4() {

        return Build.FINGERPRINT.contains("generic");
    }

}
