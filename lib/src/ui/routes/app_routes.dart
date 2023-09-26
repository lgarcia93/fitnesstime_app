import 'package:fitness_time/src/ui/screens/instructor_detail_screen/instructor_detail_screen.dart';
import 'package:fitness_time/src/ui/screens/instructor_search_screen/instructor_search_screen.dart';
import 'package:fitness_time/src/ui/screens/launch_screen/launch_screen.dart';
import 'package:fitness_time/src/ui/screens/login_loading_screen/login_loading_screen.dart';
import 'package:fitness_time/src/ui/screens/login_screen/login_screen.dart';
import 'package:fitness_time/src/ui/screens/pending_schedule_screen/pending_schedule_screen.dart';
import 'package:fitness_time/src/ui/screens/registration_form_screen/registration_form_screen.dart';
import 'package:fitness_time/src/ui/screens/registration_profile_edition/registration_profile_edition.dart';
import 'package:fitness_time/src/ui/screens/registration_step_one_screen/registration_step_one_screen.dart';
import 'package:fitness_time/src/ui/screens/registration_step_three_screen/registration_step_three_screen.dart';
import 'package:fitness_time/src/ui/screens/registration_step_two_screen/registration_step_two_screen.dart';
import 'package:fitness_time/src/ui/screens/schedule_lesson_screen/schedule_lesson_screen.dart';
import 'package:fitness_time/src/ui/screens/schedule_screen/schedule_screen.dart';
import 'package:fitness_time/src/ui/screens/welcome_screen/welcome_screen.dart';

class RoutesNames {
  static const InstructorSearchScreen = 'instructor_search_screen';
  static const WelcomeScreen = 'welcome_screen';
  static const RegistrationStepOneScreen = 'registration_step_one_screen';
  static const RegistrationStepTwoScreen = 'registration_step_two_screen';
  static const RegistrationStepThreeScreen = 'registration_step_three_screen';
  static const ScheduleLessonScreen = 'schedule_lesson_screen';
  static const InstructorDetailScreen = 'instructor_detail_screen';
  static const AppointmentsScreen = 'appointment_screen';
  static const LaunchScreen = 'launch_screen';
  static const LoginScreen = 'login_screen';
  static const RegistrationFormScreen = 'registration_form_screen';
  static const RegistrationProfileEditionScreen =
      'registration_profile_edition_screen';
  static const LoginLoadingScreen = 'login_loading_screen';
  static const PendingScheduleScreen = 'pending_schedule_screen';
}

var routes = {
  RoutesNames.InstructorSearchScreen: (context) => InstructorSearchScreen(),
  RoutesNames.WelcomeScreen: (context) => WelcomeScreen(),
  RoutesNames.RegistrationStepOneScreen: (context) =>
      RegistrationStepOneScreen(),
  RoutesNames.RegistrationStepTwoScreen: (context) =>
      RegistrationStepTwoScreen(),
  RoutesNames.RegistrationStepThreeScreen: (context) =>
      RegistrationStepThreeScreen(),
  RoutesNames.ScheduleLessonScreen: (context) => ScheduleLessonScreen(),
  RoutesNames.InstructorDetailScreen: (context) => InstructorDetailScreen(),
  RoutesNames.AppointmentsScreen: (context) => ScheduleScreen(),
  RoutesNames.LaunchScreen: (context) => LaunchScreen(),
  RoutesNames.LoginScreen: (context) => LoginScreen(),
  RoutesNames.RegistrationFormScreen: (context) => RegistrationFormScreen(),
  RoutesNames.RegistrationProfileEditionScreen: (context) =>
      RegistrationProfileEditionScreen(),
  RoutesNames.LoginLoadingScreen: (context) => LoginLoadingScreen(),
  RoutesNames.PendingScheduleScreen: (context) => PendingScheduleScreen(),
};
