import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_song_notifier.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/features/home/viewmodel/home_viewmodel.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/loader.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedSongs =
        ref.watch(homeViewmodelProvider.notifier).getRecentlyPlayedSongs();
    final currentSong = ref.watch(currentSongNotifierProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: currentSong == null
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  hexToColor(currentSong.hex_code),
                  Palette.transparentColor
                ],
                stops: const [0.0, 0.4],
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.0.w,
              right: 16.0.w,
              bottom: 36.h,
            ),
            child: SizedBox(
              height: 280.h,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: recentlyPlayedSongs.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final song = recentlyPlayedSongs[index];
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(currentSongNotifierProvider.notifier)
                            .updateSong(song);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.borderColor,
                            borderRadius: BorderRadius.circular(6.r)),
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Row(
                          children: [
                            Container(
                              width: 56.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(song.thumbnail_url),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.r),
                                    bottomLeft: Radius.circular(4.r)),
                              ),
                            ),
                            SizedBox(
                              width: 8.0.w,
                            ),
                            Flexible(
                              child: Text(
                                song.song_name,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Text(
              'Latest Today',
              style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700),
            ),
          ),
          ref.watch(getAllSongsProvider).when(
                data: (songs) {
                  print(songs);
                  return SizedBox(
                    height: 260.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final song = songs[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongNotifierProvider.notifier)
                                .updateSong(song);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180.w,
                                  height: 180.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(song.thumbnail_url),
                                    ),
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    song.song_name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    song.artist,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Palette.subtitleText,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, st) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
                loading: () => const Loader(),
              )
        ],
      ),
    );
  }
}
