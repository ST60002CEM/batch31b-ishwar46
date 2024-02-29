import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../data/model/profile_api_model.dart';
import '../view_model/profile_view_model.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  late final ProfileViewModel _viewModel;
  late final String userId;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(profileViewModelProvider.notifier);
    _initializeData(); // Call _initializeData first
  }

  Future<void> _initializeData() async {
    final token = await _getTokenFromSecureStorage(); // Retrieve token
    final decodedToken = JwtDecoder.decode(token); // Decode token
    userId = decodedToken['id'];

    // Call getProfile with the dynamically obtained userId
    _viewModel.getProfile(userId);
  }

  Future<String> _getTokenFromSecureStorage() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: "authToken") ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final profileState = ref.watch(profileViewModelProvider);
          return profileState.isLoading
              ? Center(child: CircularProgressIndicator())
              : profileState.error?.isNotEmpty == true
                  ? Center(child: Text(profileState.error!))
                  : _buildProfileList(profileState.profile);
        },
      ),
    );
  }

  Widget _buildProfileList(List<ProfileEntity>? profileList) {
    return ListView.builder(
      itemCount: profileList?.length ?? 0,
      itemBuilder: (context, index) {
        final profile = profileList![index];
        return ListTile(
          title: Text('${profile.firstName} ${profile.lastName}'),
          subtitle: Text(profile.email),
        );
      },
    );
  }
}
