import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';

abstract class DeleteAccountRepository {
  /// إرسال رمز التحقق إلى البريد لتأكيد حذف الحساب.
  Future<Either<Failure, Unit>> sendCode(String email);

  /// التحقق من الرمز وإتمام حذف الحساب.
  Future<Either<Failure, Unit>> verifyCode({required String email, required String code});
}
