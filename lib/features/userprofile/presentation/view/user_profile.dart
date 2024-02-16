import 'dart:io';

import 'package:age_care/features/userprofile/presentation/widgets/profile_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  File? _image;

  Future<void> requestPermissions() async {
    // Request camera permission
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    // Request storage permission
    var storageStatus = await Permission.photos.status;
    if (!storageStatus.isGranted) {
      await Permission.photos.request();
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final XFile? photo =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (photo != null) {
                        setState(() {
                          _image = File(photo.path);
                        });
                      }
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      setState(() {
                        _image = File(photo.path);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whiteText,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.userProfilePageTitle.toUpperCase(),
          style: GoogleFonts.montserrat(
            color: AppColors.whiteText,
            fontSize: 15,
            fontWeight: FontWeight.w600,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage("assets/img/user.png") as ImageProvider,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await requestPermissions();
                      await _pickImage();
                    },
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Ishwar Chaudhary',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              'Software Developer',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 20),
            UserDetailsCard(
              fullName: 'Ishwar Chaudhary',
              email: 'ishwar@mail.com',
              phoneNumber: '+977-9812345678',
              address: 'California, USA',
              age: '22',
              username: 'ishwar123',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                EasyLoading.showInfo(
                  "This Feature is not available yet.",
                  duration: Duration(seconds: 2),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
