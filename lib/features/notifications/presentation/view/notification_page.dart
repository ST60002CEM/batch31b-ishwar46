import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notification_view_model/notification_view_model.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(notificationViewModelProvider);
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text(state.error!));
          } else if (state.notifications == null ||
              state.notifications!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          } else {
            return ListView.builder(
              itemCount: state.notifications!.length,
              itemBuilder: (context, index) {
                final notification = state.notifications![index];
                return ListTile(
                  title: Text(notification.message),
                  subtitle: Text(notification.createdAt.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
