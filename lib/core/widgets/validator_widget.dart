import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ValidateWidget extends FormField {
  ValidateWidget({
    super.onSaved,
    super.validator,
    Widget? child,
    super.key,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState state) {
            return ZoomIn(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [child!],
                      );
                    },
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Builder(
                        builder: (BuildContext context) => Text(
          state.errorText!,
          style: GoogleFonts.tajawal(color: const Color.fromARGB(255, 170, 13, 1),fontSize: 12.sp),
        )
                      ),
                    )
                ],
              ),
            );
          },
        );
}
