import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/user/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/screens/instructor_detail_screen/instructor_detail_screen_args.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/error_message/error_message.dart';
import 'package:fitness_time/src/ui/widgets/instructor_card_item/instructor_card_item.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorSearchScreen extends StatefulWidget {
  @override
  _InstructorSearchScreenState createState() => _InstructorSearchScreenState();
}

class _InstructorSearchScreenState extends State<InstructorSearchScreen> {
  final FocusNode focusNode = FocusNode();

  UserBloc _userBloc;
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeKeyboard,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 8,
          centerTitle: true,
          title: _buildSearchInput(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: ScreenContainer(
          left: 8,
          right: 8,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildInstructorsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Pesquise instrutores...',
        ),
        autofocus: true,
        onSubmitted: (String searchText) {
          _userBloc.add(
            FetchInstructorsEvent(
              cityCode: _authBloc.user.city.code,
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstructorsList() {
    return BlocBuilder<UserBloc, UserState>(
      cubit: _userBloc,
      builder: (context, state) {
        if (state is IsFetchingInstructorsState) {
          return Center(
            child: DefaultLoader(),
          );
        }

        if (state is FetchInstructorsSuccessState) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(
                height: 16.0,
              ),
              itemBuilder: (BuildContext _, int index) {
                final UserDto instructor = state.instructors[index];

                return InstructorCardItem(
                  instructor: instructor,
                  onTap: () {
                    _closeKeyboard();

                    _navigateToInstructorDetail(instructor);
                  },
                );
              },
              itemCount: state.instructors.length,
            ),
          );
        }

        if (state is FetchInstructorsFailedState) {
          return ErrorMessage(
            message: 'Erro ao carregar instrutores',
            onTryAgain: () {},
          );
        }

        return Container();
      },
    );
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _navigateToInstructorDetail(UserDto instructor) {
    Navigator.of(context).pushNamed(
      RoutesNames.InstructorDetailScreen,
      arguments: InstructorDetailScreenArgs(
        instructor: instructor,
      ),
    );
  }
}
