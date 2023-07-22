import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/audioplayer_controller.dart';

class AudioPlayerScreen extends StatelessWidget {
  final AudioplayerController controller = Get.put(AudioplayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
                  () => IconButton(
                icon: Icon(controller.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow),
                iconSize: 64.0,
                onPressed: () {
                  if (controller.isPlaying.value) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
              ),
            ),
            Obx(
                  () => Slider(
                value: controller.sliderValue.value,
                min: 0.0,
                    max: controller.totalDuration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  controller.seekTo(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
