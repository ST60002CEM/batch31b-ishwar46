import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
      // background color for task
      color: Colors.purple,
      dateTime: TimePlannerDateTime(day: 0, hour: 6, minutes: 30),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'this is a task',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimePlanner(
        startHour: 6,
        endHour: 23,
        headers: [
          TimePlannerTitle(
            title: "Sunday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Monday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Tuesday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Wednesday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Thursday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Friday",
            date: "03/10/2023",
          ),
          TimePlannerTitle(
            title: "Saturday",
            date: "03/10/2023",
          ),
        ],
        tasks: tasks,
      ),
    );
  }
}
