import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/start/splash.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/local.dart';

Future main() async {
  // Initialize the database
  await Supabase.initialize(
    url: 'https://cjjgtakjpbzlwsuvatqy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNqamd0YWtqcGJ6bHdzdXZhdHF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgwOTk3MTcsImV4cCI6MjA1MzY3NTcxN30.5NBGo4zGCWajHpKUKrhI7ksp05Y_Y-quOrJNqMzNCOU',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Custom preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize User Local Preferences
  LocalPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Map<String, dynamic> userInfo;

  @override
  void initState() {
    super.initState();
    getLocalUserInfo();
  }

  // Get or Retrieve local user information
  getLocalUserInfo() async {
    userInfo = LocalPreferences.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                scaffoldMessengerKey: LocalPreferences.messagerKey,
                title: 'Teela',
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
                themeMode: themeProvider.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                home: Splash(
                  userInfo: userInfo,
                ),
              );
            },
          );
        });
  }
}
