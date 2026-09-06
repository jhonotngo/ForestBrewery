import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forest_brewery_test/features/breweries/presentation/widget/search_bar_widger.dart';

void main() {
  group('SearchBarWidget', () {
    testWidgets('renders search bar with correct elements', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(onSearch: (_) {}, onClear: () {}),
          ),
        ),
      );

      // Verify TextField
      expect(find.byType(TextField), findsOneWidget);

      // Verify search button
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Verify hint text
      expect(find.text('Search breweries...'), findsOneWidget);
    });

    testWidgets('shows clear button when text is not empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(onSearch: (_) {}, onClear: () {}),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Corona');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(onSearch: (_) {}, onClear: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('calls onSearch when search button is pressed', (tester) async {
      String? searchedQuery;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              onSearch: (query) {
                searchedQuery = query;
              },
              onClear: () {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Corona');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              onSearch: (query) {
                searchedQuery = query;
              },
              onClear: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(searchedQuery, 'Corona');
    });
  });
}
