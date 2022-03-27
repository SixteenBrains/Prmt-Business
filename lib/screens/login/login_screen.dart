import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black54,
        //statusBarColor: Color.fromRGBO(25, 23, 37, 1),
        // statusBarColor: Color(0XFF00286E),
        //  statusBarColor: Color.fromRGBO(0, 141, 82, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black54,
              //   backgroundColor: Color.fromRGBO(29, 38, 40, 1),
              body: state.status == LoginStatus.submitting
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: LoadingIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: height < 750 ? 15.0 : 12.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 22.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                                  validator: (value) =>
                                      !(value!.contains('@prmt.com'))
                                          ? 'Invalid Email'
                                          : null,
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                    hintText: 'Enter Your Email',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  obscureText: !state.showPassword,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value!.length < 6
                                      ? 'Password too short'
                                      : null,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat'),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.white),
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
                                      },
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    labelText: 'PASSWORD',
                                    hintText: 'Enter Your Password',
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                const SizedBox(height: 40.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                  ),
                                  onPressed: () => _submitForm(context,
                                      state.status == LoginStatus.submitting),
                                  child: const Padding(
                                    padding: EdgeInsets.all(11.5),
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black,
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
                          const SizedBox(height: 25.0),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
