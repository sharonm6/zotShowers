import 'package:flutter/material.dart';

import 'logic.dart';

const MONTH_NAMES = ['JANUARY', 'FEBRUARY', 'MARCH', "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];

// Shows the showering calendar
class ShowerCalendar extends StatelessWidget {
  final UserData data;

  const ShowerCalendar({Key? key, required this.data}) : super(key: key);

  int daysInCurrentMonth() {
    final start = firstDayOfCurrMonth();
    return DateTimeRange(start: start, end: DateTime(start.year, start.month + 1)).duration.inDays;
  }

  DateTime firstDayOfCurrMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final days = <String>["Su", "M", "T", "W", "Th", "F", "S"];
    // generate widget list of all days of the week
    final List<Widget> daysList = List.generate(7, (index) {
      return Center(
          child: Text(
        // can't render text, has to be a widget
        days[index],
        textAlign: TextAlign.center,
      ));
    });
    final List<Widget> dayOffset = List.generate(firstDayOfCurrMonth().weekday % 7, (index) {
      return const Center(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "", // don't fill in dates of previous month
            textAlign: TextAlign.left,
          ),
        ),
      );
    });

    final List<Widget> calendarGridCells = List.generate(daysInCurrentMonth(), <Widget>(index) {
      final firstDayOfMonth = firstDayOfCurrMonth();
      Image img;
      Color background;
      // add index to first day
      if (data.today().isBefore(firstDayOfMonth.add(Duration(days: index)))) {
        img = Image.asset("assets/empty.png", height: 200); // empty if past today, no data would exist
        background = Colors.transparent;
      } else if (data.didShowerOnDay(firstDayOfMonth.add(Duration(days: index)))) {
        img = Image.asset("assets/anteater0.png", height: 200);
        background = Colors.green.withOpacity(0.2);
      } else {
        img = Image.asset("assets/anteater6.png", height: 200);
        background = Colors.red.withOpacity(0.2);
      }

      return Container(
        color: background,
        child: Stack(
          children: [
            Positioned(
              left: 4,
              top: 4,
              child: Text(
                (index + 1).toString(), // indexing starts at 0
                textAlign: TextAlign.left,
              ),
            ),
            img,
          ],
        ),
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Center(
          child: Text(
            "Your Shower Month",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          MONTH_NAMES[firstDayOfCurrMonth().month - 1],
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 8),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Generate # of days in month widgets that display the corresponding anteater from each day
          children: (daysList + dayOffset + calendarGridCells)
              .map((w) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: w,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
