import 'package:age_care/core/common/widgets/shimmer_loading_widget.dart';
import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:age_care/features/clients/data_source.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/text_strings.dart';

class StaffViewNew extends StatefulWidget {
  @override
  State<StaffViewNew> createState() => _StaffViewNewState();
}

class _StaffViewNewState extends State<StaffViewNew> {
  List<dynamic> clients = [];

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  Future<void> fetchClients() async {
    try {
      final fetchedClients = await ApiClient.fetchClients();
      setState(() {
        clients = fetchedClients;
      });
    } catch (error) {
      print(error);
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        title: Text(
          AppTexts.staffDetails.toUpperCase(),
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
      body: clients.isEmpty
          ? Center(child: ShimmerLoadingEffect())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  List<Color> cardColors = [
                    isDarkMode ? AppColors.dark : AppColors.primaryColor,
                    isDarkMode
                        ? Color.fromARGB(255, 67, 71, 74)
                        : AppColors.secondaryColor,
                  ];
                  String initials = _generateInitials(
                      client['firstName'], client['lastName']);
                  return Card(
                    color: cardColors[index % 2],
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            isDarkMode ? AppColors.black : AppColors.whiteText,
                        child: Text(initials),
                      ),
                      title: Text(
                        '${client['firstName']} ${client['lastName']}',
                        style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            client['email'],
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.whiteText
                                  : AppColors.white,
                            ),
                          ),
                          Text(
                            client['address'],
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.whiteText
                                  : AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          _showClientDetailsModal(context, client);
                          _launchPhoneCall(client['phoneNumber']);
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 5,
                          splashFactory: InkRipple.splashFactory,
                          backgroundColor: isDarkMode
                              ? AppColors.primaryColor
                              : AppColors.success,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  String _generateInitials(String firstName, String lastName) {
    return firstName.isNotEmpty && lastName.isNotEmpty
        ? '${firstName[0]}${lastName[0]}'
        : '';
  }

  void _showClientDetailsModal(BuildContext context, dynamic client) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      builder: (context) => Wrap(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'First Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('${client['firstName']}'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Last Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('${client['lastName']}'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Email:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('${client['email']}'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Phone:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('${client['phoneNumber']}'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Address:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('${client['address']}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchPhoneCall(client['phoneNumber']);
                      },
                      child: Text('Contact Staff'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch phone call');
    }
  }
}
