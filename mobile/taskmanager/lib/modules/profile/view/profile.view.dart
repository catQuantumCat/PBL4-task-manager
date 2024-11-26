import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/profile/bloc/profile_bloc.dart';

import 'package:taskmanager/modules/profile/widget/profile_success.widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(userRepository: getIt<UserRepository>()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == StateStatus.failed) {
            {
              showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              context
                                  .read<ProfileBloc>()
                                  .add(const ProfileOpen());
                            },
                            child: const Text("Try again"))
                      ],
                      title: const Text("Cannot proceed"),
                      content:
                          Text(state.errorMessage ?? "Something went wrong!"),
                    );
                  });
              return;
            }
          }
        },
        child: const ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTitleAppbar(
      titleBackgroundColor: context.palette.scaffoldBackgroundDim,
      title: "Account",
      child: Container(
        color: context.palette.scaffoldBackgroundDim,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state.status) {
              case StateStatus.success:
                return ProfileSuccessWidget(state: state);
              case StateStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case StateStatus.failed:
              case StateStatus.initial:
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
