import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../staff_viewmodel/staff_view_model.dart';
import 'package:shimmer/shimmer.dart';

class AddStaffView extends ConsumerStatefulWidget {
  AddStaffView({Key? key}) : super(key: key);

  @override
  _AddStaffViewState createState() => _AddStaffViewState();
}

class _AddStaffViewState extends ConsumerState<AddStaffView> {
  final ScrollController _scrollController = ScrollController();
  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final staffState = ref.watch(staffViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0 &&
              !staffState.isLoading &&
              !staffState.hasReachedMax) {
            ref.read(staffViewModelProvider.notifier).getAllStaff();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: AppColors.whiteText,
          backgroundColor: AppColors.primaryColor,
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              staffState.isLoading
                  ? Center(child: ShimmerLoadingEffect())
                  : staffState.staffs.isEmpty
                      ? const Center(child: Text("No data available"))
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await ref
                                  .read(staffViewModelProvider.notifier)
                                  .resetState();
                              EasyLoading.showSuccess(
                                  AppTexts.refreshedSuccessfully.toUpperCase());
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: staffState.hasReachedMax
                                  ? staffState.staffs.length
                                  : staffState.staffs.length + 1,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index < staffState.staffs.length) {
                                  List<Color> cardColors = [
                                    AppColors.primaryColor,
                                    AppColors.secondaryColor
                                  ];
                                  return Card(
                                    color: cardColors[index % 2],
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          // backgroundImage: NetworkImage(
                                          //   //staffState.staffs[index].avatar,
                                          // ),
                                          ),
                                      title: Text(
                                        staffState.staffs[index].firstName +
                                            ' ' +
                                            staffState.staffs[index].lastName,
                                        style: TextStyle(
                                          color: dark
                                              ? AppColors.black
                                              : AppColors.white,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          gap,
                                          Text(
                                            staffState.staffs[index].email,
                                            style: TextStyle(
                                              color: dark
                                                  ? AppColors.black
                                                  : AppColors.white,
                                            ),
                                          ),
                                          Text(
                                            staffState.staffs[index].address,
                                            style: TextStyle(
                                              color: dark
                                                  ? AppColors.black
                                                  : AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   AppRoutes.bookAppointment,
                                          //   arguments: staffState.staffs[index],
                                          // );
                                        },
                                        child: Text(
                                          AppTexts.bootAppointment,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          elevation: 5,
                                          // shadowColor: Colors.black26,
                                          splashFactory:
                                              InkRipple.splashFactory,
                                          backgroundColor: AppColors.success,
                                          foregroundColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Loading indicator for additional data
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ShimmerLoadingEffect() {
  return Column(
    children: List.generate(
      8,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 150,
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 6),
              ),
              Container(
                height: 12,
                width: 200,
                color: Colors.white,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Container(
                height: 12,
                width: 180,
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 6),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
