import 'package:flutter/material.dart';

import 'logic.dart';

// TO DO: needs name of month and borders around calendar, fix grabbing of image
// Shows the showering calendar
class ShowerCalendar extends StatelessWidget {
  final UserData data;

  const ShowerCalendar({Key? key, required this.data}) : super(key: key);

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
    final List<Widget> dayOffset = List.generate(3, (index) {
      // hard-coded for February
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

    final List<Widget> calendarGridCells = List.generate(
      28,
      <Widget>(index) {
        final firstDayOfMonth = DateTime(2023, 2, 1);
        Image img;
        // add index to first day
        if (data.today().isBefore(firstDayOfMonth.add(Duration(days: index)))) {
          img = Image.asset("assets/empty.PNG", height: 200); // empty if past today, no data would exist
        } else if (data.didShowerOnDay(firstDayOfMonth.add(Duration(days: index)))) {
          img = Image.asset("assets/anteater0.PNG", height: 200);
        } else {
          img = Image.asset("assets/anteater6.PNG", height: 200);
        }
        return Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                (index + 1).toString(), // indexing starts at 0
                textAlign: TextAlign.left,
              ),
            ),
            img,
          ],
        );
      },
    );

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Generate 28 widgets that display the corresponding anteater from that day
      children: (daysList + dayOffset + calendarGridCells)
          .map((w) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: w,
              ))
          .toList(),
    );
  }
}
