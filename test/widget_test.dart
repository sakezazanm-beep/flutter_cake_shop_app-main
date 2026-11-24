import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_cake_shop_project/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Future<void> setIPhone16ProMaxSize(WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
  }

  testWidgets('shows the splash screen then the cake shop list', (tester) async {
    await setIPhone16ProMaxSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CakeShopApp());

    expect(find.text('สายด่วนกินเค้ก'), findsOneWidget);
    expect(find.text('CAKE CALL FAST'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Yellow Spoon Pastry'), findsOneWidget);
    expect(find.text('0854822842'), findsOneWidget);
    expect(find.text('Bake Ministry'), findsOneWidget);
  });

  testWidgets('opens shop details from the information button', (tester) async {
    await setIPhone16ProMaxSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CakeShopApp());
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.byTooltip('ดูข้อมูลร้าน Yellow Spoon Pastry'));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    expect(find.text('รายละเอียดร้านเค้ก'), findsOneWidget);
    expect(find.text('Yellow Spoon Pastry'), findsOneWidget);
    expect(find.text('แผนที่ร้าน'), findsOneWidget);
  });
}







