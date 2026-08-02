import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:profy/app/app.dart';
import 'package:profy/core/constants/app_constants.dart';
import 'package:profy/core/database/app_database.dart';
import 'package:profy/core/database/database_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Auth screen shows app brand', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) {
            final database = AppDatabase(NativeDatabase.memory());
            ref.onDispose(database.close);
            return database;
          }),
        ],
        child: const ProfyApp(),
      ),
    );

    // Bootstrap de auth tiene duración mínima de 2s + loader animado.
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text(AppConstants.appName).evaluate().isNotEmpty) break;
    }

    expect(find.text(AppConstants.appName), findsOneWidget);
  });
}
