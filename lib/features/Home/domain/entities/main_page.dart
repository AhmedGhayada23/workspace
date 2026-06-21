import 'package:equatable/equatable.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';

/// نتيجة الصفحة الرئيسية: المساحات الجديدة + المقترحة.
class MainPage extends Equatable {
  final List<SpaceItem> newSpaces;
  final List<SpaceItem> suggestSpaces;

  const MainPage({required this.newSpaces, required this.suggestSpaces});

  @override
  List<Object?> get props => [newSpaces, suggestSpaces];
}
