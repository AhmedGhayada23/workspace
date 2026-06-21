import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/notification/domain/usecases/notifications_usecases.dart';

/// عدّاد الإشعارات غير المقروءة (singleton مشترك بين الرئيسية و all_space).
/// يُحدَّث عند: الدخول، وصول إشعار FCM، استئناف التطبيق، والتعليم كمقروء.
class NotificationBadgeCubit extends Cubit<int> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationBadgeCubit(this.getNotificationsUseCase) : super(0);

  /// يعيد جلب الإشعارات ويحسب غير المقروءة.
  Future<void> refresh() async {
    final result = await getNotificationsUseCase(1);
    result.fold(
      (_) {},
      (page) => emit(page.items.where((n) => n.readAt == null).length),
    );
  }

  /// تصفير العدّاد (بعد التعليم كمقروء).
  void clear() => emit(0);
}
