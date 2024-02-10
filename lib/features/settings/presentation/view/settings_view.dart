import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_colors.dart';

import '../../../../config/themes/apptheme.dart';
import '../../../../core/common/provider/biometric_provider.dart';
import '../../../auth/presentation/view/login/login_view.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(appThemeProvider);
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Settings",
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SimpleUserCard(
                onTap: () {},
                userName: "Ishwar Chaudhary",
                userProfilePic: AssetImage("assets/img/user.png"),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.blue.shade900,
                    ),
                    title: 'Appearance',
                    subtitle: "App theme, font size",
                    backgroundColor: Colors.blue.shade900,
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.fingerprint,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Privacy',
                    subtitle: "Privacy, data, permissions",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Dark mode',
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      value:
                          isDarkMode, // Set switch position based on dark mode state
                      onChanged: (value) {
                        ref
                            .read(appThemeProvider.notifier)
                            .toggleDarkMode(); // Toggle dark mode state
                      },
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.face,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.blue.shade900,
                    ),
                    title: 'Biometric Login',
                    subtitle: "Login with fingerprint or face id",
                    trailing: Consumer(builder: (context, ref, _) {
                      final isBiometricEnabled = ref.watch(biometricProvider);
                      return Switch.adaptive(
                        value: isBiometricEnabled,
                        onChanged: (value) {
                          ref.read(biometricProvider.notifier).state = value;

                          EasyLoading.showSuccess(
                            isBiometricEnabled
                                ? "Biometric login disabled"
                                : "Biometric login enabled",
                            duration: const Duration(seconds: 2),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      EasyLoading.showInfo(
                        "App version: 1.0.0\nDeveloper: Ishwar Chaudhary",
                        duration: const Duration(seconds: 3),
                      );
                    },
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'About',
                    subtitle: "App version, developer",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () {
                      _logout(context);
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                  SettingsItem(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Feature Under Development'),
                        ),
                      );
                    },
                    icons: CupertinoIcons.repeat,
                    title: "Change email",
                  ),
                  SettingsItem(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Feature Under Development'),
                        ),
                      );
                    },
                    icons: CupertinoIcons.lock,
                    title: "Change password",
                  ),
                  SettingsItem(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Feature Under Development'),
                        ),
                      );
                    },
                    icons: CupertinoIcons.delete_solid,
                    title: "Delete account",
                    titleStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _logout(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close),
      title: 'Logout',
      desc: 'Are You Sure Want To Logout?',
      btnCancelOnPress: () {},
      onDismissCallback: (type) {
        debugPrint('Dialog Dismiss from callback $type');
      },
      btnOkOnPress: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
          (route) => false,
        );
      },
    ).show();
  }
}
