import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/auth/auth_event.dart';
import 'package:fitness_time/src/state/auth/auth_state.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authBloc.listen(_authBlocListener);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  Widget get _divider {
    return Divider(
      color: Colors.white.withOpacity(0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _divider,
              Expanded(
                child: _buildOptions(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get optionsTextStyle => TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      );

  Widget _buildOptions() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            'Minhas aulas',
            style: optionsTextStyle,
          ),
        ),
        ListTile(
          title: Text(
            'Meus contatos',
            style: optionsTextStyle,
          ),
        ),
        ListTile(
          title: Text(
            'Histórico',
            style: optionsTextStyle,
          ),
        ),
        if (authBloc.user.isInstructor)
          ListTile(
            title: Text(
              'Solicitações de aula',
              style: optionsTextStyle,
            ),
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(RoutesNames.PendingScheduleScreen);
            },
          ),
        ListTile(
          title: Text(
            'Sair',
            style: optionsTextStyle,
          ),
          onTap: _logout,
        ),
      ],
    );
  }

  void _logout() {
    authBloc.add(SignOutEvent());
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 250,
      child: DrawerHeader(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DefaultAvatar(
              url: authBloc.user.profilePicture,
            ),
            _buildName(),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        '${authBloc.user.firstName} ${authBloc.user.lastName}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TextField(
        controller: TextEditingController(text: ''),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }

  void _authBlocListener(AuthState state) {
    if (state is SignOutSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesNames.WelcomeScreen,
        (Route<dynamic> route) => false,
      );
    }

    if (state is SignOutFailed) {
      showDialog(
        context: context,
        builder: (_) => MessageDialog(
          title: 'Oops',
          message: 'Tivemos um problema ao encerrar sua sessão.',
        ),
      );
    }
  }
}
