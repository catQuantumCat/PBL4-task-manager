import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: context.palette.navigationBarBackground,
              selectedItemColor: context.palette.primaryColor,
              unselectedItemColor: context.palette.normalText,
              iconSize: 28,
              onTap: (value) => context
                  .read<NavigationBloc>()
                  .add(NavigationItemTapped(newIndex: value)),
              elevation: 0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              enableFeedback: true,
              currentIndex: state.index,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today),
                  label: "Today",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month),
                  label: "Upcoming",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  activeIcon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: "Account",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
