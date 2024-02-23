import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/emptybox.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 20),
        Text('No appointments available.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Text(
          'Please book one from the action button.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
