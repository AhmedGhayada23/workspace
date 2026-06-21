import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/domain/usecases/book_non_profit_usecase.dart';
import 'package:workspace/features/details_space/domain/usecases/get_details_usecase.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final GetDetailsUseCase getDetailsUseCase;
  final BookNonProfitUseCase bookNonProfitUseCase;

  DetailsCubit({required this.getDetailsUseCase, required this.bookNonProfitUseCase})
      : super(const DetailsState());

  Future<void> load(int id) async {
    emit(state.copyWith(status: DetailsStatus.loading));
    final result = await getDetailsUseCase(id);
    result.fold(
      (failure) => emit(state.copyWith(status: DetailsStatus.error, errorMessage: failure.message)),
      (model) => emit(state.copyWith(status: DetailsStatus.loaded, model: model)),
    );
  }

  void setBookingType(int index) => emit(state.copyWith(bookingTypeIndex: index));

  Future<void> confirmNonProfit(int spaceId) async {
    emit(state.copyWith(bookingStatus: BookingStatus.loading));
    final result = await bookNonProfitUseCase(spaceId);
    result.fold(
      (failure) => emit(state.copyWith(
        bookingStatus: BookingStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(bookingStatus: BookingStatus.success)),
    );
  }

  /// إعادة حالة الحجز إلى الخمول بعد معالجة النتيجة في الـ view.
  void resetBooking() => emit(state.copyWith(bookingStatus: BookingStatus.idle));

  /// الوصول السريع لكائن المساحة.
  Spaces? get space => state.model?.data?.spaces;

  String availableText() =>
      '${_formatTime(space?.availableFrom)} - ${_formatTime(space?.availableTo)}';

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '---';
    try {
      final formatted = DateFormat('hh:mm a')
          .format(DateFormat('hh:mm a').parse(timeStr.toUpperCase()));
      return formatted.contains('AM')
          ? formatted.replaceAll('AM', 'صباحًا')
          : formatted.replaceAll('PM', 'مساءً');
    } catch (_) {
      return '---';
    }
  }
}
