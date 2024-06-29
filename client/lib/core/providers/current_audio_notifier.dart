import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_audio_notifier.g.dart';

@riverpod
class CurrentAudioNotifier extends _$CurrentAudioNotifier {
  @override
  File? build() {
    return null;
  }

  void updateAudio(File audio) {
    state = audio;
  }
}
