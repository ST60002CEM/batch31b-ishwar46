import 'package:flutter/material.dart';
import '../../../../../config/constants/app_colors.dart';

class AppointmentCard extends StatefulWidget {
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
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool isModalSheetVisible = false;

  @override
  Widget build(BuildContext context) {
    void _showModalSheet() {
      showModalBottomSheet(
          enableDrag: true,
          showDragHandle: false,
          transitionAnimationController: AnimationController(
            vsync: Navigator.of(context),
            duration: Duration(milliseconds: 500),
          ),
          context: context,
          builder: (builder) {
            return Container(
              height: 300,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteText,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        widget.notes,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Cancel Appointment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    SizedBox gap = SizedBox(height: 5.0);
    Color statusColor = _getStatusColor();

    return GestureDetector(
      onTap: () {
        _showModalSheet();
      },
      child: Card(
        surfaceTintColor: AppColors.whiteText,
        color: AppColors.whiteText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: statusColor,
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8.0,
                height: 110,
                color: statusColor,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Service Type:',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        widget.serviceType,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryColor),
                      ),
                    ]),
                    gap,
                    Row(
                      children: [
                        Text(
                          'Service Date:',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          widget.serviceDate,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    gap,
                    Row(
                      children: [
                        Text(
                          'Start Time:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                        Spacer(),
                        Text(
                          widget.startTime,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.success),
                        ),
                      ],
                    ),
                    gap,
                    Row(
                      children: [
                        Text(
                          'End Time:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.endTime,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.error),
                        ),
                      ],
                    ),
                    gap,
                    Row(
                      children: [
                        Text(
                          'Location:',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          widget.location,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    gap,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.status) {
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
    switch (widget.status) {
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
