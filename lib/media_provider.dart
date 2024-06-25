import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webrtc/webrtc_service.dart';

class MediaProvider extends ChangeNotifier {
  final _webrtcService = WebRTCService();
  final _localRenderer = RTCVideoRenderer();

  bool _isLoading = true;
  bool _isGettingDevices = true;
  bool _isFrontCamera = true;
  List<MediaDeviceInfo> _mediaDevices = [];
  String? _selectedVideoDeviceId;
  String? _selectedAudioDeviceId;

  MediaProvider() {
    _initializeRenderers();
    _getMediaDevices();
    _getUserMedia();
  }

  bool get isLoading => _isLoading;
  bool get isGettingDevices => _isGettingDevices;
  RTCVideoRenderer get localRenderer => _localRenderer;
  List<MediaDeviceInfo> get videoDevices =>
      _mediaDevices.where((device) => device.kind == 'videoinput').toList();
  List<MediaDeviceInfo> get audioDevices =>
      _mediaDevices.where((device) => device.kind == 'audioinput').toList();
  String? get selectedVideoDeviceId => _selectedVideoDeviceId;
  String? get selectedAudioDeviceId => _selectedAudioDeviceId;

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
  }

  Future<void> _getMediaDevices() async {
    _isGettingDevices = true;
    _mediaDevices = await _webrtcService.getMediaDevices();
    _isGettingDevices = false;
    notifyListeners();
  }

  Future<void> _getUserMedia() async {
    _isLoading = true;
    try {
      final constraints = {
        'audio': {
          'deviceId': _selectedAudioDeviceId,
        },
        'video': {
          'deviceId': _selectedVideoDeviceId,
          'facingMode': _isFrontCamera ? 'user' : 'environment',
        },
      };
      var stream = await _webrtcService.getUserMedia(constraints);
      _localRenderer.srcObject = stream;
    } catch (e) {
      print('Lỗi khi lấy media: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  void selectVideoDevice(String? deviceId) {
    _selectedVideoDeviceId = deviceId;
    _getUserMedia();
  }

  void selectAudioDevice(String? deviceId) {
    _selectedAudioDeviceId = deviceId;
    _getUserMedia();
  }

  void toggleCamera() {
    _isFrontCamera = !_isFrontCamera;
    _getUserMedia();
  }
}
