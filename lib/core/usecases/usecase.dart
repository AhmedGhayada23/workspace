import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';

/// القاعدة المشتركة لكل use case.
/// [Type] نوع الناتج عند النجاح، [Params] نوع المدخلات.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// تُستخدم عندما لا يحتاج الـ use case أي مدخلات.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
