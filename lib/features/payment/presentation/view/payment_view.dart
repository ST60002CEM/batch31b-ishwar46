import 'package:age_care/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../../core/utils/helpers/helper_functions.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String referenceId = "";
  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        title: Text(
          "Payment Methods".toUpperCase(),
          style: TextStyle(
            color: isDarkMode ? AppColors.whiteText : AppColors.whiteText,
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDarkMode ? AppColors.whiteText : AppColors.whiteText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color.fromARGB(255, 92, 15, 163),
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),

            //Image for Khalti
            InkWell(
              splashColor: Colors.grey,
              onTap: () {
                print("Image Tapped");
                khaltiWallet();
              }, // Image tapped
              child: Image.asset(
                'assets/img/khalti.png',
                width: 180,
              ),
            ),

            SizedBox(
              height: 40,
            ),

            //Cash on Delivery
            InkWell(
              splashColor: Colors.grey,
              onTap: () {
                AlertDialog(
                  title: const Text("Cash on Delivery"),
                  content: const Text("Payment successful"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                );
              },
              child: Image.asset(
                'assets/img/cod.png',
                width: 100,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              splashColor: Colors.grey,
              onTap: () {
                AlertDialog(
                  title: const Text("Cash on Delivery"),
                  content: const Text("Payment successful"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                );
              },
              child: Image.asset(
                'assets/img/visa.png',
                width: 150,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: Color.fromARGB(255, 92, 15, 163),
              height: 20,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  khaltiWallet() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "1",
          productName: "nike blazers mid 77",
          mobile: "9804704028"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCanceled,
    );
  }

  // mentod to handle success
  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Payment successful"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  // method to handle failure
  void onFailure(PaymentFailureModel failure) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Failure"),
            content: Text("Payment failed"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  // method to handle onCanceled

  void onCanceled() {
    showDialog(
      context: context,
      builder: (context) {
        EasyLoading.showError('Payment canceled');
        return SizedBox(
          height: 0,
        );
      },
    );
  }
}
