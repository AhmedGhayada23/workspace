import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/profile/domain/usecases/profile_usecases.dart';

part 'setting_profile_state.dart';

class SettingProfileCubit extends Cubit<SettingProfileState> {
  final EditSettingsUseCase editSettingsUseCase;
  final GetProfileUseCase getProfileUseCase;
  final ImagePicker _picker = ImagePicker();

  SettingProfileCubit({required this.editSettingsUseCase, required this.getProfileUseCase})
      : super(const SettingProfileState());

  /// يجلب بيانات الحساب ويهيّئ النموذج منها.
  Future<void> load() async {
    emit(state.copyWith(formStatus: SettingFormStatus.loading));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(formStatus: SettingFormStatus.error, message: failure.message)),
      (profile) {
        final user = profile.data?.user;
        emit(state.copyWith(
          formStatus: SettingFormStatus.ready,
          name: user?.name ?? '',
          email: user?.email ?? '',
          mobile: user?.mobile ?? '',
          type: user?.customer?.type ?? '',
          networkImageUrl: user?.customer?.imageUrl ?? '',
        ));
      },
    );
  }

  void setType(String serverType) => emit(state.copyWith(type: serverType));

  /// الحد الأقصى لحجم صورة الحساب (1 ميجابايت).
  static const int _maxImageBytes = 1024 * 1024;

  Future<void> pickFromCamera() async {
    await _setImage(await _picker.pickImage(source: ImageSource.camera));
  }

  Future<void> pickFromGallery() async {
    await _setImage(await _picker.pickImage(source: ImageSource.gallery));
  }

  /// يضبط الصورة المختارة بعد التحقّق من ألا يتجاوز حجمها 1 ميجابايت.
  Future<void> _setImage(XFile? picked) async {
    if (picked == null) return;
    final bytes = await picked.length();
    if (bytes > _maxImageBytes) {
      emit(state.copyWith(
        submitStatus: SubmitStatus.failure,
        message: 'حجم الصورة يجب ألا يزيد عن 1 ميجابايت',
      ));
      emit(state.copyWith(submitStatus: SubmitStatus.idle));
      return;
    }
    emit(state.copyWith(imagePath: picked.path, imageDeleted: false));
  }

  /// حذف الصورة: نمسح المحلية والشبكية (للعرض) ونعلّم بالحذف ليُرسَل image='' عند الحفظ.
  void deleteImage() =>
      emit(state.copyWith(clearImage: true, imageDeleted: true, networkImageUrl: ''));

  Future<void> submit({
    required String name,
    required String email,
    required String mobile,
  }) async {
    emit(state.copyWith(submitStatus: SubmitStatus.loading));
    final result = await editSettingsUseCase(EditSettingsParams(
      name: name,
      type: state.type,
      email: email,
      mobile: mobile,
      imagePath: state.imagePath.isEmpty ? null : state.imagePath,
      deleteImage: state.imageDeleted && state.imagePath.isEmpty,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(submitStatus: SubmitStatus.failure, message: failure.message)),
      (_) => emit(state.copyWith(
        submitStatus: SubmitStatus.success,
        message: 'تم حفظ التعديلات بنجاح',
      )),
    );
  }

  void clearSubmit() => emit(state.copyWith(submitStatus: SubmitStatus.idle));
}
