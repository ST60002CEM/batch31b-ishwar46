import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/profile_view_model.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(profileViewModelProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer(builder: (context, watch, child) {
        final state = ref.watch(profileViewModelProvider);
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isLoading) {
          return Center(
              child: Text(state.error ?? 'An unexpected error occurred'));
        } else if (state.users == null) {
          return const Center(child: Text('No users found'));
        } else {
          return ListView.builder(
            itemCount: state.users?.length,
            itemBuilder: (context, index) {
              final user = state.users![index];
              return ListTile(
                title: Text(user.firstName + ' ' + user.lastName),
                subtitle: Text(user.email),
              );
            },
          );
        }
      }),
    );
  }
}
