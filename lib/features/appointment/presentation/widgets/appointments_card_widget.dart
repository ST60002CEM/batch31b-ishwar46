import 'package:flutter/material.dart';
import '../../../../../config/constants/app_colors.dart';

class AppointmentCard extends StatelessWidget {
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;
  final int status;

  AppointmentCard({
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor();

    return Card(
      color: AppColors.whiteText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8.0,
              height: 100,
              color: statusColor,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Type: $serviceType',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Service Date: $serviceDate',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Start Time: $startTime',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'End Time: $endTime',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Location: $location',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notes: $notes',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _getStatusText(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case 0:
        return AppColors.error; // Cancelled
      case 1:
        return AppColors.success; // Booked
      case 2:
        return AppColors.warning; // Pending
      case 3:
        return AppColors.success; // Completed
      default:
        return AppColors.whiteText;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 0:
        return 'Cancelled';
      case 1:
        return 'Booked';
      case 2:
        return 'Pending';
      case 3:
        return 'Completed';
      default:
        return '';
    }
  }
}
