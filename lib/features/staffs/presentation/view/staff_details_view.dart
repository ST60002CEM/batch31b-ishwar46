import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../staff_viewmodel/staff_view_model.dart';

class AddStaffView extends ConsumerWidget {
  AddStaffView({Key? key}) : super(key: key);

  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = HelperFunctions.isDarkMode(context);
    final staffState = ref.watch(staffViewModelProvider);
    return Scaffold(
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
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: staffState.staffs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              staffState.staffs[index].image ?? 'N/A',
                            ),
                          ),
                          title: Text(
                            staffState.staffs[index].firstName +
                                ' ' +
                                staffState.staffs[index].lastName,
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 12,
                            ),
                          ),
                          // subtitle: Text(

                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 16,
                          //   ),
                          // ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
