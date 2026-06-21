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
import 'package:workspace/utils/validators.dart';

class DeleteAccountSentOtpView extends StatelessWidget {
  const DeleteAccountSentOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DeleteAccountCubit>(),
      child: const _DeleteAccountSentOtpBody(),
    );
  }
}

class _DeleteAccountSentOtpBody extends StatefulWidget {
  const _DeleteAccountSentOtpBody();

  @override
  State<_DeleteAccountSentOtpBody> createState() => _DeleteAccountSentOtpBodyState();
}

class _DeleteAccountSentOtpBodyState extends State<_DeleteAccountSentOtpBody> {
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
      context.read<DeleteAccountCubit>().sendCode(_emailController.text);
    }
  }

  void _onState(BuildContext context, DeleteAccountState state) {
    if (state.status == DeleteAccountStatus.codeSent) {
      context.read<DeleteAccountCubit>().resetStatus();
      _nav.toDeleteAccountVerification(_emailController.text.trim());
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
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'لحذف الحساب ادخل بريدك الالكتروني المربوط فالحساب',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF32B599),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'البريد الالكتروني',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF212121),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              TextFieldWidgets(
                hint: 'areistospace@gmail.com',
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                controller: _emailController,
                validator: Validators.email,
              ),
              SizedBox(height: 32.h),
              BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                listenWhen: (p, c) => p.status != c.status,
                listener: _onState,
                builder: (context, state) {
                  if (state.status == DeleteAccountStatus.loading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }
                  return ButtonLoginWidget(text: 'تحقق', onTap: _submit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
