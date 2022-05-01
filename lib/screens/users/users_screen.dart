import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/users/user_repository.dart';
import '/screens/users/bussiness_list.dart';
import '/screens/users/cubit/users_cubit.dart';
import '/screens/users/promoters_list.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Bussiness Users',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Promoters',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider<UsersCubit>(
              create: (context) => UsersCubit(
                userRepository: context.read<UserRepository>(),
              )..loadBussinessUsers(),
              child: const BussinessList(),
            ),
            BlocProvider<UsersCubit>(
              create: (context) => UsersCubit(
                userRepository: context.read<UserRepository>(),
              )..loadPromoters(),
              child: const PromotersList(),
            ),
          ],
        ),
      ),
    );
  }
}
