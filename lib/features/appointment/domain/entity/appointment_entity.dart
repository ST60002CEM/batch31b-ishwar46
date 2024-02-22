class AppointmentEntity {
  final String? appointmentId;
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;
  final String? ticketNumber;
  final String? status;

  AppointmentEntity({
    this.appointmentId,
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
    this.ticketNumber,
    this.status,
  });

  @override
  List<Object?> get props => [
        appointmentId,
        serviceType,
        serviceDate,
        startTime,
        endTime,
        location,
        notes,
        ticketNumber,
        status,
      ];
}
