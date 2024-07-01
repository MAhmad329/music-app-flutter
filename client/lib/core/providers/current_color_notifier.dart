import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_color_notifier.g.dart';

@riverpod
class CurrentColorNotifier extends _$CurrentColorNotifier {
  @override
  Color? build() {
    return Palette.cardColor;
  }

  void updateColor(Color color) {
    state = color;
  }
}
