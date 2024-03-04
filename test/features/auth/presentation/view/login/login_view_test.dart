import 'package:age_care/features/auth/presentation/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check for text LOGIN the page', (tester) async {
    //Step 1 : Material widget lai launch gareko
    await tester.pumpWidget(
      MaterialApp(
        home: LoginView(),
      ),
    );

    await tester.pumpAndSettle(); // wait for the widget to render

    //Step 2 : Verify the text
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets(
      'enter username and password, press Login button, and verify login action',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginView(),
    ));
    await tester.pumpAndSettle();

    // Step 1: Enter username and password
    await tester.enterText(find.byKey(ValueKey('username')), 'testuser');
    await tester.enterText(find.byKey(ValueKey('password')), 'testpassword');

    // Step 2: Tap the login button
    await tester.tap(find.byKey(ValueKey('loginbutton')));
    await tester.pump();

    // Step 3: After tapping the login button, Find the "Logging In" text
    expect(find.byWidgetPredicate((widget) {
      if (widget is ElevatedButton) {
        final buttonText = widget.child as Text;
        return buttonText.data == 'Logging I';
      }
      return false;
    }), findsOneWidget);

    // Step 4: Wait for the widget to render
    await tester.pumpAndSettle();
  });
}
