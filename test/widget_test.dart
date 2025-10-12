// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pocketly/main.dart';

void main() {
  testWidgets('App loads and displays welcome screen', (WidgetTester tester) async {
    // Build our app with ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for the splash screen to be removed
    await tester.pumpAndSettle();

    // Verify that the app loads and shows the welcome screen
    expect(find.text('Welcome to Pocketly'), findsOneWidget);
    // Le bouton Cancel a été supprimé, on vérifie seulement le titre
    
  });
}
