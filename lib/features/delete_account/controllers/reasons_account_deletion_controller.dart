import 'package:get/get.dart';

class ReasonsAccountDeletionController  extends GetxController{
   List<String> reasons = [
    'تجربة مستخدم غير مرضية',
    'مشاكل في التطبيق',
    'قلة الميزات',
    'وجدت تطبيق أفضل',
    'أسباب أخرى',
  ];

  RxList<String> selectedReasons = <String>[].obs;


    void toggleReason(String reason) {
    
      if (selectedReasons.contains(reason)) {
        selectedReasons.remove(reason); // يحذف لو كان موجود
      } else {
        selectedReasons.add(reason); // يضيف لو مش موجود
      }
    }
  }
