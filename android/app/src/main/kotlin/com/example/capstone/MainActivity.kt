package com.example.capstone
import android.os.Bundle

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Remove default white background
        window.setBackgroundDrawableResource(android.R.color.transparent)
    }
}
