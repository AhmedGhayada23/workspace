import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// يغلّف تسجيل الدخول عبر Google SDK + Firebase، ويُعيد الـ accessToken.
class GoogleAuthService {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  GoogleAuthService({required this.googleSignIn, required this.firebaseAuth});

  /// يُعيد accessToken عند النجاح، أو null إذا ألغى المستخدم العملية.
  Future<String?> signIn() async {
    // مسح جلسة Google السابقة أولاً حتى تظهر شاشة اختيار الحساب في كل مرة
    // (بدلاً من إعادة استخدام الحساب السابق تلقائياً).
    await signOut();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
    return googleAuth.accessToken;
  }

  /// يُنهي جلسة Google + Firebase (يُستدعى عند تسجيل الخروج من التطبيق).
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (_) {
      // تجاهل أخطاء الخروج (لا تمنع المستخدم)
    }
  }
}
