import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = StateNotifierProvider<AppThemeProvider, bool>(
  (ref) => AppThemeProvider(),
);

class AppThemeProvider extends StateNotifier<bool> {
  AppThemeProvider() : super(false);

  void toggleDarkMode() {
    state = !state;
  }
}
