import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_state.dart';

/// يحمل اختيارات نموذج الحجز (لا اتصال شبكة — مجرد حالة نموذج).
class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  void setSubscription(int id) => emit(state.copyWith(subscriptionId: id));
  void setStartDate(String date) => emit(state.copyWith(startDate: date));
  void setEndDate(String date) => emit(state.copyWith(endDate: date));
  void setStartTime(String time) => emit(state.copyWith(startTime: time));
  void setEndTime(String time) => emit(state.copyWith(endTime: time));
}
