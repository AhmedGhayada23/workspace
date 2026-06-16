import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/localization/app_translation.dart';
import 'package:workspace/firebase_options.dart';
import 'package:workspace/utils/fb_notifications.dart';
import 'package:workspace/utils/pages.dart';
import 'package:workspace/utils/routing.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FbNotifications.initNotifications();
  await LocalStorage().initStorage();
  PlatformDispatcher.instance.onError = (error,stack){
    debugPrint(error.toString());
    return true;
  };

  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp(
    initialRoute: AppRouting.loadingView,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key,required this.initialRoute});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,

      child: GetMaterialApp(
        theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            title: 'Areisto Space',
           translations: AppTranslation(),
            locale: const Locale('ar'),
            fallbackLocale : Locale('ar'),

            debugShowCheckedModeBanner: false,
           initialRoute: initialRoute,
             getPages: pages,
      ),
    );
  }
}
