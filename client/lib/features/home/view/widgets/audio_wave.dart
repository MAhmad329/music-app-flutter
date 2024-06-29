import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/theme/app_palette.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key, required this.path});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    if (!playerController.playerState.isPlaying) {
      await playerController.startPlayer(finishMode: FinishMode.loop);
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            playerController.playerState.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: Size(double.infinity, 100.h),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Palette.borderColor,
              liveWaveColor: Palette.gradient2,
              showSeekLine: false,
              spacing: 5,
            ),
          ),
        ),
      ],
    );
  }
}
