import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class MediaProvider extends ChangeNotifier {
  bool isGettingDevices = true;
  bool isLoading = false;
  String? selectedVideoDeviceId;
  String? selectedAudioDeviceId;
  List<MediaDevice> videoDevices = [];
  List<MediaDevice> audioDevices = [];
  RTCVideoRenderer localRenderer = RTCVideoRenderer();

  MediaProvider() {
    _init();
  }

  Future<void> _init() async {
    await localRenderer.initialize();
    await getMediaDevices();
  }

  Future<void> getMediaDevices() async {
    // Lấy danh sách thiết bị media và cập nhật danh sách
    isGettingDevices = true;
    notifyListeners();
    // Thêm mã để lấy danh sách thiết bị
    isGettingDevices = false;
    notifyListeners();
  }

  Future<void> selectVideoDevice(String? deviceId) async {
    selectedVideoDeviceId = deviceId;
    notifyListeners();
    // Thêm mã để chọn thiết bị video
  }

  Future<void> selectAudioDevice(String? deviceId) async {
    selectedAudioDeviceId = deviceId;
    notifyListeners();
    // Thêm mã để chọn thiết bị audio
  }

  void toggleCamera() {
    // Thêm mã để chuyển đổi camera
  }
}

class MediaDevice {
  final String deviceId;
  final String? label;

  MediaDevice(this.deviceId, this.label);
}
