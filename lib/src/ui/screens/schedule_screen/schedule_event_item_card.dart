import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleEventItemCard extends StatelessWidget {
  final ScheduleItem scheduleItem;

  ScheduleEventItemCard({
    this.scheduleItem,
  });

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${scheduleItem.hour}:${scheduleItem.minutes}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
//                        _authBloc.user.isInstructor
//                            ? scheduleItem.student.firstName
//                            : scheduleItem.instructor.firstName,
                        '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${scheduleItem.duration} minutos',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Expanded(
                      child: Text(
                        '', //                        scheduleItem.skill?.name ?? 'Sem modalidade',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          DefaultAvatar(
            size: 82.0,
            url: scheduleItem.user.profilePicture,
//            _authBloc.user.isInstructor
//                ? scheduleItem.student.profilePicture
//                : scheduleItem.instructor.profilePicture,
          ),
        ],
      ),
    );
  }
}
