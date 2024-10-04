import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/modules/home/view/list/home_list.view.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';
import 'package:taskmanager/modules/navigation/widget/navigation.widget.dart';
import 'package:taskmanager/modules/profile/view/profile.view.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: const NavigationView(),
    );
  }
}

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const NavigationWidget(),
          body: <Widget>[
            const HomeListPage(),
            const ProfilePage(),
            const HomeListPage()
          ][state.index],
        );
      },
    );
  }
}
