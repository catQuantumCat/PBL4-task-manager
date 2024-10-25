import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return NavigationBar(
          height: kBottomNavigationBarHeight + 16,
          onDestinationSelected: (value) => context
              .read<NavigationBloc>()
              .add(NavigationItemTapped(newIndex: value)),
          selectedIndex: state.index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: "Today",
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.search),
              label: "Search",
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              selectedIcon: Icon(Icons.account_circle),
              label: "Account",
            ),
          ],
        );
      },
    );
  }
}
