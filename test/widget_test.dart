import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profy/app/app.dart';

void main() {
  testWidgets('Auth screen is the initial route', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ProfyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Auth screen'), findsOneWidget);
  });
}
