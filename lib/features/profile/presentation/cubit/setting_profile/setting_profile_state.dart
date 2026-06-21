part of 'setting_profile_cubit.dart';

enum SettingFormStatus { initial, loading, ready, error }

enum SubmitStatus { idle, loading, success, failure }

class SettingProfileState extends Equatable {
  final SettingFormStatus formStatus;
  final SubmitStatus submitStatus;
  final String name;
  final String email;
  final String mobile;
  final String type;
  final String networkImageUrl;
  final String imagePath;

  /// طلب المستخدم حذف الصورة الحالية (يُرسَل image='' للسيرفر).
  final bool imageDeleted;
  final String message;

  const SettingProfileState({
    this.formStatus = SettingFormStatus.initial,
    this.submitStatus = SubmitStatus.idle,
    this.name = '',
    this.email = '',
    this.mobile = '',
    this.type = '',
    this.networkImageUrl = '',
    this.imagePath = '',
    this.imageDeleted = false,
    this.message = '',
  });

  SettingProfileState copyWith({
    SettingFormStatus? formStatus,
    SubmitStatus? submitStatus,
    String? name,
    String? email,
    String? mobile,
    String? type,
    String? networkImageUrl,
    String? imagePath,
    bool clearImage = false,
    bool? imageDeleted,
    String? message,
  }) {
    return SettingProfileState(
      formStatus: formStatus ?? this.formStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      type: type ?? this.type,
      networkImageUrl: networkImageUrl ?? this.networkImageUrl,
      imagePath: clearImage ? '' : (imagePath ?? this.imagePath),
      imageDeleted: imageDeleted ?? this.imageDeleted,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        submitStatus,
        name,
        email,
        mobile,
        type,
        networkImageUrl,
        imagePath,
        imageDeleted,
        message,
      ];
}
