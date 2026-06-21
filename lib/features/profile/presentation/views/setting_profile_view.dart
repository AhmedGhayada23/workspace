import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_type_dropdown.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/setting_profile/setting_profile_cubit.dart';
import 'package:workspace/features/profile/presentation/widgets/profile_form_widgets.dart';
import 'package:workspace/utils/validators.dart';

const _settingUserTypes = {
  'طالب': 'student',
  'موظف': 'employee',
  'مستقل': 'independent',
};

/// التسمية العربية المقابلة لقيمة النوع القادمة من الخادم (أو null إن لم تطابق).
String? _labelForType(String serverType) {
  for (final e in _settingUserTypes.entries) {
    if (e.value == serverType) return e.key;
  }
  return null;
}

class SettingProfileView extends StatelessWidget {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingProfileCubit>()..load(),
      child: const _SettingProfileBody(),
    );
  }
}

class _SettingProfileBody extends StatefulWidget {
  const _SettingProfileBody();

  @override
  State<_SettingProfileBody> createState() => _SettingProfileBodyState();
}

class _SettingProfileBodyState extends State<_SettingProfileBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nextFocus = FocusNode();
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nextFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SettingProfileCubit>().submit(
            name: _nameController.text,
            email: _emailController.text,
            mobile: _phoneController.text,
          );
    }
  }

  void _onState(BuildContext context, SettingProfileState state) {
    // تعبئة الحقول مرة واحدة عند جاهزية البيانات.
    if (state.formStatus == SettingFormStatus.ready && !_initialized) {
      _initialized = true;
      _nameController.text = state.name;
      _phoneController.text = state.mobile;
      _emailController.text = state.email;
    }
    if (state.submitStatus == SubmitStatus.success) {
      showCustomSnackBar(context, state.message, SnackBarType.success);
      sl<ProfileCubit>().load(); // تحديث بيانات الحساب بعد الحفظ
      context.read<SettingProfileCubit>().clearSubmit();
    } else if (state.submitStatus == SubmitStatus.failure) {
      showCustomSnackBar(context, state.message, SnackBarType.error);
      context.read<SettingProfileCubit>().clearSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: _nav.back, icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'حسابي',
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF212121),
          ),
        ),
      ),
      body: BlocConsumer<SettingProfileCubit, SettingProfileState>(
        listener: _onState,
        builder: (context, state) {
          if (state.formStatus != SettingFormStatus.ready) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          final cubit = context.read<SettingProfileCubit>();
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingAvatarPicker(
                      networkUrl: state.networkImageUrl,
                      localPath: state.imagePath,
                      onTap: () => showChangePhotoSheet(
                        context,
                        onCamera: cubit.pickFromCamera,
                        onGallery: cubit.pickFromGallery,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    AutofillGroup(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الاسم كامل', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          TextFieldWidgets(
                            controller: _nameController,
                            hint: '',
                            autofillHints: const [AutofillHints.name],
                            validator: (value) =>
                                Validators.required(value, fieldName: 'الاسم'),
                          ),
                          SizedBox(height: 16.h),
                          AuthTypeDropdown(
                            items: _settingUserTypes.keys.toList(),
                            initialItem: _labelForType(state.type),
                            validator: (value) => Validators.required(value),
                            onChanged: (value) {
                              FocusScope.of(context).requestFocus(_nextFocus);
                              cubit.setType(_settingUserTypes[value]!);
                            },
                          ),
                          SizedBox(height: 16.h),
                          Text('رقم الهاتف', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          TextFieldWidgets(
                            controller: _phoneController,
                            hint: '',
                            focusNode: _nextFocus,
                            keyboardType: TextInputType.phone,
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            validator: Validators.phone,
                          ),
                          SizedBox(height: 16.h),
                          Text('البريد الالكتروني', style: AppTextStyles.body),
                          SizedBox(height: 8.h),
                          TextFieldWidgets(
                            controller: _emailController,
                            hint: '',
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: Validators.email,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),
                    ProfileSaveButton(
                      label: 'حفظ التعديلات',
                      loading: state.submitStatus == SubmitStatus.loading,
                      onTap: _submit,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
