import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_time/src/models/city.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/service/setup/setup_service.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

import './bloc.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  List<City> cities = [];
  List<Skill> skills = [];

  final SetupServiceProtocol setupService;

  SetupBloc({
    @required this.setupService,
  }) : super(InitialSetupState());

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(
    SetupEvent event,
  ) async* {
    if (event is LoadCitiesAndSkillsEvent) {
      try {
        yield IsLoadingCitiesAndSkillsState();

        final Tuple2<List<City>, List<Skill>> citiesAndSkills =
            await setupService.loadCitiesAndSkills();

        this.cities = citiesAndSkills.item1;
        this.skills = citiesAndSkills.item2;

        await Future.delayed(Duration(seconds: 1));
        yield LoadCitiesAndSkillsSuccessState(
          cities: citiesAndSkills.item1,
          skills: citiesAndSkills.item2,
        );
      } on Exception catch (e) {
        yield LoadCitiesAndSkillsFailedState();
      }
    }
  }
}
