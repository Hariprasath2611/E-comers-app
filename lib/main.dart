import 'package:flutter/material.dart';

import 'core/config/theme.dart';
import 'core/config/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // User needs to generate this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // For now, we simulate init effectively for the code structure,
  // as we cannot run flutterfire configure without user interaction.
  await Firebase.initializeApp(); 
  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Supports both light/dark based on system
      routerConfig: appRouter,
    );
  }
}
