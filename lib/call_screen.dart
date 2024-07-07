import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'media_provider.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Consumer<MediaProvider>(
        builder: (context, mediaProvider, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: RTCVideoView(mediaProvider.localRenderer),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        mediaProvider.toggleCamera();
                      },
                      child: Icon(Icons.switch_camera),
                    ),
                    SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () {
                        mediaProvider.addParticipant();
                      },
                      child: Icon(Icons.person_add),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Participants: ${mediaProvider.participantsCount}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              // Simulated caller image
              Positioned(
                top: 20,
                right: 20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/caller_image.jpg'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
