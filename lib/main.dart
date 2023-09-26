import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_time/src/service/auth/auth_service.dart';
import 'package:fitness_time/src/service/registration/registration_service.dart';
import 'package:fitness_time/src/service/schedule/schedule_service.dart';
import 'package:fitness_time/src/service/setup/setup_service.dart';
import 'package:fitness_time/src/service/user/user_service.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/state/setup/bloc.dart';
import 'package:fitness_time/src/state/user/bloc.dart';
import 'package:fitness_time/src/state/user_schedule/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/themes/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(
      FitnessTimeApp(),
    );

const String package_name = 'fitness_time';

class FitnessTimeApp extends StatefulWidget {
  @override
  _FitnessTimeAppState createState() => _FitnessTimeAppState();
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class _FitnessTimeAppState extends State<FitnessTimeApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: primaryColor,
        /* set Status bar color in Android devices. */

        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/

        statusBarBrightness: Brightness.dark,
      ), /* set Status bar icon color in iOS. */
    );

    Future.delayed(Duration(seconds: 1), () async {
      final token = await firebaseMessaging.getToken();

      print("token firebase");
      print(token);
    });

    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegistrationBloc(
            registrationService: RegistrationService(),
          ),
        ),
        BlocProvider(
          create: (_) => AuthBloc(
            authService: AuthService(),
            userService: UserService(),
          ),
        ),
        BlocProvider(
          create: (_) => SetupBloc(
            setupService: SetupService(),
          ),
        ),
        BlocProvider(
          create: (_) => UserBloc(
            userService: UserService(),
          ),
        ),
        BlocProvider(
          create: (_) => UserScheduleBloc(
            scheduleService: ScheduleService(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: defaultTheme,
        routes: routes,
        initialRoute: RoutesNames.LaunchScreen,
      ),
    );
  }
}
