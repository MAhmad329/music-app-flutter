import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_song_notifier.dart';
import 'package:music_app/core/utils.dart';

import '../../../../core/theme/app_palette.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    if (currentSong == null) {
      return const SizedBox();
    }

    return Stack(
      children: [
        Container(
          height: 66.h,
          width: MediaQuery.of(context).size.width - 16.w,
          decoration: BoxDecoration(
            color: hexToColor(currentSong.hex_code),
            borderRadius: BorderRadius.circular(
              4.r,
            ),
          ),
          padding: EdgeInsets.all(9.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(currentSong.thumbnail_url),
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentSong.song_name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        currentSong.artist,
                        style: TextStyle(
                          color: Palette.subtitleText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart,
                      color: Palette.whiteColor,
                    ),
                  ),
                  IconButton(
                    onPressed: songNotifier.playPause,
                    icon: Icon(
                      songNotifier.isPlaying
                          ? CupertinoIcons.pause_fill
                          : CupertinoIcons.play_fill,
                      color: Palette.whiteColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        StreamBuilder(
          stream: songNotifier.audioPlayer?.positionStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            final position = snapshot.data;
            final duration = songNotifier.audioPlayer?.duration;
            double sliderValue = 0.0;
            if (position != null && duration != null) {
              sliderValue = position.inMilliseconds / duration.inMilliseconds;
            }

            return Positioned(
              bottom: 0.h,
              left: 8.w,
              child: Container(
                height: 2.h,
                width: sliderValue * (MediaQuery.of(context).size.width - 32.w),
                decoration: BoxDecoration(
                  color: Palette.whiteColor,
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 8.w,
          child: Container(
            height: 2.h,
            width: MediaQuery.of(context).size.width - 32.w,
            decoration: BoxDecoration(
              color: Palette.inactiveSeekColor,
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
        ),
      ],
    );
  }
}