import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webrtc/media_provider.dart';
import 'package:webrtc/video_view.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<MediaProvider>(
        builder: (context, mediaProvider, child) {
          return Column(
            children: [
              mediaProvider.isGettingDevices
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Đang lấy danh sách thiết bị media'),
                      ],
                    )
                  : Column(
                      children: [
                        mediaProvider.isLoading
                            ? Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Text('Đang lấy media từ thiết bị...'),
                                ],
                              )
                            : Expanded(
                                child: VideoView(mediaProvider.localRenderer),
                              ),
                        DropdownButton<String>(
                          value: mediaProvider.selectedVideoDeviceId,
                          items: mediaProvider.videoDevices.map((device) {
                            return DropdownMenuItem(
                              value: device.deviceId,
                              child: Text(device.label ?? 'Camera'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            mediaProvider.selectVideoDevice(value);
                          },
                          hint: Text('Chọn thiết bị camera'), 
                        ),
                        DropdownButton<String>(
                          value: mediaProvider.selectedAudioDeviceId,
                          items: mediaProvider.audioDevices.map((device) {
                            return DropdownMenuItem(
                              value: device.deviceId,
                              child: Text(device.label ?? 'Microphone'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            mediaProvider.selectAudioDevice(value);
                          },
                          hint: Text('Chọn thiết bị microphone'),
                        ),
                        ElevatedButton(
                          onPressed: mediaProvider.toggleCamera,
                          child: Text('Chuyển đổi camera'),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
