import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendOTPPage extends StatefulWidget {
  @override
  _SendOTPPageState createState() => _SendOTPPageState();
}

class _SendOTPPageState extends State<SendOTPPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendOTP(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.18.236:5000/api/send-otp'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      print('OTP sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent successfully')),
      );
    } else if (response.statusCode == 404) {
      print('User not found');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not found')),
      );
    } else {
      print('Failed to send OTP: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String email = _emailController.text;
                sendOTP(email);
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
