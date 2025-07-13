import 'package:get/get.dart';
import 'package:workspace/features/delete_account/controllers/reasons_account_deletion_controller.dart';

class ReasonsForAccountDeletionBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(()=> ReasonsAccountDeletionController(),fenix: true);
  }
}