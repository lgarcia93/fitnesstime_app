import 'package:fitness_time/src/enums/week_day.dart';
import 'package:fitness_time/src/models/appointment.dart';
import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/user_schedule/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/screens/schedule_screen/schedule_event_item_card.dart';
import 'package:fitness_time/src/ui/widgets/custom_drawer/custom_drawer.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/empty_list_placeholder/empty_list_holder.dart';
import 'package:fitness_time/src/ui/widgets/error_message/error_message.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:fitness_time/src/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OrderMenu { day, week }

extension OrderMenuExtension on OrderMenu {
  String stringify() {
    switch (this) {
      case OrderMenu.day:
        return 'Hoje';
      case OrderMenu.week:
        return 'Semana';
      default:
        return '';
    }
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final FocusNode focusNode = FocusNode();
  OrderMenu dropdownValue = OrderMenu.day;

  UserScheduleBloc _scheduleBloc;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 20), () async {
      _loadScheduleEvents(
        cleanData: true,
      );
      //  await Future.delayed(Duration(milliseconds: 1000));
      _loadPendingScheduleEvents();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scheduleBloc = BlocProvider.of<UserScheduleBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeKeyboard,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'Minha agenda',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        drawer: CustomDrawer(),
        floatingActionButton:
            !_authBloc.user.isInstructor ? _buildFloatingActionButton() : null,
        body: RefreshIndicator(
          child: ScreenContainer(
            child: Column(
              children: <Widget>[
                _buildOptionsMenu(),
                Expanded(
                  child: _buildScheduleEventsList(),
                ),
              ],
            ),
          ),
          onRefresh: () async {
            _loadScheduleEvents();
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (!_authBloc.user.isInstructor) {
      return FloatingActionButton.extended(
        elevation: 4.0,
        shape: StadiumBorder(),
        clipBehavior: Clip.none,
        icon: Icon(Icons.search),
        label: Text('Pesquisar'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: _onSearchPressed,
      );
    }

    return Container();
  }

  void _onSearchPressed() {
    Navigator.of(context).pushNamed(RoutesNames.InstructorSearchScreen);
  }

  Widget _buildOptionsMenu() {
    return Align(
      alignment: Alignment.topLeft,
      child: DropdownButton<OrderMenu>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 8,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        onChanged: (OrderMenu newValue) {
          setState(
            () {
              dropdownValue = newValue;
            },
          );

          _loadScheduleEvents(
            cleanData: true,
          );
        },
        underline: Container(
          width: 0,
        ),
        items: OrderMenu.values.map<DropdownMenuItem<OrderMenu>>(
          (OrderMenu orderMenu) {
            return DropdownMenuItem<OrderMenu>(
              value: orderMenu,
              child: Text(
                orderMenu.stringify(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    color: (orderMenu == this.dropdownValue
                        ? Colors.red
                        : Theme.of(context).primaryColor)),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildScheduleEventsList() {
    return BlocBuilder<UserScheduleBloc, UserScheduleState>(
      cubit: _scheduleBloc,
      buildWhen: (_, UserScheduleState currentState) {
        return currentState is IsFetchingSchedulesState ||
            currentState is FetchWeeklySchedulesSuccessState ||
            currentState is FetchDailySchedulesSuccessState ||
            currentState is FetchSchedulesFailedState;
      },
      builder: (context, state) {
        print(state);
        if (state is IsFetchingSchedulesState) {
          return Center(
            child: DefaultLoader(),
          );
        }

        if (state is FetchWeeklySchedulesSuccessState) {
          if (state.schedules.isEmpty) {
            return ListView(
              children: <Widget>[
                EmptyScheduleListPlaceholder(),
              ],
            );
          }

          return _buildWeeklyView(state.schedules);
        }

        if (state is FetchDailySchedulesSuccessState) {
          if (state.scheduleItems.isEmpty) {
            return ListView(
              children: <Widget>[
                EmptyScheduleListPlaceholder(),
              ],
            );
          }

          return _buildDailyView(state.scheduleItems);
        }

        if (state is FetchSchedulesFailedState) {
          return ListView(
            children: <Widget>[
              ErrorMessage(
                message: 'Erro ao carregar sua agenda',
                onTryAgain: _loadScheduleEvents,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  Widget _buildWeeklyView(List<Schedule> schedules) {
    Map<int, List<ScheduleItem>> scheduleItemsMap = {
      1: <ScheduleItem>[],
      2: <ScheduleItem>[],
      3: <ScheduleItem>[],
      4: <ScheduleItem>[],
      5: <ScheduleItem>[],
      6: <ScheduleItem>[],
      7: <ScheduleItem>[],
    };

    for (Schedule schedule in schedules) {
      for (ScheduleItem scheduleItem in schedule.scheduleItems) {
        scheduleItem.user = schedule.user;

        scheduleItemsMap[scheduleItem.weekDay].add(scheduleItem);
      }
    }

    return ListView.builder(
      itemCount: scheduleItemsMap.keys.length,
      itemBuilder: (_, index) {
        int key = scheduleItemsMap.keys.toList()[index];

        final scheduleItems = scheduleItemsMap[key];
        final String dayOfWeekName =
            DateUtils.beautifyWeekDay(scheduleItemsMap.keys.toList()[index]);

        if (scheduleItems.length < 1) {
          return Container();
        }

        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                dayOfWeekName,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 2.0,
            ),
            ...scheduleItems
                .map(
                  (ScheduleItem item) => ScheduleEventItemCard(
                    scheduleItem: item,
                  ),
                )
                .toList()
          ],
        );
      },
    );

//     return ListView.builder(
//       itemCount: schedules.length,
//       itemBuilder: (ctx, index) {
//         final eventsGroupedByWeekDay = items.values.toList()[index];
//
//         return Column(
//           children: <Widget>[
//             Align(
//               child: Text(
//                 eventsGroupedByWeekDay.item1.beautifyWeekDay,
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
//               ),
//               alignment: Alignment.centerRight,
//             ),
//             Divider(
//               height: 16.0,
//               thickness: 8.0,
//             ),
// //            Column(
// //              children: eventsGroupedByWeekDay.item2.sortedByHour
// //                  .map(
// //                    (ScheduleItem event) =>
// //                        ScheduleEventItemCard(scheduleItem: event),
// //                  )
// //                  .toList(),
// //            ),
//             SizedBox(
//               height: 16.0,
//             )
//           ],
//         );
//       },
//     );
  }

  Widget _buildDailyView(List<ScheduleItem> scheduleItems) {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (ctx, index) {
        final ScheduleItem event = scheduleItems[index];

        return ScheduleEventItemCard(scheduleItem: event);
      },
      itemCount: scheduleItems.length,
    );
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  bool _filter(Appointment appointment) {
    var today = weekDaysNumbers[new DateTime.now().weekday];
    return (appointment.weekDay == today);
  }

  void _loadScheduleEvents({
    bool cleanData = false,
  }) {
    _scheduleBloc.add(FetchSchedules(
      dayOfWeek: dropdownValue == OrderMenu.day ? DateTime.now().weekday : 0,
      cleanData: cleanData,
    ));
  }

  void _loadPendingScheduleEvents() {
    _scheduleBloc.add(FetchPendingScheduleEvent());
  }
}
