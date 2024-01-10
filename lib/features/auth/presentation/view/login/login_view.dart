import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/constants/app_sizes.dart';
import '../../../../../config/constants/image_strings.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../../../../config/router/app_routes.dart';
import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/utils/validators/validators.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //Logo
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(
                        dark ? AppImages.darkAppLogo : AppImages.lightAppLogo),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      //Username
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
                      //Password
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

                      //Remeber Me and Forget Password
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

                      //Sign in Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          onPressed: () async {
                            Navigator.pushNamed(context, MyRoutes.homeRoute);
                          },
                          child: Text(AppTexts.login.toUpperCase()),
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
