import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/button_with_google_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/divider_or_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/google_type_popup.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_me_and_Forgot_password_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/sign_up_prompt_widget.dart';
import 'package:workspace/utils/validators.dart';

class SiginInView extends StatelessWidget {
  const SiginInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignInCubit>(),
      child: const _SignInBody(),
    );
  }
}

class _SignInBody extends StatefulWidget {
  const _SignInBody();

  @override
  State<_SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<_SignInBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignInCubit>().signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }

  void _onStateChanged(BuildContext context, SignInState state) {
    switch (state.status) {
      case SignInStatus.success:
        _nav.offAllToHome();
        break;
      case SignInStatus.failure:
        showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
        break;
      case SignInStatus.googleAwaitingType:
        showGoogleTypePopup(
          context,
          (type) => context.read<SignInCubit>().completeGoogleSignIn(type),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      scrollable: true,
      header: Column(
        children: [
          Center(child: Image.asset(AppImage.logoImage)),
          SizedBox(height: 56.h),
          SignUpPromptWidget(
            title: 'dont_Have_An_account'.tr,
            btuTitle: 'sign_up_now'.tr,
            onTap: _nav.toSignUp,
          ),
        ],
      ),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();
          final isLoading = state.status == SignInStatus.loading ||
              state.status == SignInStatus.googleLoading;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                      label: 'email'.tr,
                      hint: 'AreistoSpace@gmail.com',
                      iconAsset: AppSvg.smsSvg,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      controller: _emailController,
                      validator: Validators.email,
                    ),
                    AuthPasswordField(
                      label: 'password'.tr,
                      controller: _passwordController,
                      obscure: state.obscurePassword,
                      onToggle: cubit.togglePasswordVisibility,
                      autofillHints: const [AutofillHints.password],
                      validator: (value) =>
                          Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              RememberMeAndForgotPasswordWidget(
                isChecked: state.rememberMe,
                onChanged: (value) => cubit.toggleRememberMe(value ?? false),
                onForgotPassword: _nav.toResetPassword,
              ),
              SizedBox(height: 16.h),
              if (isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.primary))
              else
                ButtonLoginWidget(text: 'login'.tr, onTap: _submit),
              SizedBox(height: 16.h),
              const OrDividerWidget(),
              SizedBox(height: 16.h),
              ButtonWithGoogleWidget(onTap: cubit.startGoogleSignIn),
            ],
          );
        },
      ),
    );
  }
}
