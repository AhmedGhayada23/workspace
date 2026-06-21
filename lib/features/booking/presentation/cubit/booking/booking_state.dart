part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final int subscriptionId;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  const BookingState({
    this.subscriptionId = 0,
    this.startDate = '',
    this.endDate = '',
    this.startTime = '',
    this.endTime = '',
  });

  BookingState copyWith({
    int? subscriptionId,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
  }) {
    return BookingState(
      subscriptionId: subscriptionId ?? this.subscriptionId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [subscriptionId, startDate, endDate, startTime, endTime];
}
