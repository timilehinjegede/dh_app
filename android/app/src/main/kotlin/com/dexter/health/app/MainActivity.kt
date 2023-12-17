package com.dexter.health.app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.annotation.SuppressLint

class MainActivity : FlutterActivity() {
    private val channelName = "com.dexter.health.app/recording"
    private lateinit var methodChannel: MethodChannel

    private val audioDataReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val audioData = intent.getByteArrayExtra(AlwaysListeningService.AUDIO_DATA_EXTRA)
            audioData?.let {
                methodChannel.invokeMethod("recordingData", it)
            }
        }
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "startListening" -> {
                    startServiceWithReceiver()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        val filter = IntentFilter(AlwaysListeningService.AUDIO_DATA_ACTION)
        registerReceiver(audioDataReceiver, filter)
    }

    private fun startServiceWithReceiver() {
        if (checkPermission()) {
            startRecordingService()
            registerAudioDataReceiver()
        }
    }

    private fun startRecordingService() {
        val intent = Intent(this, AlwaysListeningService::class.java)
        startService(intent)
    }

    private fun checkPermission(): Boolean {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECORD_AUDIO),
                RECORD_AUDIO_REQUEST_CODE
            )
            return false
        }
        return true
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        when (requestCode) {
            RECORD_AUDIO_REQUEST_CODE -> {
                if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    startServiceWithReceiver()
                }
                return
            }
        }
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    private fun registerAudioDataReceiver() {
        val filter = IntentFilter(AlwaysListeningService.AUDIO_DATA_ACTION)
        registerReceiver(this.audioDataReceiver, filter)
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(audioDataReceiver)
    }

    companion object {
        private const val RECORD_AUDIO_REQUEST_CODE = 101
    }
}