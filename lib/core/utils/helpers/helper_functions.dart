import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Aqua') {
      return Colors.blueAccent;
    } else if (value == 'Primary color') {
      return const Color.fromARGB(255, 13, 84, 142);
    } else if (value == 'Secondary') {
      return Colors.pink;
    } else if (value == 'Accent color') {
      return const Color.fromARGB(255, 22, 126, 216);
    } else if (value == 'Success') {}
  }

  // Show Snack bar

  //Truncate Text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  //Is Dark Mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // static double screenHeight(BuildContext context) {
  //   return MediaQuery.of(context).size.width;
  // }

  // static double

  static String getFormattedDate(DateTime date,
      {String format = 'dd MM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<Widget> wrapWidget(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
    }
    return wrappedList;
  }
}

//Toogle Dark Mode

void toggleDarkMode(BuildContext context) {
  final theme = Theme.of(context);
  final brightness = theme.brightness;
  final newTheme = brightness == Brightness.dark
      ? ThemeData.light()
      : ThemeData.dark().copyWith(
          primaryColor: const Color.fromARGB(255, 13, 84, 142),
          hintColor: const Color.fromARGB(255, 22, 126, 216),
        );
  final newMaterial = MaterialApp(
    theme: newTheme,
    home: const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => newMaterial),
  );
}
