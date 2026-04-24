import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/screens/homepage/home_view.dart';
import 'package:portfolio/services/analytics_services.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/controllers.dart';
import 'package:portfolio/utils/environment.dart';
import 'package:portfolio/utils/text_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  // Get.put(AnalyticServices(), tag: 'analytics');
  await dotenv.load(fileName: Environment.envFile);
  // analyticServices.logEvent(eventName: "App initialized");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return GetMaterialApp(
          title: 'Rahul Chauhan - Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: AppColors.background,
            scaffoldBackgroundColor: AppColors.background,
            canvasColor: AppColors.lightBlackContainer,
            cardColor: AppColors.lightBlackContainer,
            dividerColor: AppColors.borderColor,
            textSelectionTheme: TextSelectionThemeData(
                selectionColor: AppColors.selectionColor.withOpacity(.7),
                selectionHandleColor: AppColors.accentDark,
                cursorColor: AppColors.accent
            ),
            textTheme: size.deviceScreenType == DeviceScreenType.mobile? mobileTextTheme: deskTopTextTheme,
            fontFamily: 'Poppins',
          ),
          // navigatorObservers: [analyticServices.getAnalyticsObserver()],
          home: const HomeView(),
        );
      }
    );
  }
}
