import 'package:age_care/styles/appcolor.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  //networkImage: ,
                  backgroundImage: NetworkImage(
                      'https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/398680604_3685629311712485_2859045614418116677_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=DeLUWMtI0f8AX8Ye6U3&_nc_ht=scontent.fktm8-1.fna&oh=00_AfCKshbA_C81hrCsQK6-9IR4j-utdoPCIeBmeaD5Jlr2Uw&oe=657866AF'),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text(
                  'Hello! Ishwar',
                  style: TextStyle(
                    color: AppColor.whiteText,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Home',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
            onTap: () {
              // Handle Item 1 tap
            },
          ),
          ListTile(
            leading:
                Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Item 2',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Item 3',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.email, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Item 4',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading:
                Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Item 5',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              hint: Text(
                'Appointments',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 18,
                ),
              ),
              items: <String>['Day', 'Evening', 'Night'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
        ],
      ),
    );
  }
}
