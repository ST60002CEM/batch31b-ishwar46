import 'dart:math';

import 'package:age_care/features/forgot_password/presentation/viewmodel/otp_view_model.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_sizes.dart';
import '../../../../config/constants/text_strings.dart';

class VerifyOTPPage extends ConsumerStatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends ConsumerState<VerifyOTPPage> {
  String text = "";
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _otpcontroller = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteText,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text("Verify OTP and Reset Password",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 18,
                color: AppColors.whiteText,
              ),
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  maxBlastForce: 5,
                  minBlastForce: 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Enter the OTP sent to your registered email and reset your password.',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Lottie.asset(
                'assets/lottie/verify.json',
                height: 200,
                width: 200,
              ),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      //OTP
                      TextFormField(
                        key: const ValueKey('otp'),
                        controller: _otpcontroller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: AppTexts.otp,
                          hintText: AppTexts.otp,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      //newPassword
                      TextFormField(
                        key: const ValueKey('newPassword'),
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: AppTexts.newPassword,
                          hintText: AppTexts.newPasswordHint,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      //email confirmation
                      TextFormField(
                        key: const ValueKey('email'),
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: AppTexts.confrimemail,
                          hintText: AppTexts.confrimemail,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              onPressed: () async {
                                final formState = _key.currentState;
                                if (formState != null &&
                                    formState.mounted &&
                                    formState.validate()) {
                                  await ref
                                      .read(otpViewModelProvider.notifier)
                                      .verifyOTPandUpdatePassword(
                                          _emailController.text,
                                          _otpcontroller.text,
                                          _newPasswordController.text,
                                          context);
                                }
                                // // confettiController
                                //     .play(); // Play confetti animation
                              },
                              child:
                                  Text(AppTexts.verifyandUpdate.toUpperCase()),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwSections,
                      )
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
