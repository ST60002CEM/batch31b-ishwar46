import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../../config/constants/app_colors.dart';

class VerifyOTPPage extends ConsumerStatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends ConsumerState<VerifyOTPPage> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Enter the OTP sent to your email address',
                            style: TextStyle(
                                fontSize: 26,
                                fontFamily: 'productSansBold',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          //await verifyOTP();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5), // Adjust vertical padding
                          child: Center(
                            child: Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'productSansBold',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: AppColors.primaryColor,
                    rightIcon: const Icon(
                      Icons.backspace,
                      color: AppColors.primaryColor,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        if (text.length > 0) {
                          text = text.substring(0, text.length - 1);
                        }
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
