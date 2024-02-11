class AppointmentEntity {
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;

  AppointmentEntity({
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        serviceType,
        serviceDate,
        startTime,
        endTime,
        location,
        notes,
      ];
}
