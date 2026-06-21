import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:workspace/features/profile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:workspace/utils/validators.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordCubit>(),
      child: const _ChangePasswordBody(),
    );
  }
}

class _ChangePasswordBody extends StatefulWidget {
  const _ChangePasswordBody();

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordCubit>().submit(
            oldPassword: _oldController.text,
            newPassword: _newController.text,
            confirmPassword: _confirmController.text,
          );
    }
  }

  void _onState(BuildContext context, ChangePasswordState state) {
    if (state.status == ChangePasswordStatus.success) {
      _oldController.clear();
      _newController.clear();
      _confirmController.clear();
      showCustomSnackBar(context, state.message, SnackBarType.success);
      context.read<ChangePasswordCubit>().clearStatus();
    } else if (state.status == ChangePasswordStatus.failure) {
      showCustomSnackBar(context, state.message, SnackBarType.error);
      context.read<ChangePasswordCubit>().clearStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: sl<AppNavigator>().back,
          icon: Icon(Icons.arrow_back, size: 24.r),
        ),
        centerTitle: true,
        title: Text(
          'كلمة المرور',
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF212121),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: _onState,
            builder: (context, state) {
              final cubit = context.read<ChangePasswordCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthPasswordField(
                    label: 'كلمة المرور الحالية',
                    controller: _oldController,
                    obscure: state.obscureOld,
                    onToggle: cubit.toggleOld,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
                  ),
                  AuthPasswordField(
                    label: 'كلمة المرور الجديدة',
                    controller: _newController,
                    obscure: state.obscureNew,
                    onToggle: cubit.toggleNew,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
                  ),
                  AuthPasswordField(
                    label: 'تاكيد كلمة المرور',
                    controller: _confirmController,
                    obscure: state.obscureConfirm,
                    onToggle: cubit.toggleConfirm,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) => Validators.match(
                      value,
                      _newController.text,
                      fieldName: 'تأكيد كلمة المرور',
                    ),
                  ),
                  SizedBox(height: 22.h),
                  if (state.status == ChangePasswordStatus.loading)
                    const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  else
                    Center(
                      child: InkWell(
                        onTap: _submit,
                        child: Container(
                          height: 44.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF32B599),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Center(
                            child: Text(
                              'تغيير كلمة المرور',
                              style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
