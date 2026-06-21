import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/delete_account/presentation/cubit/delete_account_cubit.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';
import 'package:workspace/utils/validators.dart';

class DeleteAccountVerificationCodeView extends StatelessWidget {
  final String email;

  const DeleteAccountVerificationCodeView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DeleteAccountCubit>(),
      child: _DeleteAccountVerificationBody(email: email),
    );
  }
}

class _DeleteAccountVerificationBody extends StatefulWidget {
  final String email;

  const _DeleteAccountVerificationBody({required this.email});

  @override
  State<_DeleteAccountVerificationBody> createState() => _DeleteAccountVerificationBodyState();
}

class _DeleteAccountVerificationBodyState extends State<_DeleteAccountVerificationBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _confirmAndSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    showDialog(
      context: context,
      builder: (dialogContext) => EditConfirmationDialog(
        title: 'هل انت متأكد ؟',
        subTitle: 'هل انت متأكد من حذف الحساب ؟',
        textConfirm: 'حذف الحساب',
        textConfirmColor: const Color(0xFFF75555),
        textCanselColor: const Color(0xFF000000),
        onConfirm: () {
          context.read<DeleteAccountCubit>().verifyCode(
                email: widget.email,
                code: _codeController.text,
              );
        },
      ),
    );
  }

  void _onState(BuildContext context, DeleteAccountState state) {
    if (state.status == DeleteAccountStatus.deleted) {
      _nav.offAllToSignIn();
    } else if (state.status == DeleteAccountStatus.failure) {
      showCustomSnackBar(context, state.message, SnackBarType.error);
      context.read<DeleteAccountCubit>().resetStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: _nav.back, icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'حذف الحساب',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ادخل رمز التحقق',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF32B599),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'المرسل على الايميل ${widget.email}',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'رمز التحقق',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF212121),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              TextFieldWidgets(
                hint: '5555',
                textInputAction: TextInputAction.done,
                controller: _codeController,
                validator: (value) => Validators.minLength(value, 4, fieldName: 'رمز التحقق'),
              ),
              SizedBox(height: 32.h),
              BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                listenWhen: (p, c) => p.status != c.status,
                listener: _onState,
                builder: (context, state) {
                  if (state.status == DeleteAccountStatus.loading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }
                  return ButtonLoginWidget(text: 'حذف الحساب', onTap: _confirmAndSubmit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
