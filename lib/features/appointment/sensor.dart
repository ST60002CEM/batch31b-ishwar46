import 'package:age_care/features/appointment/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModePage extends ConsumerWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Mode Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Toggle dark mode
            ref.read(appThemeProvider.notifier).toggleDarkMode();
          },
          child: Text('Toggle Dark Mode'),
        ),
      ),
    );
  }
}
