import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';
import '../../../../core/common/widgets/shimmer_loading_widget.dart';
import '../notification_view_model/notification_view_model.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  final List<String> removedNotifications = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .watch(notificationViewModelProvider.notifier)
          .getNotifications();
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
          AppTexts.notificationPageTitle.toUpperCase(),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(notificationViewModelProvider.notifier)
              .getNotifications();
        },
        child: Consumer(
          builder: (context, watch, child) {
            final state = ref.watch(notificationViewModelProvider);
            if (state.isLoading) {
              return Center(child: ShimmerLoadingEffect());
            } else if (state.error != null) {
              return Center(child: Text(state.error!));
            } else if (state.notifications == null ||
                state.notifications!.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/no_notification.json'),
                      Text(
                        "No notifications available",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: state.notifications!.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications![
                        state.notifications!.length - 1 - index];
                    final formattedDate = notification.createdAtFormatted;

                    if (removedNotifications
                        .contains(notification.notificationId)) {
                      return Container();
                    }
                    return Dismissible(
                      key: ValueKey(notification.notificationId),
                      onDismissed: (_) {
                        removedNotifications.add(notification.notificationId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: notification.read
                              ? Colors.white
                              : Colors.grey[200],
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(
                                  Icons.notifications,
                                  color: AppColors.white,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.error,
                                  radius: 8,
                                  child: Text(
                                    'H',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            notification.message,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.grey[500],
                                size: 12,
                              ),
                              SizedBox(width: 5),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          trailing: notification.read
                              ? null
                              : IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    removedNotifications
                                        .add(notification.notificationId);
                                  },
                                ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
