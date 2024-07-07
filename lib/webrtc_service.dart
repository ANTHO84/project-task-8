import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  Future<List<MediaDeviceInfo>> getMediaDevices() async {
    return await navigator.mediaDevices.enumerateDevices();
  }

  Future<MediaStream> getUserMedia(Map<String, dynamic> constraints) async {
    return await navigator.mediaDevices.getUserMedia(constraints);
  }
}
