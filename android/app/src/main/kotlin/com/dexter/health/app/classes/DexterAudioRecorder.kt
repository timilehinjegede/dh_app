package com.dexter.health.app.classes

import android.media.AudioRecord
import com.dexter.health.app.interfaces.AudioRecorder

class DexterAudioRecorder : AudioRecorder {
    private lateinit var audioRecord: AudioRecord

    override fun startRecording() {
        audioRecord.startRecording()
    }

    override fun stopRecording() {
        audioRecord.stop()
    }
}
