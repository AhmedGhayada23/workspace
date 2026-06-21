import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// بطاقة حالة الشبكة (مطابقة للتصميم): أيقونة واي-فاي مرسومة + رسالة + زر إعادة المحاولة.
class ConnectionStatusCard extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isRetrying;

  const ConnectionStatusCard({super.key, required this.onRetry, this.isRetrying = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 110.r, height: 90.r, child: const _NoInternetIcon()),
          SizedBox(height: 20.h),
          Text(
            'لا يوجد اتصال بالإنترنت',
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF1B132A),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'تحقق من اتصالك بالشبكة وحاول مجدداً.',
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF9E9E9E),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: isRetrying ? null : onRetry,
              borderRadius: BorderRadius.circular(50.r),
              child: Container(
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: isRetrying
                    ? SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                    : Text(
                        'إعادة المحاولة',
                        style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// أيقونة "لا يوجد اتصال": أقواس واي-فاي متقطّعة + صاعقة + وجه حزين.
class _NoInternetIcon extends StatelessWidget {
  const _NoInternetIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: CustomPaint(painter: _WifiArcsPainter())),
        // الوجه الحزين في منتصف أسفل الأقواس
        Align(
          alignment: const Alignment(0, 0.95),
          child: Container(
            width: 34.r,
            height: 34.r,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
            child: Icon(Icons.sentiment_dissatisfied_rounded, color: Colors.white, size: 24.r),
          ),
        ),
      ],
    );
  }
}

class _WifiArcsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.92);
    final arcPaint = Paint()
      ..color = const Color(0xFFD6D6E0)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.075;

    const startAngle = math.pi * 1.18; // أعلى اليسار
    const sweepAngle = math.pi * 0.64; // نحو أعلى اليمين
    for (final r in [size.width * 0.46, size.width * 0.30]) {
      final rect = Rect.fromCircle(center: center, radius: r);
      final arc = Path()..addArc(rect, startAngle, sweepAngle);
      canvas.drawPath(_dash(arc, dash: size.width * 0.07, gap: size.width * 0.06), arcPaint);
    }

    // الصاعقة (تنبيه) باللون الكهرماني
    final bolt = Paint()..color = const Color(0xFFF5A623);
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.54, h * 0.18)
      ..lineTo(w * 0.42, h * 0.5)
      ..lineTo(w * 0.5, h * 0.5)
      ..lineTo(w * 0.46, h * 0.74)
      ..lineTo(w * 0.6, h * 0.42)
      ..lineTo(w * 0.52, h * 0.42)
      ..close();
    canvas.drawPath(path, bolt);
  }

  /// يحوّل مساراً إلى مسار متقطّع (شُرَط).
  Path _dash(Path source, {required double dash, required double gap}) {
    final result = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dash;
        result.addPath(metric.extractPath(distance, next.clamp(0, metric.length)), Offset.zero);
        distance = next + gap;
      }
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
