import 'package:meta/meta.dart';

@immutable
abstract class SetupEvent {}

class LoadCitiesAndSkillsEvent extends SetupEvent {}
