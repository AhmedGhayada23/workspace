import 'package:equatable/equatable.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart';

/// صفحة من الإشعارات (للترقيم).
class NotificationsPage extends Equatable {
  final List<Notifications> items;
  final bool isLastPage;

  const NotificationsPage({required this.items, required this.isLastPage});

  @override
  List<Object?> get props => [items, isLastPage];
}
