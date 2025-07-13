import 'package:get/get.dart';
import 'package:workspace/features/delete_account/controllers/delete_account_sent_otp_controller.dart';

class DeleteAccountSentOtpBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(()=> DeleteAccountSentOtpController(),fenix: true);
  }
} 