import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_type_dropdown.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/button_with_google_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/divider_or_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/google_type_popup.dart';
import 'package:workspace/features/auth/presentation/widgets/sign_up_prompt_widget.dart';
import 'package:workspace/utils/validators.dart';

class SiginUpView extends StatelessWidget {
  const SiginUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: const _SignUpBody(),
    );
  }
}

class _SignUpBody extends StatefulWidget {
  const _SignUpBody();

  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _nextFieldFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _nextFieldFocus.dispose();
    super.dispose();
  }

  void _submit() {
    final cubit = context.read<RegisterCubit>();
    if (cubit.state.selectedType.isEmpty) {
      showCustomSnackBar(context, 'يرجى اختيار القسم', SnackBarType.warning);
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      cubit.register(
        name: _nameController.text,
        email: _emailController.text,
        mobile: _phoneController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmController.text,
      );
    }
  }

  void _onStateChanged(BuildContext context, RegisterState state) {
    switch (state.status) {
      case RegisterStatus.success:
        if (state.registeredEmail.isNotEmpty) {
          _nav.toOtp(email: state.registeredEmail, isNewAccount: true);
        } else {
          _nav.offAllToHome();
        }
        break;
      case RegisterStatus.failure:
        showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
        break;
      case RegisterStatus.googleAwaitingType:
        showGoogleTypePopup(
          context,
          (type) => context.read<RegisterCubit>().completeGoogleSignIn(type),
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
      topSpacing: 32,
      header: Column(
        children: [
          Center(child: Image.asset(AppImage.logoImage)),
          SizedBox(height: 24.h),
          SignUpPromptWidget(
            title: 'do_you_have_an_account'.tr,
            btuTitle: 'login'.tr,
            onTap: _nav.toSignIn,
          ),
        ],
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          final isLoading = state.status == RegisterStatus.loading ||
              state.status == RegisterStatus.googleLoading;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                      label: 'full_name'.tr,
                      hint: 'Areisto Space',
                      iconAsset: AppSvg.profileSvg,
                      autofillHints: const [AutofillHints.name],
                      controller: _nameController,
                      validator: (value) => Validators.required(value, fieldName: 'الاسم'),
                    ),
                    AuthTypeDropdown(
                      items: kUserTypes.keys.toList(),
                      validator: (value) => Validators.required(value),
                      onChanged: (value) {
                        FocusScope.of(context).requestFocus(_nextFieldFocus);
                        cubit.setType(kUserTypes[value]!);
                      },
                    ),
                    AuthTextField(
                      label: 'phone_number'.tr,
                      hint: '059 7146 852',
                      iconAsset: AppSvg.mdiPhoneOutlineSvg,
                      keyboardType: TextInputType.phone,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      focusNode: _nextFieldFocus,
                      controller: _phoneController,
                      validator: Validators.phone,
                    ),
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
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
                    ),
                    AuthPasswordField(
                      label: 'confirm_password'.tr,
                      controller: _confirmController,
                      obscure: state.obscureConfirmPassword,
                      onToggle: cubit.toggleConfirmPasswordVisibility,
                      validator: (value) => Validators.match(
                        value,
                        _passwordController.text,
                        fieldName: 'تأكيد كلمة المرور',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              if (isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.primary))
              else
                ButtonLoginWidget(text: 'register_new_user'.tr, onTap: _submit),
              SizedBox(height: 8.h),
              const OrDividerWidget(),
              SizedBox(height: 8.h),
              ButtonWithGoogleWidget(onTap: cubit.startGoogleSignIn),
            ],
          );
        },
      ),
    );
  }
}
