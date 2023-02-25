import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/constants/app_constants.dart';
import 'package:flutter_responsive_list_demo/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('App Flow Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Type 1 - Should open the Data Grid Page with JSON Type 1',
        (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomePage()),
        ),
      );

      // ACT
      Finder urlTextField = find.byType(TextField);
      Finder submitButton = find.byType(ElevatedButton);

      await tester.enterText(urlTextField, AppConstants.jsonUrl1);
      await tester.tap(submitButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      Finder appBarText = find.text(AppConstants.appBarTitle);

      await Future.delayed(const Duration(seconds: 5));
      // ASSERT
      expect(appBarText, findsOneWidget);
    });

    testWidgets(
        'Type 2 - Should open the Data Grid Page with JSON Type 2 (Game of Thrones)',
        (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomePage()),
        ),
      );

      // ACT
      Finder urlTextField = find.byType(TextField);
      Finder submitButton = find.byType(ElevatedButton);

      await tester.enterText(urlTextField, AppConstants.jsonUrl2);
      await tester.tap(submitButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      Finder appBarText = find.text(AppConstants.appBarTitle);

      await Future.delayed(const Duration(seconds: 5));
      // ASSERT
      expect(appBarText, findsOneWidget);
    });
  });
}
