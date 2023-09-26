import 'package:fitness_time/src/models/city.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:fitness_time/src/service/setup/setup_request/setup_request.dart';
import 'package:fitness_time/src/service/setup/setup_response.dart';
import 'package:tuple/tuple.dart';

abstract class SetupServiceProtocol {
  Future<Tuple2<List<City>, List<Skill>>> loadCitiesAndSkills();
}

class SetupService extends BaseService implements SetupServiceProtocol {
  Future<Tuple2<List<City>, List<Skill>>> loadCitiesAndSkills() async {
    final request = SetupRequest();

    final response = await this.execute(request);

    final SetupResponse setupResponse = SetupResponse.fromJson(response.data);

    return Tuple2<List<City>, List<Skill>>(
      setupResponse.cities,
      setupResponse.skills,
    );
  }
}
