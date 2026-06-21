part of 'btn_nav_cubit.dart';

class BtnNavState extends Equatable {
  final int currentIndex;
  final UserType userType;

  const BtnNavState({
    this.currentIndex = 0,
    this.userType = UserType.normal,
  });

  BtnNavState copyWith({int? currentIndex, UserType? userType}) {
    return BtnNavState(
      currentIndex: currentIndex ?? this.currentIndex,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [currentIndex, userType];
}
