import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/card_event.dart';
import 'package:sporth/widgets/card_publicacion.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  dynamic _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Text(
              '${formatIntToMonth(_focusedDay.month)} ${_focusedDay.year}',
              style: TextUtils.kanitItalic_24_black,
            ),
            const SizedBox(height: 20.0),
            TableCalendar(
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              availableGestures: AvailableGestures.horizontalSwipe,
              eventLoader: (day) {
                if (day.day == DateTime.now().day) {
                  return ['Dia X'];
                }
                return [];
              },
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextUtils.kanit_18_black,
              ),
              headerVisible: false,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                leftChevronVisible: false,
                rightChevronVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  formatIntToMonth(int month) {
    switch (month) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
    }
  }
}
