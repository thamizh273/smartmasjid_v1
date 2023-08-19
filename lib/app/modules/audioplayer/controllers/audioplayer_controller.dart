import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioplayerController extends GetxController {
  //TODO: Implement AudioplayerController
  AudioPlayer audioPlayer = AudioPlayer();

  String audioUrl =
      'https://qurancentral.com/aaar-al-hudhoudi-001-al-fatiha'; // Replace with your audio URL

  RxBool isPlaying = false.obs;
  RxDouble sliderValue = 0.0.obs;
  Duration totalDuration = Duration();
  Duration currentPosition = Duration();

  final count = 0.obs;


  @override
  void onInit() {
    super.onInit();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        isPlaying.value = true;
      } else {
        isPlaying.value = false;
      }
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      sliderValue.value = position.inMilliseconds.toDouble();
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      totalDuration = duration;
    });
  }

  void play() {
     audioPlayer.play(audioUrl as Source);
    isPlaying.value = true;
  }

  void pause() {
    audioPlayer.pause();
    isPlaying.value = false;
  }

  void stop() {
    audioPlayer.stop();
    isPlaying.value = false;
    sliderValue.value = 0.0;
  }

  void seekTo(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer.release();
    super.onClose();
  }

  void increment() => count.value++;
}
