import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';
import 'package:workspace/features/all_space/domain/usecases/get_all_spaces_usecase.dart';

part 'all_space_state.dart';

class AllSpaceCubit extends Cubit<AllSpaceState> {
  final GetAllSpacesUseCase getAllSpacesUseCase;
  final LocalStorage localStorage;

  /// المحافظات: الاسم -> المعرّف.
  static const Map<String, int> provinces = {
    'الكل': 0,
    'شمال': 1,
    'رفح': 2,
    'المغازي': 3,
    'الدير البلح': 4,
    'غزة': 5,
    'خانيونس': 6,
  };

  AllSpaceCubit({
    required this.getAllSpacesUseCase,
    required this.localStorage,
  }) : super(const AllSpaceState());

  void init() {
    loadFirstPage();
  }

  String? get _profitFilter => state.profitIndex == 0
      ? null
      : (state.profitIndex == 1 ? 'non-profit' : 'profit');

  /// التحميل الأول (يُظهر السكليتون).
  Future<void> loadFirstPage() async {
    emit(state.copyWith(spacesStatus: AllSpaceStatus.loading, spaces: [], page: 1));
    final result = await getAllSpacesUseCase(AllSpacesParams(
      page: 1,
      provinceId: state.provinceId,
      profitFilter: _profitFilter,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        spacesStatus: AllSpaceStatus.error,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        spacesStatus: AllSpaceStatus.loaded,
        spaces: data.items,
        page: 1,
        hasMore: !data.isLastPage,
      )),
    );
  }

  /// تحميل صفحة إضافية عند الوصول لنهاية القائمة.
  Future<void> loadMore() async {
    if (state.loadingMore || !state.hasMore || state.spacesStatus != AllSpaceStatus.loaded) {
      return;
    }
    emit(state.copyWith(loadingMore: true));
    final next = state.page + 1;
    final result = await getAllSpacesUseCase(AllSpacesParams(
      page: next,
      provinceId: state.provinceId,
      profitFilter: _profitFilter,
    ));
    result.fold(
      (_) => emit(state.copyWith(loadingMore: false)),
      (data) => emit(state.copyWith(
        spaces: [...state.spaces, ...data.items],
        page: next,
        hasMore: !data.isLastPage,
        loadingMore: false,
      )),
    );
  }

  void changeProfit(int index) {
    if (state.profitIndex == index) return;
    emit(state.copyWith(profitIndex: index));
    loadFirstPage();
  }

  void applyProvince(int provinceId) {
    emit(state.copyWith(provinceId: provinceId));
    loadFirstPage();
  }

  String availableText(SpaceItem item) =>
      '${_formatTime(item.availableFrom)} - ${_formatTime(item.availableTo)}';

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
