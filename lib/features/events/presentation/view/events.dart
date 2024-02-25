import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../config/constants/app_colors.dart';

class EventView extends ConsumerStatefulWidget {
  const EventView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventViewState();
}

class _EventViewState extends ConsumerState<EventView> {
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ne_NP', null);
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
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            locale: 'ne_NP',
            rowHeight: 40,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              titleCentered: true,
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_focusedDay, day);
            },
            availableGestures: AvailableGestures.all,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            onDaySelected: _onDaySelected,
          ),
        )
      ],
    );
  }
}
