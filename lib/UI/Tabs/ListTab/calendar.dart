import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/list_provider.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    TodosProvider listProvider = Provider.of(context);
    return TableCalendar(
      onDaySelected: (value, events) {
        listProvider.changeCalendarDate(value, events);
      },
      locale: Localizations.localeOf(context).toString(),
      daysOfWeekHeight: 40,
      rowHeight: 50,
      headerVisible: false,
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        withinRangeTextStyle: TextStyle(
          color: themingProvider.appTheme == MyTheme.lightMode
              ? Colors.blue
              : Colors.white,
        ),
        isTodayHighlighted: true,
        todayTextStyle: TextStyle(
          color: themingProvider.appTheme == MyTheme.lightMode
              ? Colors.white
              : Colors.black,
        ),
        weekendTextStyle: const TextStyle(
          color: Colors.white,
        ),
        weekendDecoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.rectangle,
        ),
        todayDecoration: BoxDecoration(
          color: themingProvider.appTheme == MyTheme.lightMode
              ? const Color(0xff5D9CEC)
              : Colors.white,
          shape: BoxShape.rectangle,
        ),
        withinRangeDecoration: BoxDecoration(
          color: themingProvider.appTheme == MyTheme.lightMode
              ? const Color(0xff5D9CEC)
              : Colors.white,
          shape: BoxShape.rectangle,
        ),
        defaultDecoration: BoxDecoration(
          color: themingProvider.appTheme == MyTheme.lightMode
              ? Colors.white
              : Colors.grey[800],
        ),
        selectedDecoration: const BoxDecoration(
          color: Color(0xff5D9CEC),
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      focusedDay: DateTime.now(),
      firstDay: DateTime.now().subtract(const Duration(days: 365)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      currentDay: listProvider.calendarDate,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      weekendDays: const [],
    );
  }
}
