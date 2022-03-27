import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/show_snackbar.dart';
import '/config/responsive.dart';
import '/widgets/custom_text_field.dart';
import '/repositories/auth/auth_repository.dart';
import '/widgets/error_dialog.dart';
import '/widgets/loading_indicator.dart';
import '/constants/constants.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().signInWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: bgColor,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.error) {
                showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(
                    content: state.failure.message,
                  ),
                );
              } else if (state.status == LoginStatus.succuss) {
                ShowSnackbar.succussMessage(context,
                    title: 'Login Succussfull');
              }
            },
            builder: (context, state) {
              if (state.status == LoginStatus.submitting) {
                return const LoadingIndicator();
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Responsive.isMobile(context) ||
                              Responsive.isTablet(context)
                          ? _canvas.width - 25.0
                          : _canvas.width * 0.5,
                      child: Card(
                        color: Colors.white,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 25.0,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/admin.svg',
                                  height: 60.0,
                                  width: 60.0,
                                  //  color: Colors.blue,
                                ),
                                const SizedBox(height: 10.0),
                                const Text(
                                  'PRMT',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                CustomTextField(
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                                  validator: (value) =>
                                      !(value!.contains('@prmt.com'))
                                          ? 'Invalid Email'
                                          : null,
                                  hintText: 'Email',
                                  prefixIcon: Icons.mail,
                                ),
                                CustomTextField(
                                  textInputType: TextInputType.visiblePassword,
                                  isPassowrdField: !state.showPassword,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value!.length < 6
                                      ? 'Password too short'
                                      : null,
                                  suffixIcon: IconButton(
                                      color: Colors.white,
                                      icon: Icon(
                                        state.showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<LoginCubit>()
                                            .showPassword(state.showPassword);
                                      }),
                                  prefixIcon: Icons.lock,
                                  hintText: 'Password',
                                ),
                                const SizedBox(height: 30.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor),
                                  onPressed: () => _submitForm(context,
                                      state.status == LoginStatus.submitting),
                                  child: const Padding(
                                    padding: EdgeInsets.all(11.5),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
