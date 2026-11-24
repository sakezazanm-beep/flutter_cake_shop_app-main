import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import 'cake_shop_list_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const CakeShopListUI()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg_welcome.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x22FFFFFF),
                  Color(0x12FFFFFF),
                  Color(0x33000000),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                Text(
                  'สายด่วนกินเค้ก',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(
                    color: AppColors.redDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    height: 1.1,
                    shadows: const [Shadow(color: Colors.white, blurRadius: 6)],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'CAKE CALL FAST',
                  style: GoogleFonts.kanit(
                    color: const Color(0xFFE95562),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Color(0xFF42484B),
                  ),
                ),
                const Spacer(flex: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
