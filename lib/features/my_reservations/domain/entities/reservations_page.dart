import 'package:equatable/equatable.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';

/// صفحة من الحجوزات (للترقيم).
class ReservationsPage extends Equatable {
  final List<Reservations> items;
  final bool isLastPage;

  const ReservationsPage({required this.items, required this.isLastPage});

  @override
  List<Object?> get props => [items, isLastPage];
}
