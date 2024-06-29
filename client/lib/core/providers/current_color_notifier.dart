import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_color_notifier.g.dart';

@riverpod
class CurrentColorNotifier extends _$CurrentColorNotifier {
  @override
  Color? build() {
    return null;
  }

  final color = Colors.yellow;

  void updateColor(Color color) {
    state = color;
  }
}
