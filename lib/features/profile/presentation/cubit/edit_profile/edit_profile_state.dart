part of 'edit_profile_cubit.dart';

enum EditFormStatus { initial, loading, ready, error }

enum SubmitStatus { idle, loading, success, failure }

class EditProfileState extends Equatable {
  final EditFormStatus formStatus;
  final SubmitStatus submitStatus;
  final Customer? customer;
  final int selectSex;
  final String birthday;
  final String userType;
  final List<String> filePaths;
  final String message;

  const EditProfileState({
    this.formStatus = EditFormStatus.initial,
    this.submitStatus = SubmitStatus.idle,
    this.customer,
    this.selectSex = 0,
    this.birthday = '',
    this.userType = '',
    this.filePaths = const [],
    this.message = '',
  });

  EditProfileState copyWith({
    EditFormStatus? formStatus,
    SubmitStatus? submitStatus,
    Customer? customer,
    int? selectSex,
    String? birthday,
    String? userType,
    List<String>? filePaths,
    String? message,
  }) {
    return EditProfileState(
      formStatus: formStatus ?? this.formStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      customer: customer ?? this.customer,
      selectSex: selectSex ?? this.selectSex,
      birthday: birthday ?? this.birthday,
      userType: userType ?? this.userType,
      filePaths: filePaths ?? this.filePaths,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [formStatus, submitStatus, customer, selectSex, birthday, userType, filePaths, message];
}
