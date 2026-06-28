import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';
import 'package:workspace/features/profile/domain/usecases/profile_usecases.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase editProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  EditProfileCubit({required this.editProfileUseCase, required this.getProfileUseCase})
      : super(const EditProfileState());

  /// يجلب بيانات الملف الشخصي ويهيّئ النموذج منها.
  Future<void> load() async {
    emit(state.copyWith(formStatus: EditFormStatus.loading));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(formStatus: EditFormStatus.error, message: failure.message)),
      (profile) {
        final customer = profile.data?.user?.customer;
        emit(state.copyWith(
          formStatus: EditFormStatus.ready,
          customer: customer,
          birthday: customer?.dob ?? '',
          userType: customer?.type ?? '',
          selectSex: customer?.gender == 'male' ? 1 : 0,
          filePaths: customer?.documentsUrl?.cast<String>() ?? const [],
        ));
      },
    );
  }

  void setSex(int value) => emit(state.copyWith(selectSex: value));
  void setBirthday(String value) => emit(state.copyWith(birthday: value));
  void removeFile(int index) {
    final list = List<String>.from(state.filePaths)..removeAt(index);
    emit(state.copyWith(filePaths: list));
  }

  /// الحد الأقصى لحجم المستند (1 ميجابايت).
  static const int _maxFileBytes = 1024 * 1024;

  Future<void> addPdf() async {
    // FileType.any يفتح مُنتقي المستندات/الملفات (لا معرض الصور) على أندرويد،
    // ثم نتحقّق يدوياً أن الملف PDF فقط.
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    final isPdf = (file.extension ?? '').toLowerCase() == 'pdf' ||
        (file.path ?? '').toLowerCase().endsWith('.pdf');
    if (!isPdf) {
      _showError('يُسمح بملفات PDF فقط');
      return;
    }
    if (file.size > _maxFileBytes) {
      _showError('حجم الملف يجب ألا يزيد عن 1 ميجابايت');
      return;
    }
    if (file.path != null) {
      emit(state.copyWith(filePaths: [...state.filePaths, file.path!]));
    }
  }

  void _showError(String message) {
    emit(state.copyWith(submitStatus: SubmitStatus.failure, message: message));
    emit(state.copyWith(submitStatus: SubmitStatus.idle));
  }

  Future<void> submit({
    required String aboutMe,
    required String age,
    required String university,
    required String specialty,
    required String universityNumber,
    required String address,
  }) async {
    // المستندات اختيارية — لا تحقّق إلزامي هنا.
    emit(state.copyWith(submitStatus: SubmitStatus.loading));
    final result = await editProfileUseCase(EditProfileParams(
      aboutMe: aboutMe,
      gender: state.selectSex == 0 ? 'female' : 'male',
      age: age,
      dob: state.birthday,
      universityNumber: universityNumber,
      specialty: specialty,
      university: university,
      address: address,
      documentPaths: state.filePaths,
    ));
    result.fold(
      (failure) => emit(state.copyWith(submitStatus: SubmitStatus.failure, message: failure.message)),
      (_) => emit(state.copyWith(submitStatus: SubmitStatus.success, message: 'تم حفظ التعديلات بنجاح')),
    );
  }

  void clearSubmit() => emit(state.copyWith(submitStatus: SubmitStatus.idle));
}
