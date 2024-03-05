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

//Find the Logo on the login page
  testWidgets(
    'find logo on login page',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
    },
  );

  //Find the Remember Me checkbox on the login page
  testWidgets(
    'find remember me checkbox on login page',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));
      await tester.pumpAndSettle();

      // Find the Remember Me checkbox
      expect(find.byType(Checkbox), findsOneWidget);
    },
  );
}

// testWidgets(
  //     'navigate to registration page when tapping "Don\'t have an account" text',
  //     (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: LoginView(),
  //   ));
  //   await tester.pumpAndSettle();

  //   // Print the widget tree
  //   debugDumpApp();

  //   // Step 1: Tap the "Don't have an account" text
  //   await tester.tap(find.byKey(const ValueKey('registerButton')));
  //   await tester.pumpAndSettle();

  //   // Print the widget tree again after the tap
  //   debugDumpApp();

  //   // Step 2: Verify navigation to registration page
  //   expect(find.text('RegisterGarrarahaiiii'), 'RegisterGarrarahaiiii');
  // });