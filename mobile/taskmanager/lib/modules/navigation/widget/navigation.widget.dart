import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (index) => context
              .read<NavigationBloc>()
              .add(NavigationItemTapped(newIndex: index)),
          currentIndex: state.index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "label"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "label"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "label"),
          ],
        );
      },
    );
  }
}
