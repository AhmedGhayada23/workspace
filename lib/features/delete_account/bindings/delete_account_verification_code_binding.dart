import 'package:get/get.dart';
import 'package:workspace/features/delete_account/controllers/delete_account_verification_code_controller.dart';

class DeleteAccountVerificationCodeBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> DeleteAccountVerificationCodeController(),fenix: true);
  }
}