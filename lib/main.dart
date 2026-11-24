import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash_screen_ui.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const CakeShopApp());
}

class CakeShopApp extends StatelessWidget {
  const CakeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'สายด่วนกินเค้ก',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreenUI(),
    );
  }
}
