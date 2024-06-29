import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_image_notifier.g.dart';

@riverpod
class CurrentImageNotifier extends _$CurrentImageNotifier {
  @override
  File? build() {
    return null;
  }

  void updateImage(File image) {
    state = image;
  }
}
