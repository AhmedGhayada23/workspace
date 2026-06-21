import 'package:equatable/equatable.dart';

/// عنصر نتيجة بحث (اسم الشركة + المحافظة).
class SearchResultItem extends Equatable {
  final int id;
  final String companyName;
  final String provinceName;

  const SearchResultItem({
    required this.id,
    required this.companyName,
    required this.provinceName,
  });

  @override
  List<Object?> get props => [id, companyName, provinceName];
}
