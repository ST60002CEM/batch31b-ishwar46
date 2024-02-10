import 'package:age_care/config/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                  accountName: Text(
                    "Ishwar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text("ishwar@example.com"),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/userprofile');
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/img/user.png"),
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
                    icon: Iconsax.home5, text: 'Home', context: context),
                _customDivider(),
                _createDrawerItem(
                    icon: Iconsax.user, text: 'Care Givers', context: context),
                _customDivider(),
                _createDrawerItem(
                    icon: Iconsax.calendar, text: 'Events', context: context),
                _customDivider(),
                _createDrawerItem(
                    icon: Iconsax.call, text: 'Emergency', context: context),
                _customDivider(),
                _createDrawerItem(
                    icon: Iconsax.setting_2,
                    text: 'Settings',
                    context: context),
              ],
            ),
          ),
          // Footer section
          ListTile(
            leading: Icon(Iconsax.logout),
            title: Text('Log out'),
            onTap: () {
              // Handle log out
            },
          ),
        ],
      ),
    );
  }

  Divider _customDivider() =>
      Divider(indent: 16, endIndent: 16, color: Colors.grey.shade400);

  ListTile _createDrawerItem({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      onTap: () {
        // Handle navigation
        HapticFeedback.lightImpact();
      },
    );
  }
}
