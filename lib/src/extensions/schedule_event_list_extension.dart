import 'package:fitness_time/src/models/schedule_item.dart';

extension ScheduleEventListExtension on List<ScheduleItem> {
  List<ScheduleItem> get sortedByWeekDay {
    this.sort((event1, event2) {
      final int event1Day =
          event1.weekDay; //DateUtils.weekDayFromString(event1.weekDay);
      final int event2Day =
          event2.weekDay; // DateUtils.weekDayFromString(event2.weekDay);

      if (event1Day > event2Day) {
        return 1;
      } else {
        return -1;
      }
    });

    return this;
  }

  List<ScheduleItem> get sortedByHour {
    this.sort((event1, event2) {
      final int event1Hour = event1.hour;
      final int event2Hour = event2.hour;
      final int event1Minutes = event1.minutes;
      final int event2Minutes = event2.minutes;

      if (event1Hour == event2Hour) {
        if (event1Minutes > event2Minutes) {
          return 1;
        } else {
          return -1;
        }
      }

      if (event1Hour > event2Hour) {
        return 1;
      } else {
        return -1;
      }
    });

    return this;
  }
}
