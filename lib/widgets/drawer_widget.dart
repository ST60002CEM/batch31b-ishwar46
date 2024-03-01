import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String userName = "N/A";
  String userEmail = "N/A";
  String userImage = "N/A";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    String? token = await secureStorage.read(key: 'authToken');

    if (token != null) {
      // Decode the token
      final parts = token.split('.');
      if (parts.length != 3) {
        return;
      }

      final payload = _decodeBase64(parts[1]);
      final payloadMap = json.decode(payload);

      if (payloadMap is Map<String, dynamic>) {
        setState(() {
          userName = payloadMap['username'] ?? "No name";
          userEmail = payloadMap['email'] ?? "No email";
          userImage = payloadMap['image'] ?? "N/A";
        });
      }
    }
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  accountEmail: Text(userEmail),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/userprofile');
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userImage),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColorDark
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
                _createDrawerItem(
                    icon: Iconsax.home5,
                    text: 'Home',
                    context: context,
                    routeName: "/"),
                _createDrawerItem(
                    icon: Iconsax.user,
                    text: 'Care Givers',
                    context: context,
                    routeName: "/"),
                _createDrawerItem(
                    icon: Iconsax.calendar,
                    text: 'Events',
                    context: context,
                    routeName: "/eventRoute"),
                _createDrawerItem(
                    icon: Iconsax.call,
                    text: 'Emergency',
                    context: context,
                    routeName: "/"),
                _createDrawerItem(
                    icon: Iconsax.smileys,
                    text: 'Random Joke',
                    context: context,
                    routeName: "/jokesRoute"),
                _createDrawerItem(
                    icon: Iconsax.setting_2,
                    text: 'Settings',
                    context: context,
                    routeName: "/"),
                _createDrawerItem(
                    icon: Iconsax.devices,
                    text: 'Sensors',
                    context: context,
                    routeName: "/gyroRoute"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _createDrawerItem({
    required IconData icon,
    required String text,
    required String routeName,
    required BuildContext context,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(text,
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyMedium!.color)),
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
