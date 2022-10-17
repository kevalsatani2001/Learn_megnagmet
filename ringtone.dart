import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// flutter_ringtone_player: ^3.2.0
// assets:
// - assets/ringTone/

class RingTone extends StatefulWidget {
  const RingTone({Key? key}) : super(key: key);

  @override
  State<RingTone> createState() => _RingToneState();
}

class _RingToneState extends State<RingTone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringtone player'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('playAlarm'),
                onPressed: () {
                  FlutterRingtonePlayer.playAlarm();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('playAlarm asAlarm: false'),
                onPressed: () {
                  FlutterRingtonePlayer.playAlarm(asAlarm: false);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('playNotification'),
                onPressed: () {
                  FlutterRingtonePlayer.playNotification();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('playRingtone'),
                onPressed: () {
                  FlutterRingtonePlayer.playRingtone();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('Play from asset (iphone.mp3)'),
                onPressed: () {
                  FlutterRingtonePlayer.play(fromAsset: "assets/ringTone/iphone.mp3");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('Play from asset (android.wav)'),
                onPressed: () {
                  FlutterRingtonePlayer.play(fromAsset: "assets/android.wav");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('play'),
                onPressed: () {
                  FlutterRingtonePlayer.play(
                    android: AndroidSounds.notification,
                    ios: IosSounds.glass,
                    looping: true,
                    volume: 1.0,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('stop'),
                onPressed: () {
                  FlutterRingtonePlayer.stop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
