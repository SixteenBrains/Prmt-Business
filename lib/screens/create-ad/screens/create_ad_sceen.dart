import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/screens/create-ad/ad_name.dart';
import 'package:prmt_business/screens/create-ad/ad_type.dart';
import 'package:prmt_business/screens/create-ad/progress_container.dart';
import 'package:prmt_business/widgets/bottom_nav_button.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';

class CreateAdScreen extends StatelessWidget {
  static const String routeName = '/create-ad';
  const CreateAdScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => CreateAdCubit(),
        child: const CreateAdScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAdCubit, CreateAdState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    // AdName(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xffF4F4F9),
                            radius: 25.0,
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xff999999),
                            ),
                          ),
                        ),
                      ],
                    ),

                    CreateAdContents(currentPage: state.currentPage),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CreateAdContents extends StatelessWidget {
  final CurrentPage currentPage;
  const CreateAdContents({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case CurrentPage.adName:
        return const AdName();

      case CurrentPage.adType:
        return const ChooseAdType();

      default:
        return const Scaffold(
          body: Center(
            child: Text(
              'No Page ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
    }
  }
}
