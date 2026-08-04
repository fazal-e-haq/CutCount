import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cut_count/features/dashboard/widgets/dashboard_stat_card.dart';

// UI tests in Flutter are called "Widget Tests". 
// They allow us to build and interact with widgets in a test environment 
// without needing to launch the app on an actual emulator or physical phone.
void main() {
  group('DashboardStatCard Widget Tests', () {
    
    // Notice we use `testWidgets` instead of `test`, and it provides a `WidgetTester` object.
    testWidgets('Card should display title, value, and icon correctly', (WidgetTester tester) async {
      
      // 1. Arrange
      // We must wrap our widget in a MaterialApp so it has access to 
      // foundational Flutter things like Themes, Directionality, and MediaQueries.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DashboardStatCard(
              title: 'Total Revenue',
              value: 'Rs. 5000',
              icon: Icons.attach_money,
            ),
          ),
        ),
      );

      // 2. Act
      // Usually, 'Act' involves tapping a button: await tester.tap(find.byType(ElevatedButton));
      // For this test, we are just verifying rendering, so there is no specific action to take.
      
      // 3. Assert
      // We use 'Finders' (like find.text or find.byIcon) to search the UI.
      // We use 'Matchers' (like findsOneWidget or findsNothing) to verify what we found.
      
      // Look for the exact title text
      expect(find.text('Total Revenue'), findsOneWidget);
      
      // Look for the exact value text
      expect(find.text('Rs. 5000'), findsOneWidget);
      
      // Look for the specific icon we passed in
      expect(find.byIcon(Icons.attach_money), findsOneWidget);
      
      // Make sure something that shouldn't be there is NOT there
      expect(find.text('Random fake text'), findsNothing);
    });
  });
}
