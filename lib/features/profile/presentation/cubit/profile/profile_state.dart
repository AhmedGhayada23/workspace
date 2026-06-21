part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileDataModel? profile;
  final bool loggingOut;
  final bool loggedOut;
  final String errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.loggingOut = false,
    this.loggedOut = false,
    this.errorMessage = '',
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileDataModel? profile,
    bool? loggingOut,
    bool? loggedOut,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      loggingOut: loggingOut ?? this.loggingOut,
      loggedOut: loggedOut ?? this.loggedOut,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, loggingOut, loggedOut, errorMessage];
}
