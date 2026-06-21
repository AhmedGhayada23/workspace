import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/theme/text_styles.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.8.r,
            color: const Color(0xFFEEEEEE),
            endIndent: 10.r,
          ),
        ),
        Text(
          'or'.tr,
          style: AppTextStyles.body,
        ),
        Expanded(
          child: Divider(
            thickness: 0.8.r,
            color: const Color(0xFFEEEEEE),
            indent: 10.r,
          ),
        ),
      ],
    );
  }
}
