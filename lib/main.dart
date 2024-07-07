import 'package:flutter/material.dart';
import 'package:webrtc/incoming_call_screen.dart';
import 'package:webrtc/media_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MediaProvider(),
      child: MaterialApp(
        title: 'Messenger Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IncomingCallScreen(),
      ),
    );
  }
}
