import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(title: 'Flutter Calender App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Two params defined
  final DateTime startDate = DateTime(2023, 1, 1);
  final DateTime endDate = DateTime(2025, 12, 31);

  //focused Day selected according to the static UI Image
  DateTime focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: SizedBox(
            width: 400,
            child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.0, // X direction
                  vertical: 20.0, // Y direction
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Text(
                            '${DateFormat.MMMM().format(focusedDay)}, ${focusedDay.year}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              final previousMonth = DateTime(
                                focusedDay.year,
                                focusedDay.month - 1,
                              );
                              if (!previousMonth.isBefore(startDate)) {
                                setState(() {
                                  focusedDay = previousMonth;
                                  _selectedDay=focusedDay;
                                });
                              }
                            },
                          ),
                        ),
            
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              final nextMonth = DateTime(
                                focusedDay.year,
                                focusedDay.month + 1,
                              );
                              if (!nextMonth.isAfter(endDate)) {
                                setState(() {
                                  focusedDay = nextMonth;
                                  _selectedDay=focusedDay;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('MON'),
                          Text('TUE'),
                          Text('WED'),
                          Text('THU'),
                          Text('FRI'),
                          Text('SAT'),
                          Text('SUN'),
                        ],
                      ),
                    ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(4),
                    child:TableCalendar(
                      focusedDay: focusedDay,
                      firstDay: startDate,
                      lastDay: endDate,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, _) {
                        setState(() {
                          _selectedDay = selectedDay;
                          focusedDay = selectedDay;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.deepOrange,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarBuilders: CalendarBuilders(
                        // dowBuilder: (context, day) {
                        //   final days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
                        //   final weekday = day.weekday % 7;
                        //   return Center(
                        //     child: Text(
                        //       days[weekday],
                        //       style: const TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   );
                        // },
            
                        //to color first time rendering
                        defaultBuilder: (context, day, _) {
                          // if (isSameDay(day, focusedDay) &&
                          //     !isSameDay(day, _selectedDay)) {
                          //   return Container(
                          //     margin: const EdgeInsets.all(6),
                          //     decoration: BoxDecoration(
                          //       color: Colors.deepOrange,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       '${day.day}',
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 16,
                          //       ),
                          //     ),
                          //   );
                          // }
                          return null;
                        },
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
