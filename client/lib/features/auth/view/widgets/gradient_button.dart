import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/theme/app_palette.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const GradientButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          7,
        ),
        gradient: const LinearGradient(
          colors: [
            Palette.gradient1,
            Palette.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            395.w,
            55.h,
          ),
          backgroundColor: Palette.transparentColor,
          shadowColor: Palette.transparentColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
