import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart' as di;
import 'package:workspace/core/navigation/app_router.dart';
import 'package:workspace/core/network/connectivity_gate.dart';
import 'package:workspace/firebase_options.dart';
import 'package:workspace/utils/fb_notifications.dart';
import 'package:workspace/utils/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FbNotifications.initNotifications();
  await LocalStorage().initStorage();
  await di.initDependencies();
  PlatformDispatcher.instance.onError = (error, stack) {
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
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Areisto Space',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        ),
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar'), Locale('en')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => ConnectivityGate(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
