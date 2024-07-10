import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_page_notifier.dart';
import 'package:music_app/features/home/view/pages/library_page.dart';
import 'package:music_app/features/home/view/pages/songs_page.dart';
import 'package:music_app/features/home/view/widgets/music_slab.dart';

import '../../../../core/theme/app_palette.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final pages = const [
    SongsPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(currentPageNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          pages[selectedPage],
          Positioned(
            bottom: 0.h,
            child: const MusicSlab(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (value) {
          ref.read(currentPageNotifierProvider.notifier).updatePage(value);
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                selectedPage == 0
                    ? 'assets/images/home_filled.png'
                    : 'assets/images/home_unfilled.png',
                color: selectedPage == 0
                    ? Palette.whiteColor
                    : Palette.inactiveBottomBarItemColor,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/library.png',
                color: selectedPage == 1
                    ? Palette.whiteColor
                    : Palette.inactiveBottomBarItemColor,
              ),
              label: 'Library'),
        ],
      ),
    );
  }
}
