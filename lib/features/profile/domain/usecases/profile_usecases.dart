import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';
import 'package:workspace/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase implements UseCase<ProfileDataModel, NoParams> {
  final ProfileRepository repository;
  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileDataModel>> call(NoParams params) => repository.getProfile();
}

class LogoutUseCase implements UseCase<Unit, NoParams> {
  final ProfileRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.logout();
}

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final ProfileRepository repository;
  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) {
    return repository.changePassword(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword, confirmPassword];
}

class EditSettingsUseCase implements UseCase<Unit, EditSettingsParams> {
  final ProfileRepository repository;
  EditSettingsUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EditSettingsParams p) {
    return repository.editSettings(
      name: p.name,
      type: p.type,
      email: p.email,
      mobile: p.mobile,
      imagePath: p.imagePath,
      deleteImage: p.deleteImage,
    );
  }
}

class EditSettingsParams extends Equatable {
  final String name;
  final String type;
  final String email;
  final String mobile;
  final String? imagePath;
  final bool deleteImage;

  const EditSettingsParams({
    required this.name,
    required this.type,
    required this.email,
    required this.mobile,
    this.imagePath,
    this.deleteImage = false,
  });

  @override
  List<Object?> get props => [name, type, email, mobile, imagePath, deleteImage];
}

class EditProfileUseCase implements UseCase<Unit, EditProfileParams> {
  final ProfileRepository repository;
  EditProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EditProfileParams p) {
    return repository.editProfile(
      aboutMe: p.aboutMe,
      gender: p.gender,
      age: p.age,
      dob: p.dob,
      universityNumber: p.universityNumber,
      specialty: p.specialty,
      university: p.university,
      address: p.address,
      documentPaths: p.documentPaths,
    );
  }
}

class EditProfileParams extends Equatable {
  final String aboutMe;
  final String gender;
  final String age;
  final String dob;
  final String universityNumber;
  final String specialty;
  final String university;
  final String address;
  final List<String> documentPaths;

  const EditProfileParams({
    required this.aboutMe,
    required this.gender,
    required this.age,
    required this.dob,
    required this.universityNumber,
    required this.specialty,
    required this.university,
    required this.address,
    required this.documentPaths,
  });

  @override
  List<Object?> get props =>
      [aboutMe, gender, age, dob, universityNumber, specialty, university, address, documentPaths];
}
