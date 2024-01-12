import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../staff_viewmodel/staff_view_model.dart';

class AddStaffView extends ConsumerWidget {
  AddStaffView({Key? key}) : super(key: key);

  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffState = ref.watch(staffViewModelProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Staffs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            gap,
            staffState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: staffState.staffs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            staffState.staffs[index].firstName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            staffState.staffs[index].staffId ?? 'No id',
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 12,
                            ),
                          ),
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
