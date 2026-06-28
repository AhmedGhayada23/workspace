import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';
import 'package:workspace/features/profile/domain/usecases/profile_usecases.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit({required this.getProfileUseCase, required this.logoutUseCase})
      : super(const ProfileState());

  Future<void> load() async {
    // نبدأ من حالة نظيفة لمسح بيانات أي حساب سابق وعلم loggedOut.
    emit(const ProfileState(status: ProfileStatus.loading));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, errorMessage: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.loaded, profile: profile)),
    );
  }

  /// يُحمّل مرة واحدة فقط إن لم يُحمَّل بعد (للنسخة المشتركة).
  Future<void> loadIfNeeded() async {
    if (state.status == ProfileStatus.initial) await load();
  }

  /// تصفير الحالة (عند انتهاء الجلسة) لمسح بيانات الحساب الحالي.
  void reset() => emit(const ProfileState());

  Future<void> logout() async {
    emit(state.copyWith(loggingOut: true));
    final result = await logoutUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(loggingOut: false, errorMessage: failure.message)),
      // إعادة الحالة لنظافة كاملة (بلا بيانات الحساب السابق) مع علم الخروج.
      (_) => emit(const ProfileState(loggedOut: true)),
    );
  }
}
