import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/auth/domain/entities/auth_token.dart';

/// عقد طبقة المصادقة — تُنفّذه طبقة الـ data.
abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> register({
    required String name,
    required String type,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, AuthToken>> googleLogin({
    required String accessToken,
    required String type,
  });

  /// إرسال رمز التحقق إلى البريد (نسيت كلمة المرور).
  Future<Either<Failure, Unit>> sendResetCode(String email);

  /// التحقق من رمز تفعيل حساب جديد — يُعيد التوكن.
  Future<Either<Failure, AuthToken>> verifyActivationCode({
    required String email,
    required String code,
  });

  /// التحقق من رمز استعادة كلمة المرور.
  Future<Either<Failure, Unit>> verifyForgotPasswordCode({
    required String email,
    required String code,
  });

  /// تعيين كلمة مرور جديدة بعد التحقق من الرمز.
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  });
}
