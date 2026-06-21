import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/features/auth/presentation/cubit/otp/otp_cubit.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_icon_badge.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_info_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_logo_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_password_login_btn_widgt.dart';

class OTPView extends StatelessWidget {
  final String email;
  final bool isNewAccount;

  const OTPView({super.key, required this.email, required this.isNewAccount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OtpCubit>()..init(email: email, isNewAccount: isNewAccount),
      child: const _OtpBody(),
    );
  }
}

class _OtpBody extends StatefulWidget {
  const _OtpBody();

  @override
  State<_OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<_OtpBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<OtpCubit>().verify(_pinController.text);
    }
  }

  void _onStateChanged(BuildContext context, OtpState state) {
    if (state.status == OtpStatus.success) {
      if (state.isNewAccount) {
        _nav.offAllToHome();
      } else {
        _nav.toNewPassword(email: state.email);
      }
    } else if (state.status == OtpStatus.failure) {
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      header: AuthLogoHeader(onBack: _nav.back),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthIconBadge(svgAsset: AppSvg.sentCodeSvg, height: 55),
          SizedBox(height: 24.sp),
          AuthInfoHeader(title: 'sent_code'.tr, subtitle: 'code_sent_email'.tr),
          SizedBox(height: 32.sp),
          Text('verification_code'.tr, style: AppTextStyles.body),
          SizedBox(height: 12.h),
          _PinField(controller: _pinController, onCompleted: (pin) => context.read<OtpCubit>().verify(pin)),
          SizedBox(height: 24.h),
          _ResendOrCountdown(onResend: () => context.read<OtpCubit>().resend()),
          SizedBox(height: 24.sp),
          BlocConsumer<OtpCubit, OtpState>(
            // المستمع يُنفّذ فقط عند تغيّر الحالة (لا مع كل تكّة للعدّاد) لتفادي
            // تكرار التنقّل إلى الشاشة التالية.
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: _onStateChanged,
            builder: (context, state) {
              if (state.status == OtpStatus.loading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }
              return ButtonLoginWidget(text: 'check'.tr, onTap: _submit);
            },
          ),
          const Spacer(),
          RememberPasswordAndLoginButtonWidgt(onLogin: _nav.toSignIn),
        ],
      ),
    );
  }
}

class _PinField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onCompleted;

  const _PinField({required this.controller, required this.onCompleted});

  PinTheme _theme(Color borderColor) => PinTheme(
        width: 78.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: borderColor),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        length: 5,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        separatorBuilder: (index) => SizedBox(width: 8.w),
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        errorTextStyle: GoogleFonts.tajawal(color: const Color.fromARGB(255, 189, 0, 0)),
        onCompleted: onCompleted,
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'الرمز مطلوب';
          if (value.length != 5) return 'الرمز يجب أن يكون 5 أرقام';
          return null;
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 9.h),
              width: 22.w,
              height: 1.h,
              color: AppColors.primary,
            ),
          ],
        ),
        defaultPinTheme: _theme(const Color(0xFFECF1F6)),
        disabledPinTheme: _theme(const Color(0xFFECF1F6)),
        focusedPinTheme: _theme(AppColors.primary),
        submittedPinTheme: _theme(AppColors.primary),
      ),
    );
  }
}

class _ResendOrCountdown extends StatelessWidget {
  final VoidCallback onResend;

  const _ResendOrCountdown({required this.onResend});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (p, c) =>
          p.canResend != c.canResend || p.secondsRemaining != c.secondsRemaining,
      builder: (context, state) {
        if (state.canResend) {
          return InkWell(
            onTap: onResend,
            child: Center(
              child: Text(
                'resend_code'.tr,
                style: GoogleFonts.tajawal(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text(
            state.formattedTime,
            style: GoogleFonts.tajawal(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
