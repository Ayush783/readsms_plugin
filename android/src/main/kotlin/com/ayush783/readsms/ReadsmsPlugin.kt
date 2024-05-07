package com.ayush783.readsms

import android.app.Activity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.provider.Telephony
import android.util.Log
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class ReadsmsPlugin: FlutterPlugin, EventChannel.StreamHandler,BroadcastReceiver(), ActivityAware {
  private var channel : EventChannel? = null

  private var eventSink: EventChannel.EventSink? = null
  /**
   * context object to get the current context and register
   * the broadcast receiver
   */
  private lateinit var context: Context
  private lateinit var activity: Activity


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    context.registerReceiver(this,IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
    channel = EventChannel(flutterPluginBinding.binaryMessenger,"readsms")
    channel!!.setStreamHandler(this)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }

  override fun onReceive(p0: Context?, p1: Intent?) {
    /**
     * Get the messages through the broadcast receiver
     * using the Telephony.Sms.Intent
     */
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT){
      for (sms in Telephony.Sms.Intents.getMessagesFromIntent(p1)) {
        // Log.d("msg sender", sms.originatingAddress.toString())
        // Log.d("msg time",sms.timestampMillis.toString())
        var data = listOf(sms.displayMessageBody,sms.originatingAddress.toString(),sms.timestampMillis.toString(),)
        eventSink?.success(data)
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel = null
    eventSink = null
  }

  override fun onAttachedToActivity(p0: ActivityPluginBinding) {
    activity = p0.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }
}
