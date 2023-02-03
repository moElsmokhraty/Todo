import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/list_provider.dart';

class Calendar extends StatelessWidget {
  Calendar({Key? key}) : super(key: key);

  late ThemingProvider themingProvider;

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    themingProvider = Provider.of(context);
    listProvider = Provider.of(context);
    return TableCalendar(
      onDaySelected: (value, events){
        listProvider.changeDate(value, events);
      },
      daysOfWeekHeight: 40,
      rowHeight: 50,
      headerVisible: false,
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        withinRangeTextStyle: TextStyle(
          color: themingProvider.appTheme == MyTheme.lightMode ? const Color(0xff141922)
          : Colors.white
        ),
        isTodayHighlighted: true,
        defaultDecoration: BoxDecoration(
          color: themingProvider.appTheme == MyTheme.lightMode ? Colors.white
          : const Color(0xff141922),
        ),
        selectedDecoration: const BoxDecoration(
          color: Color(0xff5D9CEC),
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
          decoration: BoxDecoration(
        color: Colors.white,
      )),
      focusedDay: DateTime.now(),
      firstDay: DateTime.now().subtract(const Duration(days: 365)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      currentDay: listProvider.selectedDate,
      startingDayOfWeek: StartingDayOfWeek.sunday,
    );
  }
}
