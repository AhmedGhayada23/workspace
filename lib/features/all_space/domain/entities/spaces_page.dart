import 'package:equatable/equatable.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';

/// صفحة من نتائج المساحات (للترقيم).
class SpacesPage extends Equatable {
  final List<SpaceItem> items;
  final bool isLastPage;

  const SpacesPage({required this.items, required this.isLastPage});

  @override
  List<Object?> get props => [items, isLastPage];
}
