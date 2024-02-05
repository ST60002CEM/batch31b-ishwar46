import 'dart:async';

import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:age_care/features/auth/presentation/auth_viewmodel/auth_viewmodel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:light/light.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../config/constants/app_sizes.dart';
import '../../../../../config/constants/image_strings.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../../../../config/router/app_routes.dart';
import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/utils/validators/validators.dart';
import '../../../../../config/themes/apptheme.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  String _luxString = 'Unknown';
  Light? _light;
  StreamSubscription? _subscription;
  bool isObscure = true;
  bool isDarkModeDialogShown = false;

  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";

      // Check if luxValue is below a certain threshold (adjust the threshold as needed)
      if (luxValue < 20 && !isDarkModeDialogShown) {
        isDarkModeDialogShown = true; // Set to true to prevent multiple dialogs
        showDarkModeAlertDialog(context);
      }
    });
  }

  void showDarkModeAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Low Light Detected!',
      desc: 'Do you want to enable dark mode?',
      btnCancelOnPress: () {
        isDarkModeDialogShown = true;
      },
      btnOkOnPress: () {
        ref.read(appThemeProvider.notifier).toggleDarkMode();
        isDarkModeDialogShown = false;
      },
    )..show();
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light?.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  Future<bool> _authenticateUser(BuildContext context) async {
    final LocalAuthentication localAuth = LocalAuthentication();

    try {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
      );

      return isAuthenticated;
    } catch (e) {
      // Handle authentication errors
      print('Authentication failed: $e');
      // You may want to show an error message to the user
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  void dispose() {
    // Dispose the sensor subscription when the widget is disposed
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image(
                      height: 150,
                      image: AssetImage(dark
                          ? AppImages.darkAppLogo
                          : AppImages.lightAppLogo),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  Text(AppTexts.loginPageTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: AppSizes.sm),
                  Text(AppTexts.loginPageSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwnInputFields),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('username'),
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppTexts.username,
                          hintText: AppTexts.usernamehint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validateUsername(value);
                          return error;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      TextFormField(
                        key: const ValueKey('password'),
                        controller: _passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: AppTexts.password,
                          hintText: AppTexts.passwordHint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure ? Iconsax.eye : Iconsax.eye_slash,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          final error = AppValidator.validatePassword(value);
                          return error;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(AppTexts.remeberme),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(AppTexts.forgetPassword),
                          )
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              bool isAuthenticated =
                                  await _authenticateUser(context);

                              if (isAuthenticated) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .loginStaff(
                                      _usernameController.text,
                                      _passwordController.text,
                                      context,
                                    );
                              }
                            },
                            icon: Icon(Iconsax.finger_scan),
                            label: Text('Biometric Login'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                      Hero(
                        tag: 'loginbutton',
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .loginStaff(
                                      _usernameController.text,
                                      _passwordController.text,
                                      context,
                                    );
                              }
                            },
                            child: Text(AppTexts.login.toUpperCase()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),
                      InkWell(
                        key: const ValueKey('registerButton'),
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.signupRoute);
                        },
                        child: Text(AppTexts.register),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
