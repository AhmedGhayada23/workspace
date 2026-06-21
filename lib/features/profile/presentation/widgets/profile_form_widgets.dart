import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/validator_widget.dart';

/// عنوان قسم (أخضر) في نماذج البروفايل.
class ProfileSectionTitle extends StatelessWidget {
  final String text;
  const ProfileSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF32B599),
      ),
    );
  }
}

/// عنوان حقل (أسود).
class ProfileFieldLabel extends StatelessWidget {
  final String text;
  const ProfileFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.tajawal(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
    );
  }
}

/// زر حفظ التعديلات (الأخضر) المشترك.
class ProfileSaveButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const ProfileSaveButton({
    super.key,
    required this.label,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF32B599),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppSvg.editSvg, color: AppColors.white),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// اختيار الجنس (ذكر/أنثى) في تعديل الملف.
class GenderSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const GenderSelector({super.key, required this.selected, required this.onChanged});

  Widget _radio(int value, String label) {
    final isSelected = selected == value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onChanged(value),
          child: Container(
            width: 24.w,
            height: 24.h,
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              border: Border.all(
                width: isSelected ? 4.w : 2.w,
                color: isSelected ? const Color(0xFF32B599) : const Color(0xFFD6F0EB),
              ),
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? const DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFF32B599), shape: BoxShape.circle),
                  )
                : null,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF32B599),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [_radio(0, 'انثى'), SizedBox(width: 44.w), _radio(1, 'ذكر')]);
  }
}

/// حقل اختيار المستندات (PDF) + معاينتها.
class EditDocumentsField extends StatelessWidget {
  final List<String> filePaths;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  const EditDocumentsField({
    super.key,
    required this.filePaths,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onAdd,
          child: ValidateWidget(
            validator: (_) => null, // المستندات اختيارية
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 29.h, horizontal: 36.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xFFF5F5F5), width: 1),
              ),
              child: Column(
                children: [
                  Icon(Icons.arrow_downward_rounded, size: 24.r, color: const Color(0xFF32B599)),
                  SizedBox(height: 8.h),
                  Text(
                    'ارفق المستندات المطلوبة',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF32B599),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: List.generate(
            filePaths.length,
            (index) => Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: SvgPicture.asset(AppSvg.pdfSvg),
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: InkWell(
                    onTap: () => onRemove(index),
                    child: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: const Color(0xFFF5F5F5),
                      child: Icon(Icons.close, color: const Color(0xFFBDBDBD), size: 16.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// صورة الحساب القابلة للتغيير في الإعدادات.
class SettingAvatarPicker extends StatelessWidget {
  final String networkUrl;
  final String localPath;
  final VoidCallback onTap;

  const SettingAvatarPicker({
    super.key,
    required this.networkUrl,
    required this.localPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DecorationImage? image;
    if (localPath.isNotEmpty) {
      image = DecorationImage(image: FileImage(File(localPath)), fit: BoxFit.cover);
    } else if (networkUrl.isNotEmpty) {
      image = DecorationImage(image: NetworkImage(networkUrl), fit: BoxFit.cover);
    }
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 78.w,
          height: 77.h,
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 26),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(0, 0, 0, 0.2), Color.fromRGBO(0, 0, 0, 0.2)],
            ),
            image: image,
          ),
          child: SvgPicture.asset(AppSvg.cameraSvg, width: 24.w, height: 24.h, color: AppColors.white),
        ),
      ),
    );
  }
}

/// نافذة تغيير الصورة (كاميرا/معرض).
void showChangePhotoSheet(
  BuildContext context, {
  required VoidCallback onCamera,
  required VoidCallback onGallery,
}) {
  Widget option(String svg, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svg, width: 17.w, height: 17.h, color: color),
          SizedBox(width: 16.w),
          Text(
            label,
            style: GoogleFonts.tajawal(color: color, fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تغيير الصورة',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF212121),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(),
              option(AppSvg.cameraSvg, 'اخذ صورة', const Color(0xFF212121), () {
                Navigator.pop(dialogContext);
                onCamera();
              }),
              const Divider(),
              option(AppSvg.folderOpenSvg, 'اختر من الاستديو', const Color(0xFF212121), () {
                Navigator.pop(dialogContext);
                onGallery();
              }),
            ],
          ),
        ),
      );
    },
  );
}
