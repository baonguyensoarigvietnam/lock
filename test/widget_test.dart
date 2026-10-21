import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:applock/presentation/screen/home/widget/home_promo_banner.dart';
import 'package:applock/presentation/screen/main/widget/app_bottom_nav_bar.dart';

void main() {
  testWidgets('AppBottomNavBar renders 5 tabs and responds to tap',
      (WidgetTester tester) async {
    int selected = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: selected,
            onTap: (index) {
              selected = index;
            },
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Apps'), findsOneWidget);
    expect(find.text('Vault'), findsOneWidget);
    expect(find.text('Alerts'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Vault'));
    expect(selected, 2);
  });

  testWidgets('HomePromoBanner renders text and star icon',
      (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomePromoBanner(
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('UNLOCK ALL FEATURES'), findsOneWidget);
    expect(find.text('Unlimited themes, free ads and more.'), findsOneWidget);
    expect(find.byIcon(Icons.star_border_rounded), findsOneWidget);

    await tester.tap(find.byType(HomePromoBanner));
    expect(tapped, isTrue);
  });
}
