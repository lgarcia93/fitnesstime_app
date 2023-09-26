import 'package:fitness_time/src/models/appointment.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:flutter/material.dart';

abstract class AppointmentsServiceProtocol {
  Future<List<Appointment>> fetchAppointmentsWithInstructor({
    @required UserDto instructor,
  });
}

class AppointmentsService extends BaseService
    implements AppointmentsServiceProtocol {
  Future<List<Appointment>> fetchAppointmentsWithInstructor({
    @required UserDto instructor,
  }) async {
    return [];
  }
}
