package com.vietsens.emr;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.app.PendingIntent;
import android.content.Intent;
import android.nfc.NfcAdapter;

public class MainActivity extends FlutterFragmentActivity {
    @Override
    protected void onResume() {
        super.onResume();
        Intent intent = new Intent(this, this.getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(getApplicationContext(), 0, intent, PendingIntent.FLAG_IMMUTABLE);
        NfcAdapter.getDefaultAdapter(getApplicationContext()).enableForegroundDispatch(this, pendingIntent, null, null);
    }

    @Override
    protected void onPause() {
        super.onPause();
        NfcAdapter.getDefaultAdapter(getApplicationContext()).disableForegroundDispatch(this);
    }
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine)
//    {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//    }
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//    }
}
