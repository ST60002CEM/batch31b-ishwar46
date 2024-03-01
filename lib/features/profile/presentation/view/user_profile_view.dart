import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_sizes.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 18,
              color: AppColors.whiteText,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(profileViewModelProvider);
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
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
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage:
                          NetworkImage(user.image ?? 'assets/img/user.png'),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Center(
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  if (user.isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Icon(
                          Icons.verified_user,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  _buildDetailRow(Icons.email, 'Email', user.email),
                  _buildDivider(),
                  _buildDetailRow(Icons.location_on, 'Address', user.address),
                  _buildDivider(),
                  _buildDetailRow(Icons.phone, 'Phone', user.phone),
                  _buildDivider(),
                  _buildDetailRow(
                      Icons.verified_user_rounded, 'Username', user.username),
                  const SizedBox(height: 32.0),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
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

  Widget _buildDetailRow(IconData icon, String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20.0),
            const SizedBox(width: 12.0),
            Text(
              title,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 15,
              color: AppColors.black,
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
}
