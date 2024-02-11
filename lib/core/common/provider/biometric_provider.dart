import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricNotifier extends StateNotifier<bool> {
  BiometricNotifier() : super(false) {
    _loadBiometricEnabled();
  }

  // Load the biometric enabled state
  Future<void> _loadBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('biometricEnabled') ?? false;
    state = isEnabled;
  }

  // Save the biometric enabled state
  Future<void> setBiometricEnabled(bool isEnabled) async {
    state = isEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricEnabled', isEnabled);
  }
}

// Define the provider
final biometricProvider = StateNotifierProvider<BiometricNotifier, bool>((ref) {
  return BiometricNotifier();
});
