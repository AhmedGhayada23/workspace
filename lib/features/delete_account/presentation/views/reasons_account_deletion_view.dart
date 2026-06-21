import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';

const _reasons = [
  'تجربة مستخدم غير مرضية',
  'مشاكل في التطبيق',
  'قلة الميزات',
  'وجدت تطبيق أفضل',
  'أسباب أخرى',
];

class ReasonsAccountDeletionView extends StatefulWidget {
  const ReasonsAccountDeletionView({super.key});

  @override
  State<ReasonsAccountDeletionView> createState() => _ReasonsAccountDeletionViewState();
}

class _ReasonsAccountDeletionViewState extends State<ReasonsAccountDeletionView> {
  final _nav = sl<AppNavigator>();
  final Set<String> _selected = {};

  void _toggle(String reason) {
    setState(() {
      _selected.contains(reason) ? _selected.remove(reason) : _selected.add(reason);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: _nav.back, icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'سبب حذف الحساب',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'لماذا تريد حذف حسابك ؟',
              style: GoogleFonts.tajawal(
                color: const Color(0xFF212121),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24.h),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _reasons.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final reason = _reasons[index];
                final selected = _selected.contains(reason);
                return GestureDetector(
                  onTap: () => _toggle(reason),
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: const Color(0xFFF5F5F5), width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Text(
                          reason,
                          style: GoogleFonts.tajawal(
                            color: const Color(0xFF212121),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2.w,
                              color: selected ? const Color(0xFF32B599) : const Color(0xFFD6F0EB),
                            ),
                            color: selected ? const Color(0xFF32B599) : Colors.transparent,
                          ),
                          child: selected ? Icon(Icons.check, color: Colors.white, size: 16.r) : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            ButtonLoginWidget(
              text: 'حذف الحساب',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => EditConfirmationDialog(
                    title: 'هل انت متأكد ؟',
                    subTitle: 'هل انت متأكد من حذف الحساب ؟',
                    textConfirm: 'حذف الحساب',
                    textConfirmColor: const Color(0xFFF75555),
                    textCanselColor: const Color(0xFF000000),
                    onConfirm: _nav.offAllToSignIn,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
