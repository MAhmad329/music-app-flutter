import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/providers/current_audio_notifier.dart';
import 'package:music_app/core/providers/current_color_notifier.dart';
import 'package:music_app/core/providers/current_image_notifier.dart';
import 'package:music_app/core/theme/app_palette.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/core/widgets/custom_field.dart';
import 'package:music_app/features/home/view/widgets/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  File? selectedAudio;

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      ref.read(currentAudioNotifierProvider.notifier).updateAudio(pickedAudio);
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      ref.read(currentImageNotifierProvider.notifier).updateImage(pickedImage);
    }
  }

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = ref.watch(currentColorNotifierProvider);
    final selectedImage = ref.watch(currentImageNotifierProvider);
    final selectedAudio = ref.watch(currentAudioNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        title: const Text('Upload Song'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child:
                                Image.file(selectedImage, fit: BoxFit.cover)))
                    : DottedBorder(
                        color: Palette.borderColor,
                        dashPattern: const [10, 5],
                        radius: Radius.circular(10.r),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: SizedBox(
                          height: 150.h,
                          width: double.infinity.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              const Text('Select the thumbnail for your song'),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 40.h,
              ),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio.path)
                  : CustomField(
                      hintText: 'Pick Song',
                      controller: null,
                      readOnly: true,
                      onTap: selectAudio,
                    ),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                hintText: 'Artist',
                controller: artistController,
                onTap: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                hintText: 'Song Name',
                controller: songNameController,
                onTap: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
              ColorPicker(
                  pickersEnabled: const {ColorPickerType.wheel: true},
                  color: selectedColor ?? Palette.cardColor,
                  onColorChanged: (Color color) {
                    ref
                        .read(currentColorNotifierProvider.notifier)
                        .updateColor(color);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
