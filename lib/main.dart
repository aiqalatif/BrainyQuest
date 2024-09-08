import 'package:brain_master/provider/level_provider.dart';
import 'package:brain_master/provider/level_task_provider.dart';
import 'package:brain_master/screens/onboarding_screens/get_started.dart';
import 'package:brain_master/screens/profile_screen/provider_services/switchProvider.dart';
import 'package:brain_master/provider/level_services.dart';
import 'package:brain_master/test_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'screens/home/provider/toggle_provider.dart';
import 'screens/profile_screen/provider_services/edit_profile_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => OpenProvider()),
        ChangeNotifierProvider(create: (context) => SwitchProvider()),
          ChangeNotifierProvider(create: (context) => LevelsProvider()),
           ChangeNotifierProvider(create: (context) => LevelProvider()),
            ChangeNotifierProvider(create: (context) => FirebaseProvider()),
        // Add more providers here if needed
        // ChangeNotifierProvider(create: (context) => AnotherProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Use MediaQuery to get the screen size
        final Size screenSize = MediaQuery.of(context).size;

        return ScreenUtilInit(
          designSize: screenSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return const GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: GetStarted(),
            );
          },
        );
      },
    );
  }
}
