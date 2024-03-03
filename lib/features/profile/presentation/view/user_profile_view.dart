import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_sizes.dart';
import '../../../../core/common/widgets/user_profile_shimmer.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../view_model/profile_view_model.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(profileViewModelProvider.notifier).getProfile();
      confettiController.play();

      Future.delayed(const Duration(seconds: 1), () {
        confettiController.stop();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        title: Text(
          "Profile".toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            color: AppColors.whiteText,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(profileViewModelProvider);
          if (state.isLoading) {
            return Center(child: UserProfileShimmer());
          } else if (state.error != null) {
            return Center(child: Text(state.error!));
          } else if (state.users == null || state.users!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            final user = state.users!.first;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      maxBlastForce: 10,
                      minBlastForce: 2,
                      emissionFrequency: 0.05,
                      numberOfParticles: 10,
                      gravity: 1,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage:
                              NetworkImage(user.image ?? 'assets/img/user.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _showImagePickerModal(context);
                            },
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: isDarkMode
                                  ? AppColors.darkModeOnPrimary
                                  : AppColors.primaryColor,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Center(
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? AppColors.whiteText : AppColors.black,
                      ),
                    ),
                  ),
                  if (user.isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Icon(
                          Icons.verified_user,
                          color: AppColors.accentColor,
                          size: 24.0,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  _buildDetailRow(Icons.email, 'Email', user.email, isDarkMode),
                  _buildDivider(),
                  _buildDetailRow(
                      Icons.location_on, 'Address', user.address, isDarkMode),
                  _buildDivider(),
                  _buildDetailRow(Icons.phone, 'Phone', user.phone, isDarkMode),
                  _buildDivider(),
                  _buildDetailRow(Icons.verified_user_rounded, 'Username',
                      user.username, isDarkMode),
                  const SizedBox(height: 32.0),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? AppColors.darkModeOnPrimary
                              : AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {},
                        icon: Icon(Iconsax.edit, size: 20.0),
                        label: Text('Edit Profile'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String title, String text, bool isDarkMode) {
    Color textColor = isDarkMode
        ? AppColors.whiteText
        : HelperFunctions.isDarkMode(context)
            ? AppColors.primaryColor
            : AppColors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20.0),
            const SizedBox(width: 12.0),
            Text(title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                )),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 15,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: 1.0,
      color: AppColors.grey,
    );
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                pickedFile != null
                    ? EasyLoading.showSuccess('Image selected')
                    : EasyLoading.showError('No image selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                pickedFile != null
                    ? EasyLoading.showSuccess('Image selected')
                    : EasyLoading.showError('No image selected');
              },
            ),
          ],
        );
      },
    );
  }
}
