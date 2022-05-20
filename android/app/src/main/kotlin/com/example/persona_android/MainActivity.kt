package com.example.persona_android

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.withpersona.sdk2.inquiry.*
import androidx.appcompat.app.AppCompatActivity

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/persona"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method =="persona.verification") {
        val personaActivity = PersonaActivity()
        personaActivity.initiatePersonaVerification()
      } else {
        result.notImplemented()
      }
    }
  }
}

class PersonaActivity: AppCompatActivity() {
  companion object {
    private const val TEMPLATE_ID: String = "itmpl_YVq84o2UvqeM1t3B4mFdPbzd"
  }

  private val getInquiry = registerForActivityResult(Inquiry.Contract()) {
        inquiry ->
    when (inquiry) {
        is InquiryResponse.Complete -> {

        }
        is InquiryResponse.Cancel -> {

        }
        is InquiryResponse.Error -> {

        }
    }
  }

  fun initiatePersonaVerification(){
    getInquiry.launch(
        Inquiry.fromTemplate(TEMPLATE_ID)
            .environment(Environment.SANDBOX)
            .build()
    )
  }
}

