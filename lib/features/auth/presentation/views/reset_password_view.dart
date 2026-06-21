import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_icon_badge.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_info_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_logo_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_password_login_btn_widgt.dart';
import 'package:workspace/utils/validators.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordCubit>(),
      child: const _ResetPasswordBody(),
    );
  }
}

class _ResetPasswordBody extends StatefulWidget {
  const _ResetPasswordBody();

  @override
  State<_ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<_ResetPasswordBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().sendCode(_emailController.text);
    }
  }

  void _onStateChanged(BuildContext context, ResetPasswordState state) {
    if (state.status == ResetPasswordStatus.success) {
      _nav.toOtp(email: _emailController.text, isNewAccount: false);
    } else if (state.status == ResetPasswordStatus.failure) {
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      header: AuthLogoHeader(onBack: _nav.toSignIn),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthIconBadge(svgAsset: AppSvg.vectorSvg),
          SizedBox(height: 24.sp),
          AuthInfoHeader(
            title: 'استعادة كلمة المرور'.tr,
            subtitle:
                'ادخل البريد الالكتروني الخاص بك وسنقوم بارسال رمز التحقق لاعادة تعيين كلمة المرور الخاصة بك'.tr,
          ),
          SizedBox(height: 32.sp),
          AuthTextField(
            label: 'email'.tr,
            hint: 'AreistoSpace@gmail.com',
            iconAsset: AppSvg.smsSvg,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.done,
            controller: _emailController,
            validator: Validators.email,
          ),
          SizedBox(height: 12.sp),
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: _onStateChanged,
            builder: (context, state) {
              if (state.status == ResetPasswordStatus.loading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }
              return ButtonLoginWidget(text: 'ارسل رمز التحقق'.tr, onTap: _submit);
            },
          ),
          const Spacer(),
          RememberPasswordAndLoginButtonWidgt(onLogin: _nav.toSignIn),
        ],
      ),
    );
  }
}
