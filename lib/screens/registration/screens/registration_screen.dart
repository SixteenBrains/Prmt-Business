import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/registration/widgets/add_business_type.dart';
import '/repositories/registraion/registration_repository.dart';
import '/screens/registration/screens/profile_completed.dart';
import '/screens/registration/widgets/add_business_name.dart';
import '/screens/registration/widgets/add_email.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/screens/registration/widgets/add_name.dart';
import '/widgets/loading_indicator.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration';
  const RegistrationScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<RegistrationCubit>(
        create: (_) => RegistrationCubit(
          registrationRepository: context.read<RegistrationRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..getCurrentUser(),
        child: const RegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state.status == RegistrationStatus.succuss) {
            print('User -- ${state.currentUser}');
            //Navigator.of(context).pushNamed(DashBoard.routeName);
          }
        },
        builder: (context, state) {
          if (state.status == RegistrationStatus.submitting) {
            return const Scaffold(body: LoadingIndicator());
          } else if (state.status == RegistrationStatus.succuss) {
            return const ProfileCompleted();
          }

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (state.currentPage ==
                                RegistrationCurrentPage.businessName) {
                              context
                                  .read<RegistrationCubit>()
                                  .changePage(RegistrationCurrentPage.email);
                            } else if (state.currentPage ==
                                RegistrationCurrentPage.email) {
                              context
                                  .read<RegistrationCubit>()
                                  .changePage(RegistrationCurrentPage.fName);
                            } else if (state.currentPage ==
                                RegistrationCurrentPage.businessType) {
                              context.read<RegistrationCubit>().changePage(
                                  RegistrationCurrentPage.businessName);
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: state.currentPage ==
                                    RegistrationCurrentPage.fName
                                ? Colors.white
                                : const Color(0xffF4F4F9),
                            radius: 25.0,
                            child: Icon(
                              Icons.arrow_back,
                              color: state.currentPage ==
                                      RegistrationCurrentPage.fName
                                  ? Colors.white
                                  : const Color(0xff999999),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _screens(state),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _screens(RegistrationState state) {
    switch (state.currentPage) {
      case RegistrationCurrentPage.fName:
        return const AddName();

      case RegistrationCurrentPage.email:
        return const AddEmail();

      case RegistrationCurrentPage.businessName:
        return const AddBusinessName();

      case RegistrationCurrentPage.businessType:
        return const AddBusinessType();

      default:
        return const Scaffold();
    }
  }
}
