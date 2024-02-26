import 'package:flutter/material.dart';
import '../../../../../config/constants/app_colors.dart';

class AppointmentCard extends StatefulWidget {
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;
  final String? status;
  final String? ticketnumber;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final bool isAdmin;

  AppointmentCard({
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
    this.status,
    this.ticketnumber,
    required this.onDelete,
    this.onEdit,
    required this.isAdmin,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox gap = SizedBox(height: 8.0);
    Color statusColor = _getStatusColor();
    String statusText = _getStatusText();

    return GestureDetector(
      onTap: _showModalSheet,
      child: Card(
        surfaceTintColor: AppColors.whiteText,
        color: AppColors.whiteText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: statusColor, width: 2.0),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusIndicator(statusColor),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppointmentDetails(gap, statusText),
                      if (widget.isAdmin) _buildEditButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(Color statusColor) {
    return Container(
      width: 5.0,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  Widget _buildAppointmentDetails(SizedBox gap, String statusText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 72, 81, 90),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${widget.ticketnumber}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: AppColors.whiteText,
                ),
              ),
            ),
            if (widget.isAdmin)
              IconButton(
                onPressed: widget.onDelete,
                icon: Icon(Icons.delete, color: AppColors.error),
              ),
          ],
        ),
        gap,
        _buildDetailRow(
            'Service Type:', widget.serviceType, AppColors.primaryColor),
        gap,
        _buildDetailRow(
            'Service Date:', widget.serviceDate, AppColors.primaryColor),
        gap,
        _buildDetailRow(
            'Start Time:', widget.startTime, AppColors.primaryColor),
        gap,
        _buildDetailRow('End Time:', widget.endTime, AppColors.primaryColor),
        gap,
        _buildDetailRow('Location:', widget.location, AppColors.primaryColor),
        gap,
        Text(
          'Status: $statusText',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getStatusColor()),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, Color valueColor) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        Spacer(),
        Text(value, style: TextStyle(fontSize: 12, color: valueColor)),
      ],
    );
  }

  Widget _buildEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: widget.onEdit,
          child: Icon(Icons.edit),
        ),
      ],
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildModalContent(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildModalContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Notes: ${widget.notes}', style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case 'cancelled':
        return AppColors.error; // Cancelled
      case 'booked':
        return AppColors.success; // Booked
      case 'pending':
        return AppColors.warning; // Pending
      case 'completed':
        return AppColors.info; // Completed
      default:
        return AppColors.grey; // Default color for unknown status
    }
  }

  String _getStatusText() {
    switch (widget.status) {
      case 'cancelled':
        return 'Cancelled';
      case 'booked':
        return 'Booked';
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
