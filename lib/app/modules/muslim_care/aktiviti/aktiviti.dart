import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AktivitiHome extends StatefulWidget {
  const AktivitiHome({super.key});

  @override
  State<AktivitiHome> createState() => _AktivitiHomeState();
}

class _AktivitiHomeState extends State<AktivitiHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktiviti Masjid')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTableCalendar() {
  return Container();
  // return TableCalendar(
  //   events: _events,
  //   calendarStyle: CalendarStyle(
  //     todayColor: Colors.orange,
  //     selectedColor: Theme.of(context).primaryColor,
  //     todayStyle: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         fontSize: 18.0,
  //         color: Colors.white
  //     ),
  //   ),
  //   startingDayOfWeek: StartingDayOfWeek.monday,
  //   onDaySelected: (date, events, _){
  //     _onDaySelected(date, events);
  //     _animationController.forward(from: 0.0);
  //   },
  //   onVisibleDaysChanged: (first, last, _) {
  //     print(DateFormat.LLLL().format(first));
  //     print(DateFormat.LLLL().format(last));
  //   },
  //   builders: CalendarBuilders(
  //     selectedDayBuilder: (context, date, events) => Container(
  //       margin: const EdgeInsets.all(4.0),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor,
  //           shape: BoxShape.circle
  //       ),
  //       child: Text(date.day.toString(), style: TextStyle
  //         (color: Colors.white)),
  //     ),
  //     markersBuilder: (context, day, events, _) => events.isNotEmpty
  //         ? <Widget>[
  //       Container(
  //         width: 18,
  //         height: 18,
  //         alignment: Alignment.center,
  //         decoration: const BoxDecoration(
  //           color: Colors.lightBlue,
  //         ),
  //         child: Text(
  //           '${events.length}',
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     ]
  //         : null,
  //   ),
  //   calendarController: _controller,
  // );
}
