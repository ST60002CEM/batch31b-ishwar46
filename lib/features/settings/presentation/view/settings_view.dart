import 'package:age_care/config/router/app_routes.dart';
import 'package:age_care/core/common/widgets/custom_snackbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/themes/apptheme.dart';
import '../../../../core/common/provider/biometric_provider.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../auth/presentation/view/login/login_view.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: _buildAppBar(isDarkMode, theme),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            _buildSettingsGroup(),
            _buildAboutSettingsGroup(),
            _buildAccountSettingsGroup(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDarkMode, ThemeData theme) {
    return AppBar(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
      title: Text(
        "Settings".toUpperCase(),
        style: TextStyle(
          color: isDarkMode ? AppColors.whiteText : AppColors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  SettingsGroup _buildSettingsGroup() {
    return SettingsGroup(
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
            value: HelperFunctions.isDarkMode(context),
            onChanged: (value) {
              ref.read(appThemeProvider.notifier).toggleDarkMode();

              EasyLoading.showSuccess(
                value ? "Dark mode enabled" : "Dark mode disabled",
                duration: const Duration(seconds: 2),
              );
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
          trailing: Consumer(
            builder: (context, ref, _) {
              final isBiometricEnabled = ref.watch(biometricProvider);
              return Switch.adaptive(
                value: isBiometricEnabled,
                onChanged: (value) async {
                  ref
                      .read(biometricProvider.notifier)
                      .setBiometricEnabled(value);

                  EasyLoading.showSuccess(
                    value
                        ? "Biometric login enabled"
                        : "Biometric login disabled",
                    duration: const Duration(seconds: 2),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  SettingsGroup _buildAboutSettingsGroup() {
    return SettingsGroup(
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
    );
  }

  SettingsGroup _buildAccountSettingsGroup() {
    return SettingsGroup(
      settingsGroupTitle: "Account",
      items: [
        //Profile
        SettingsItem(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.userProfileRoute);
          },
          icons: Icons.person,
          title: "Profile",
        ),
        SettingsItem(
          onTap: () {
            _logout(context);
          },
          icons: Icons.exit_to_app_rounded,
          title: "Sign Out",
        ),
        SettingsItem(
          onTap: () {
            showSnackBar(
              message: 'Feature Under Development',
              context: context,
              color: AppColors.error,
            );
          },
          icons: CupertinoIcons.repeat,
          title: "Change email",
        ),
        SettingsItem(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.sendOTPRoute);
          },
          icons: CupertinoIcons.lock,
          title: "Change password",
        ),
        SettingsItem(
          onTap: () {
            showSnackBar(
              message:
                  'Please contact support for account deletion. This feature is under development.',
              context: context,
              color: AppColors.error,
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
    );
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
