import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webrtc/home_page.dart';
import 'package:webrtc/media_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MediaProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebRTC ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'WebRTC '),
    );
  }
}
