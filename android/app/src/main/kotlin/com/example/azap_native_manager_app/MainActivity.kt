package com.example.azap_app

import android.telephony.SmsManager
import androidx.annotation.NonNull
import android.app.admin.DevicePolicyManager
import android.app.admin.SystemUpdatePolicy
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
import android.os.UserManager
import android.provider.Settings
import android.view.View
import android.widget.Toast
import com.example.azap_native_manager_app.MyDeviceAdminReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "sendSms"
    private lateinit var mAdminComponentName: ComponentName
    private lateinit var mDevicePolicyManager: DevicePolicyManager

    companion object {
        const val LOCK_ACTIVITY_KEY = "com.example.azap_app.MainActivity"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mAdminComponentName = MyDeviceAdminReceiver.getComponentName(this)
        mDevicePolicyManager = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager

        var isAdmin = false
        if (mDevicePolicyManager.isDeviceOwnerApp(packageName)) {
            Toast.makeText(applicationContext, "device owner", Toast.LENGTH_SHORT).show()
            isAdmin = true
        } else {
            Toast.makeText(applicationContext, "not device owner", Toast.LENGTH_SHORT).show()
        }
        setKioskPolicies(true, isAdmin)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall?, result: MethodChannel.Result? ->
                    if (call?.method.equals("send")) {
                        val num: String? = call?.argument("phone")
                        val msg: String? = call?.argument("msg")
                        result?.let { sendSMS(num, msg, it) }
                    } else {
                        result?.notImplemented()
                    }
                }
    }

    private fun sendSMS(phoneNumber: String?, msg: String?, result: MethodChannel.Result) {
        try {
            val smsManager: SmsManager = SmsManager.getDefault()
            val length: Int = message.length
            val MAX_SMS_MESSAGE_LENGTH = 160
            if (length > MAX_SMS_MESSAGE_LENGTH) {
                val messagelist: ArrayList<String> = smsManager.divideMessage(message)
                smsManager.sendMultipartTextMessage(phoneNumber, null, messagelist, null, null)
            } else {
                smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            }
            result.success("SMS Sent")
        } catch (ex: Exception) {
            ex.printStackTrace()
            result.error("Err", "Sms Not Sent", "")
        }
    }

    private fun setKioskPolicies(enable: Boolean, isAdmin: Boolean) {
        if (isAdmin) {
            setRestrictions(enable)
            enableStayOnWhilePluggedIn(enable)
            setUpdatePolicy(enable)
            setKeyGuardEnabled(enable)
        }
        setLockTask(enable, isAdmin)
        setImmersiveMode(enable)
    }

    // region restrictions
    private fun setRestrictions(disallow: Boolean) {
        setUserRestriction(UserManager.DISALLOW_SAFE_BOOT, disallow)
        setUserRestriction(UserManager.DISALLOW_FACTORY_RESET, disallow)
        setUserRestriction(UserManager.DISALLOW_ADD_USER, disallow)
        setUserRestriction(UserManager.DISALLOW_MOUNT_PHYSICAL_MEDIA, disallow)
        setUserRestriction(UserManager.DISALLOW_ADJUST_VOLUME, disallow)
    }

    private fun setUserRestriction(restriction: String, disallow: Boolean) = if (disallow) {
        mDevicePolicyManager.addUserRestriction(mAdminComponentName, restriction)
    } else {
        mDevicePolicyManager.clearUserRestriction(mAdminComponentName, restriction)
    }
    // endregion

    private fun enableStayOnWhilePluggedIn(active: Boolean) = if (active) {
        mDevicePolicyManager.setGlobalSetting(mAdminComponentName,
            Settings.Global.STAY_ON_WHILE_PLUGGED_IN,
            Integer.toString(BatteryManager.BATTERY_PLUGGED_AC
                or BatteryManager.BATTERY_PLUGGED_USB
                or BatteryManager.BATTERY_PLUGGED_WIRELESS))
    } else {
        mDevicePolicyManager.setGlobalSetting(mAdminComponentName, Settings.Global.STAY_ON_WHILE_PLUGGED_IN, "0")
    }

    private fun setLockTask(start: Boolean, isAdmin: Boolean) {
        if (isAdmin) {
            mDevicePolicyManager.setLockTaskPackages(mAdminComponentName, if (start) arrayOf(packageName) else arrayOf())
        }
        if (start) {
            startLockTask()
        } else {
            stopLockTask()
        }
    }

    private fun setUpdatePolicy(enable: Boolean) {
        if (enable) {
            mDevicePolicyManager.setSystemUpdatePolicy(mAdminComponentName,
                SystemUpdatePolicy.createWindowedInstallPolicy(60, 120))
        } else {
            mDevicePolicyManager.setSystemUpdatePolicy(mAdminComponentName, null)
        }
    }

    private fun setKeyGuardEnabled(enable: Boolean) {
        mDevicePolicyManager.setKeyguardDisabled(mAdminComponentName, !enable)
    }

    private fun setImmersiveMode(enable: Boolean) {
        // Does not work well with flutter: https://github.com/flutter/flutter/issues/23913
        if (enable) {
            window.decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN)
        } else {
            val flags = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
            window.decorView.systemUiVisibility = flags
        }
    }
}
