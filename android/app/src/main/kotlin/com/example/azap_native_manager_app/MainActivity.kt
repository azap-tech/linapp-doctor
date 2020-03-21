package com.example.azap_app

import android.telephony.SmsManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "sendSms"

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
}
