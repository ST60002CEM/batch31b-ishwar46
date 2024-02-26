import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../config/constants/app_colors.dart';
import '../../domain/events_entity.dart';

class EventView extends ConsumerStatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventViewState();
}

class _EventViewState extends ConsumerState<EventView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ne_NP', null);
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = day;
    });
  }

  void _saveEvent() {
    if (_selectedDay != null) {
      final event = Event(_eventController.text);
      final selectedDate =
          DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
      _events[selectedDate] = (_events[selectedDate] ?? [])..add(event);
      _eventController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whiteText,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Events".toUpperCase(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Event"),
                content: TextField(
                  controller: _eventController,
                  decoration: InputDecoration(hintText: "Enter Event"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      _saveEvent();
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          locale: 'ne_NP',
          rowHeight: 40,
          headerStyle: const HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
            titleCentered: true,
          ),
          startingDayOfWeek: StartingDayOfWeek.sunday,
          selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          eventLoader: (day) => _events[day] ?? [],
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _selectedDay != null
              ? ListView.builder(
                  itemCount: _events[_selectedDay]?.length ?? 0,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(_events[_selectedDay]![index].title),
                  ),
                )
              : const Center(child: Text('No events selected')),
        ),
      ],
    );
  }
}
