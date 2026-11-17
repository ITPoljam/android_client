import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TokoApp());
    expect(find.text('Toko App'), findsOneWidget);
  });
}
