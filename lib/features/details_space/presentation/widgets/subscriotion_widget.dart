import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart'; // Import animate_do

class SubscriotionWidget extends StatelessWidget {
 final List<dynamic> subscriptions;
  const SubscriotionWidget({super.key,
  required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: subscriptions.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عدد الأعمدة
        crossAxisSpacing: 24.r, // المسافة بين الأعمدة
        mainAxisSpacing: 24.r, // المسافة بين الصفوف
      ),
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        return FadeIn(
          // Using FadeIn animation from animate_do
          duration: Duration(milliseconds: 500 + (index * 100)), // Staggered fade-in
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Container(
                height: 177.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  gradient: const LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [Color(0xFF32B599), Color(0xFF171725)],
                    stops: [0.332, 2.2071], // بناءً على النسب المذكورة في CSS
                    transform: GradientRotation(
                      253 * 3.1415927 / 180,
                    ), // تحويل الزاوية من درجة إلى راديان
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppSvg.subscriptionsSvg),
                      SizedBox(height: 8.h),
                      Text(
                        'اشتراك ${subscription.typeTitle}', // ضع النص الذي تريده
                        style: GoogleFonts.tajawal(
                          color: Color(0xFFFDFDFD), // اللون الأبيض
                          fontSize: 16.sp, // حجم الخط
                          fontWeight: FontWeight.w500, // الوزن المتوسط
                          fontStyle: FontStyle.normal, // النمط العادي
                          height: 1.0.h, // line-height طبيعي
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${removeTrailingZeros(subscription.price)} شيكل',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          color: Color(0xFFFDFDFD),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          height: 1.0.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(bottom: 1, left: 1, child: SvgPicture.asset(AppSvg.ellipseSvg)),
            ],
          ),
        );
      },
    );
  }
   // دالة لحذف الأصفار الزائدة بعد الفاصلة العشرية
  String removeTrailingZeros(dynamic value) {
    double number = value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
  }
}
