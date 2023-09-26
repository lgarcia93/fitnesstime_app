import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/state/user_schedule/bloc.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/empty_list_placeholder/empty_list_holder.dart';
import 'package:fitness_time/src/ui/widgets/error_message/error_message.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:fitness_time/src/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingScheduleScreen extends StatefulWidget {
  @override
  _PendingScheduleScreenState createState() => _PendingScheduleScreenState();
}

class _PendingScheduleScreenState extends State<PendingScheduleScreen> {
  UserScheduleBloc userScheduleBloc;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 20), () {
      userScheduleBloc.listen(_scheduleBlocListener);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userScheduleBloc = BlocProvider.of<UserScheduleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Solicitações de aula',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ScreenContainer(
        child: RefreshIndicator(
          child: _buildPendingScheduleList(),
          onRefresh: _reloadPendingSchedule,
        ),
      ),
    );
  }

  Widget _buildPendingScheduleList() {
    return BlocBuilder<UserScheduleBloc, UserScheduleState>(
      cubit: userScheduleBloc,
      buildWhen: (_, UserScheduleState currentState) {
        return currentState is IsFetchingPendingSchedulesState ||
            currentState is FetchPendingSchedulesSuccessState ||
            currentState is FetchPendingScheduleEventsFailedState;
      },
      builder: (_, state) {
        print(state);
        if (state is IsFetchingPendingSchedulesState) {
          return Center(
            child: DefaultLoader(),
          );
        }

        if (state is FetchPendingSchedulesSuccessState) {
          if (state.schedules.isEmpty) {
            return EmptyPendingScheduleListPlaceholder();
          } else {
            return _buildPendingScheduleItems(state.schedules);
          }
        }

        if (state is FetchPendingScheduleEventsFailedState) {
          return ErrorMessage(
            message: 'Erro ao carregar suas solicitações',
            onTryAgain: _reloadPendingSchedule,
          );
        }

        return Container();
      },
    );
  }

  Widget _buildPendingScheduleItems(List<Schedule> schedules) {
    return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
        height: 32.0,
      ),
      itemBuilder: (ctx, index) => _buildPendingScheduleItem(
        schedules[index],
      ),
      itemCount: schedules.length,
    );
  }

  Widget _buildPendingScheduleItem(Schedule pendingSchedule) {
    final UserDto student = pendingSchedule.user;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            DefaultAvatar(
              url: student?.profilePicture,
              size: 92.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${pendingSchedule.user?.firstName} ${pendingSchedule.user?.lastName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: pendingSchedule.scheduleItems?.map(
                          (e) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${DateUtils.beautifyWeekDay(e.weekDay)}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '${e.hour}:${e.minutes}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                        ) ??
                        <Widget>[].toList(),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                          child: Text('Aceitar'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            _onAcceptSchedule(pendingSchedule.id);
                          }),
                      RaisedButton(
                          child: Text('Rejeitar'),
                          onPressed: () {
                            _onRejectSchedule(pendingSchedule.id);
                          })
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void _onAcceptSchedule(int scheduleId) {
    userScheduleBloc.add(
      AcceptOrRejectScheduleEvent(
        scheduleId: scheduleId,
        accepted: true,
      ),
    );
  }

  void _onRejectSchedule(int scheduleId) {
    userScheduleBloc.add(AcceptOrRejectScheduleEvent(
      scheduleId: scheduleId,
      accepted: false,
    ));
  }

  Future<void> _reloadPendingSchedule() {
    return Future.delayed(Duration(milliseconds: 1));
  }

  void _scheduleBlocListener(UserScheduleState state) {
    if (state is AcceptOrRejectScheduleSuccessState) {
      userScheduleBloc.add(FetchPendingScheduleEvent());
    }
  }
}
