import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/cubit/new_password/new_password_cubit.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_icon_badge.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_info_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_logo_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_password_login_btn_widgt.dart';
import 'package:workspace/utils/validators.dart';

class NewPasswordView extends StatelessWidget {
  final String email;

  const NewPasswordView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewPasswordCubit>(),
      child: _NewPasswordBody(email: email),
    );
  }
}

class _NewPasswordBody extends StatefulWidget {
  final String email;

  const _NewPasswordBody({required this.email});

  @override
  State<_NewPasswordBody> createState() => _NewPasswordBodyState();
}

class _NewPasswordBodyState extends State<_NewPasswordBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<NewPasswordCubit>().submit(
            email: widget.email,
            newPassword: _passwordController.text,
            confirmNewPassword: _confirmController.text,
          );
    }
  }

  void _onStateChanged(BuildContext context, NewPasswordState state) {
    if (state.status == NewPasswordStatus.success) {
      _nav.offAllToCongratulations();
    } else if (state.status == NewPasswordStatus.failure) {
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      header: AuthLogoHeader(onBack: _nav.back),
      child: BlocConsumer<NewPasswordCubit, NewPasswordState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final cubit = context.read<NewPasswordCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthIconBadge(svgAsset: AppSvg.newPasswordSvg),
              SizedBox(height: 24.sp),
              AuthInfoHeader(
                title: 'ادخل كلمة المرور الجديدة'.tr,
                subtitle: 'قم بادخال كلمة المرور الجديدة ويجب ان تكون من 8 خانات'.tr,
              ),
              SizedBox(height: 32.sp),
              AuthPasswordField(
                label: 'كلمة مرور جديدة',
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
              SizedBox(height: 12.sp),
              if (state.status == NewPasswordStatus.loading)
                const Center(child: CircularProgressIndicator(color: AppColors.primary))
              else
                ButtonLoginWidget(text: 'تغيير كلمة المرور'.tr, onTap: _submit),
              const Spacer(),
              RememberPasswordAndLoginButtonWidgt(onLogin: _nav.toSignIn),
            ],
          );
        },
      ),
    );
  }
}
