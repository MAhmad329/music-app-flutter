import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_song_notifier.dart';
import 'package:music_app/features/home/view/pages/upload_song_page.dart';
import 'package:music_app/features/home/viewmodel/home_viewmodel.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/loader.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFavSongsProvider).when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == data.length) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UploadSongPage(),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Palette.backgroundColor,
                    child: const Icon(CupertinoIcons.plus),
                  ),
                  title: Text(
                    'Upload New Song',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                    ),
                  ),
                );
              }
              final song = data[index];
              return ListTile(
                onTap: () {
                  ref
                      .read(currentSongNotifierProvider.notifier)
                      .updateSong(song);
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(song.thumbnail_url),
                  radius: 35.r,
                  backgroundColor: Palette.backgroundColor,
                ),
                title: Text(
                  song.song_name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
                subtitle: Text(
                  song.artist,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              );
            },
          );
        },
        error: (error, st) {
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        loading: () => const Loader());
  }
}
