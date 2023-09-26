import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_time/src/enums/user_type.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/registration/registration_service.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;

import './bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  UserDto user = UserDto();

  String choosenName = '';
  UserType userType;
  List<Skill> userSkills;
  File fileImage;

  String userCity;
  final RegistrationServiceProtocol registrationService;

  RegistrationBloc({
    @required this.registrationService,
  }) : super(InitialRegistrationState());

  @override
  RegistrationState get initialState => InitialRegistrationState();

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is SetChoosenNameEvent) {
      choosenName = event.name;
    }

    if (event is SetUserFileImageEvent) {
      fileImage = event.fileImage;
    }

    if (event is SetUserTypeEvent) {
      userType = event.userType;
    }

    if (event is SetUserSkillsEvent) {
      userSkills = event.skills;
    }

    if (event is SetUserCityEvent) {
      userCity = event.city;
    }

    if (event is FinishRegistrationEvent) {
      yield* _handleFinishRegistrationEvent();
    }

    if (event is SetUserDtoEvent) {
      this.user = event.userDto;
    }

    if (event is ValidateEmailEvent) {
      yield* _handleValidateEmailEvent(event);
    }
  }

  Stream<RegistrationState> _handleValidateEmailEvent(
      ValidateEmailEvent event) async* {
    try {
      yield IsValidatingEmailState();

      await registrationService.validateEmail(
        email: event.email,
      );

      yield ValidateEmailSuccess();
    } on Exception catch (e) {
      yield ValidateEmailFailed();
    }
  }

  Stream<RegistrationState> _handleFinishRegistrationEvent() async* {
    try {
      yield IsProcessingRegistrationState();

      await FirebaseAuth.instance.signInAnonymously();

      String photoUrl = await _uploadPhoto();

      await registrationService.registerUser(
        userDto: user..profilePicture = photoUrl,
      );

      AuthResult result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.username,
        password: user.password,
      );

      if (result.user == null) {
        throw Exception();
      }

      yield FinishRegistrationSuccessState();
    } on Exception catch (e) {
      print(e);
      yield FinishRegistrationFailedState();
    }
  }

  Future<String> _uploadPhoto() async {
    if (fileImage == null) {
      return null;
    }
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pics/${Path.basename(fileImage.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(fileImage);
    await uploadTask.onComplete;

    String result = await storageReference.getDownloadURL();

    fileImage.delete(
      recursive: false,
    );

    return result;
  }
}
