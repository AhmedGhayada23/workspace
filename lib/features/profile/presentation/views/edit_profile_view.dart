import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/calendar_picker_popup.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/profile/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/profile/presentation/widgets/profile_form_widgets.dart';
import 'package:workspace/utils/validators.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EditProfileCubit>()..load(),
      child: const _EditProfileBody(),
    );
  }
}

class _EditProfileBody extends StatefulWidget {
  const _EditProfileBody();

  @override
  State<_EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<_EditProfileBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _aboutMe = TextEditingController();
  final _age = TextEditingController();
  final _address = TextEditingController();
  final _university = TextEditingController();
  final _major = TextEditingController();
  final _universityId = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _aboutMe.dispose();
    _age.dispose();
    _address.dispose();
    _university.dispose();
    _major.dispose();
    _universityId.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditProfileCubit>().submit(
            aboutMe: _aboutMe.text,
            age: _age.text,
            address: _address.text,
            university: _university.text,
            specialty: _major.text,
            universityNumber: _universityId.text,
          );
    }
  }

  void _onState(BuildContext context, EditProfileState state) {
    if (state.formStatus == EditFormStatus.ready && !_initialized) {
      _initialized = true;
      final c = state.customer;
      _aboutMe.text = c?.aboutMe ?? '';
      _age.text = c?.age?.toString() ?? '';
      _address.text = c?.address?.toString() ?? '';
      _university.text = c?.university ?? '';
      _major.text = c?.specialty ?? '';
      _universityId.text = c?.universityNumber ?? '';
    }
    if (state.submitStatus == SubmitStatus.success) {
      showCustomSnackBar(context, state.message, SnackBarType.success);
      sl<ProfileCubit>().load(); // تحديث بيانات الحساب بعد التعديل
      _nav.back();
    } else if (state.submitStatus == SubmitStatus.failure) {
      showCustomSnackBar(context, state.message, SnackBarType.error);
      context.read<EditProfileCubit>().clearSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(onPressed: _nav.back, icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'الملف الشخصي',
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF212121),
          ),
        ),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: _onState,
        builder: (context, state) {
          if (state.formStatus != EditFormStatus.ready) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          final cubit = context.read<EditProfileCubit>();
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileSectionTitle('لمحة عني'),
                    const SizedBox(height: 12),
                    TextFieldWidgets(
                      hint: '',
                      maxLines: 5,
                      radius: 8.r,
                      controller: _aboutMe,
                      validator: Validators.required,
                    ),
                    const SizedBox(height: 24),
                    const ProfileSectionTitle('معلومات شخصية'),
                    const SizedBox(height: 12),
                    const ProfileFieldLabel('الجنس'),
                    SizedBox(height: 16.h),
                    GenderSelector(selected: state.selectSex, onChanged: cubit.setSex),
                    SizedBox(height: 16.h),
                    const ProfileFieldLabel('تاريخ الميلاد'),
                    SizedBox(height: 16.h),
                    _birthdayField(context, state, cubit),
                    SizedBox(height: 16.h),
                    const ProfileFieldLabel('العمر'),
                    SizedBox(height: 16.h),
                    // العمر يُحسب تلقائياً من تاريخ الميلاد (للقراءة فقط) لتفادي التعارض.
                    TextFieldWidgets(
                      hint: 'يُحسب من تاريخ الميلاد',
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: _age,
                      validator: (_) =>
                          _age.text.trim().isEmpty ? 'يرجى اختيار تاريخ الميلاد' : null,
                    ),
                    SizedBox(height: 16.h),
                    const ProfileFieldLabel('العنوان'),
                    SizedBox(height: 16.h),
                    TextFieldWidgets(
                      hint: '',
                      controller: _address,
                      validator: (value) => Validators.required(value, fieldName: 'العنوان'),
                    ),
                    if (state.userType == 'student') _educationSection(),
                    const SizedBox(height: 24),
                    const ProfileSectionTitle('المستندات المطلوبة '),
                    SizedBox(height: 16.h),
                    EditDocumentsField(
                      filePaths: state.filePaths,
                      onAdd: cubit.addPdf,
                      onRemove: cubit.removeFile,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state.formStatus != EditFormStatus.ready) return const SizedBox.shrink();
          return Container(
            height: 83.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFF9FAFB), width: 1.w),
              boxShadow: const [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), offset: Offset(0, -2), blurRadius: 4),
              ],
            ),
            alignment: Alignment.center,
            child: ProfileSaveButton(
              label: 'حفظ التعديلات',
              loading: state.submitStatus == SubmitStatus.loading,
              onTap: _submit,
            ),
          );
        },
      ),
    );
  }

  /// يحسب العمر بالسنوات من تاريخ الميلاد.
  int _ageFromDate(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) age--;
    return age < 0 ? 0 : age;
  }

  Widget _birthdayField(BuildContext context, EditProfileState state, EditProfileCubit cubit) {
    return TextFieldWidgets(
      hint: state.birthday.split(' ').first,
      readOnly: true,
      validator: (_) => state.birthday.isEmpty ? 'يرجى اختيار تاريخ الميلاد' : null,
      suffixIcon: IconButton(
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => CalendarPickerPopup(
            enableYearPicker: true,
            initialSelectedDate: DateTime.now(),
            onDateSelected: (date) {
              _age.text = _ageFromDate(date).toString();
              cubit.setBirthday(date.toString());
            },
          ),
        ),
        icon: SvgPicture.asset(AppSvg.calendarSvg, width: 24.w, height: 24.h),
      ),
    );
  }

  Widget _educationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        const ProfileSectionTitle('التعليم'),
        SizedBox(height: 12.h),
        const ProfileFieldLabel('الجامعة'),
        SizedBox(height: 16.h),
        TextFieldWidgets(hint: '', controller: _university, validator: Validators.required),
        SizedBox(height: 16.h),
        const ProfileFieldLabel('التخصص'),
        SizedBox(height: 16.h),
        TextFieldWidgets(hint: '', controller: _major, validator: Validators.required),
        SizedBox(height: 16.h),
        const ProfileFieldLabel('الرقم الجامعي'),
        SizedBox(height: 16.h),
        TextFieldWidgets(
          hint: '',
          keyboardType: TextInputType.number,
          controller: _universityId,
          validator: Validators.required,
        ),
      ],
    );
  }
}
