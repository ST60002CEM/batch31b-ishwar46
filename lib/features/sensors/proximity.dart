import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:all_sensors2/all_sensors2.dart';
import 'package:lottie/lottie.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/text_strings.dart';

class ProximityScreen extends StatefulWidget {
  const ProximityScreen({Key? key}) : super(key: key);

  @override
  State<ProximityScreen> createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  String _joke = '';

  @override
  void initState() {
    super.initState();
    _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue < 4) {
          _fetchJoke();
        } else {
          _joke = '';
        }
      });
    }));
  }

  Future<void> _fetchJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/jokes/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _joke = data['setup'] + ' ' + data['punchline'];
      });
    } else {
      throw Exception('Failed to load joke');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whiteText,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.sensorJokePageTitle.toUpperCase(),
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          color: AppColors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_proximityValue >= 4)
              const Text(
                'Object is far',
                style: TextStyle(fontSize: 20),
              )
            else
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Slowly bring your hand closer to the top of the device to generate a joke',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset(
                      'assets/lottie/joke.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    _joke.isNotEmpty
                        ? Text(
                            _joke,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        : Lottie.asset(
                            'assets/lottie/paperplane.json',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }
}
