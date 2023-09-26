import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/state/user/bloc.dart';
import 'package:fitness_time/src/ui/screens/instructor_detail_screen/instructor_detail_screen_args.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/default_button/default_button.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:fitness_time/src/ui/widgets/skill_chip/skill_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorDetailScreen extends StatefulWidget {
  @override
  _InstructorDetailState createState() => _InstructorDetailState();
}

class _InstructorDetailState extends State<InstructorDetailScreen> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userBloc.listen(_listenUserBloc);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScreenContainer(
        top: 0,
        bottom: 8,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  this._instructorDetail(),
                  this._socialNetworks(),
                ],
              ),
            ),
            Text(_instructor.isConnection
                ? 'CONEXAOOO GLOBINHO'
                : 'SEM CONEXAO'),
            _buildConnectButton(),
          ],
        ),
      ),
    );
  }

  Widget _instructorDetail() {
    return Column(
      children: <Widget>[
        this._renderName(),
        SizedBox(
          height: 16.0,
        ),
        Hero(
          tag: 'avatar${_instructor.id}',
          child: DefaultAvatar(
            size: 200,
            borderColor: Colors.grey.shade300,
            borderWidth: 2.5,
            url: _instructor.profilePicture,
          ),
        ),
        this._loadDescription(context),
        SizedBox(
          height: 16.0,
        ),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _instructor.skills
                .map(
                  (e) => SkillChip(
                    text: e.name,
                  ),
                )
                .toList())
      ],
    );
  }

  Widget _socialNetworks() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onLongPress: () {},
                child: Image(
                  image: AssetImage('assets/images/facebook.png'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onLongPress: () {},
                child: Image(
                  image: AssetImage('assets/images/instagram.png'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onLongPress: () {},
                child: Image(
                  image: AssetImage('assets/images/linkedin.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConnectButton() {
    return BlocBuilder<UserBloc, UserState>(
      cubit: _userBloc,
      builder: (context, state) {
        final bool isLoading = state is IsConnectingWithInstructorState;

        return DefaultButton(
          text: 'CONECTAR',
          isLoading: isLoading,
          onTap: _connectWithUser,
        );
      },
    );
  }

  void _connectWithUser() {
    _userBloc.add(
      ConnectWithInstructorEvent(
        userId: _instructor.id.toString(),
      ),
    );
  }

  UserDto get _instructor {
    final args =
        ModalRoute.of(context).settings.arguments as InstructorDetailScreenArgs;

    return args.instructor;
    // return UserDto(
    //     id: 1,
    //     username: "jaspion",
    //     password: "123345",
    //     firstName: "Jaspion",
    //     lastName: "Guerreiro",
    //     description: "There are some descriptions, but this is not the case",
    //     profilePicture:
    //         "https://1.bp.blogspot.com/-u1yYpohjc8Q/Wo2zYtuTaBI/AAAAAAAAMyA/3voleCNPyyc-YkouCN_2vnfoDdkygslkgCLcBGAs/s1600/jaspion.jpg",
    //     city: City(
    //         name: "Parobé", code: "9563000", uf: "RS", zipCode: "95630-000"),
    //     isInstructor: true,
    //     skills: [
    //       Skill(id: 1, name: "Krav Maga"),
    //       Skill(id: 2, name: "Jiu Jitsu"),
    //       Skill(id: 3, name: "Balé"),
    //       Skill(id: 3, name: "Balé"),
    //       Skill(id: 3, name: "Balé"),
    //       Skill(id: 3, name: "Balé"),
    //       Skill(id: 3, name: "Balé"),
    //       Skill(id: 3, name: "Balé"),
    //     ]);
  }

  void _listenUserBloc(UserState state) {
    if (state is ConnectWithInstructorFailedState) {
      showDialog(
        context: context,
        child: MessageDialog(
          title: 'Oops',
          message:
              'Tivemos problemas ao conectar você com ${_instructor.firstName}',
        ),
      );
    }
  }

  Widget _loadDescription(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Text(
        '"${_instructor.description}"',
        textAlign: TextAlign.center,
        maxLines: 3,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  _renderName() {
    return Text(
      _instructor.completeName,
      style: TextStyle(fontSize: 24, shadows: [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black38,
          offset: Offset(2.0, 2.0),
        ),
      ]),
    );
  }
}
