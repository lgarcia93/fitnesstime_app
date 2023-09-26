import 'package:fitness_time/src/models/city.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SetupState {}

class InitialSetupState extends SetupState {}

class IsLoadingCitiesAndSkillsState extends SetupState {}

class LoadCitiesAndSkillsSuccessState extends SetupState {
  final List<City> cities;
  final List<Skill> skills;

  LoadCitiesAndSkillsSuccessState({
    this.cities,
    this.skills,
  });
}

class LoadCitiesAndSkillsFailedState extends SetupState {}
