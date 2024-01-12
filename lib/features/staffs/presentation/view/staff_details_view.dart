import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/staff_card.dart';

class StaffDetailsView extends ConsumerStatefulWidget {
  const StaffDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StaffDetailsViewState();
}

class _StaffDetailsViewState extends ConsumerState<StaffDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaffCard(
                staffName: 'Ishwar Chaudhary',
                staffAddress: 'Kathmandu, Nepal',
                routeName: '/staff-details',
                imageUrl:
                    'https://images.unsplash.com/photo-1612833609248-5e9f9d0b1b0f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3RhZmYlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWw',
              ),
              StaffCard(
                staffName: 'John Doe',
                staffAddress: 'Kathmandu, Nepal',
                routeName: '/staff-details',
                imageUrl:
                    'https://images.unsplash.com/photo-1612833609248-5e9f9d0b1b0f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3RhZmYlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWwlMjBzdHVmZiUyMHN0YWZmJTIwZGVzaWduJTIwY29sb3JmdWw',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
