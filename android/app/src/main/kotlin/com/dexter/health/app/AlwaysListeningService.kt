package com.dexter.health.app

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.ActivityCompat
import kotlin.concurrent.thread

class AlwaysListeningService : Service() {

    private var isRecording = false
    private lateinit var audioRecord: AudioRecord
    private val sampleRate = 44100 // this is the standard sample rate for high quality audio
    private val channelConfig = AudioFormat.CHANNEL_IN_MONO
    private val audioFormat = AudioFormat.ENCODING_PCM_16BIT
    private val bufferSize = AudioRecord.getMinBufferSize(sampleRate, channelConfig, audioFormat)

    private fun startForegroundService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "AlwaysListeningServiceChannel",
                "Always Listening Service",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)

            val notification: Notification = Notification.Builder(this, "AlwaysListeningServiceChannel")
                .setContentTitle("Always Listening")
                .setContentText("This app is always listening to you. Every 10 seconds, we send that audio to our STT API.")
                .build()
            startForeground(1, notification)
        }
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        startRecording()
        return START_STICKY
    }

    private fun startRecording() {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            return
        }
        startForegroundService()

        audioRecord = AudioRecord(MediaRecorder.AudioSource.MIC, sampleRate, channelConfig, audioFormat, bufferSize)
        isRecording = true
        audioRecord.startRecording()

        thread {
            val data = ByteArray(bufferSize)
            try {
                while (isRecording) {
                    val readBytes = audioRecord.read(data, 0, bufferSize)
                    if (readBytes > 0) {
                        // send the data to the Flutter app so it can create a .wav file for the recording
                        sendDataToFlutterApp(data.copyOf(readBytes))
                    }
                }
            } catch (e: Exception) {
                Log.e("AlwaysListeningService","Exception: ${e.message}")
                stopRecording()
            } finally {
                stopRecording()
            }

        }
    }

    private fun sendDataToFlutterApp(data: ByteArray) {
        val intent = Intent(AUDIO_DATA_ACTION)
        intent.putExtra(AUDIO_DATA_EXTRA, data)
        sendBroadcast(intent)
    }

    private fun stopRecording() {
        isRecording = false
        audioRecord.stop()
        audioRecord.release()
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isRecording) {
            stopRecording()
        }
    }

    companion object {
        const val AUDIO_DATA_ACTION = "AUDIO_DATA"
        const val AUDIO_DATA_EXTRA = "AUDIO_DATA_EXTRA"
    }
}
