import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_user_notifier.dart';
import 'package:music_app/core/theme/theme.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music_app/features/home/view/pages/upload_song_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music App',
          theme: AppTheme.darkThemeMode,
          home:
              currentUser == null ? const SignupPage() : const UploadSongPage(),
        );
      },
    );
  }
}
