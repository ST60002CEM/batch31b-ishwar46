import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../config/constants/app_sizes.dart';
import '../../../../../config/constants/image_strings.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../../../../config/router/app_routes.dart';
import '../../../../../core/common/provider/connection.dart';
import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/common/widgets/custom_snackbar.dart';
import '../../../../../core/utils/validators/validators.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../auth_viewmodel/auth_viewmodel.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Connectivity Status
      if (ref.watch(connectivityStatusProvider) ==
          ConnectivityStatus.isDisconnected) {
        showSnackBar(
            message: 'No Internet Connection',
            context: context,
            color: Colors.red);
      } else if (ref.watch(connectivityStatusProvider) ==
          ConnectivityStatus.isConnecting) {
        showSnackBar(
            message: 'Connecting...', context: context, color: Colors.yellow);
      } else if (ref.watch(connectivityStatusProvider) ==
          ConnectivityStatus.isConnected) {
        showSnackBar(
            message: 'Connected', context: context, color: Colors.green);
      }
      if (ref.watch(authViewModelProvider).showMessage!) {
        EasyLoadingAnimationStyle.custom;
        EasyLoading.showSuccess('User Registered Successfully',
            dismissOnTap: false);
        ref.read(authViewModelProvider.notifier).resetMessage(false);
      }
    });
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
                    height: 100,
                    image: AssetImage(
                        dark ? AppImages.darkAppLogo : AppImages.lightAppLogo),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  Text(AppTexts.registerPageTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: AppSizes.sm),
                  Text(AppTexts.registerPageSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              //const SizedBox(height: AppSizes.spaceBtwnInputFields),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      //first name
                      TextFormField(
                        key: const ValueKey('firstName'),
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppTexts.firstName,
                          hintText: AppTexts.firstNameHint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validateFirstName(value);
                          return error;
                        },
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      TextFormField(
                        key: const ValueKey('lastName'),
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppTexts.lastName,
                          hintText: AppTexts.lastNameHint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validateLastName(value);
                          return error;
                        },
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
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
                      SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      //Email
                      TextFormField(
                        key: const ValueKey('email'),
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(LineIcons.mailchimp),
                          labelText: AppTexts.email,
                          hintText: AppTexts.emailHint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validateEmail(value);
                          return error;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      //Address
                      TextFormField(
                        key: const ValueKey('address'),
                        controller: _addressController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.location),
                          labelText: AppTexts.address,
                          hintText: AppTexts.addresshint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validateAddress(value);
                          return error;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      //Password
                      // TextFormField for Password
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: isObscure,
                        controller: _passwordController,
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
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),

                      //Phone
                      TextFormField(
                        key: const ValueKey('phone'),
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: AppTexts.phone,
                          hintText: AppTexts.phonehint,
                        ),
                        validator: (value) {
                          final error = AppValidator.validatePhoneNumber(value);
                          return error;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      //Sign in Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            final formState = _key.currentState;
                            if (formState != null &&
                                formState.mounted &&
                                formState.validate()) {
                              final entity = AuthEntity(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                phone: _phoneController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                              // Register staff
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .registerStaff(entity, context);
                            }
                          },
                          child: Text(AppTexts.register.toUpperCase()),
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),
                      //Already a login
                      InkWell(
                        key: const ValueKey('loginbutton'),
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.loginRoute);
                        },
                        child: Text(AppTexts.alreadyuser),
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
