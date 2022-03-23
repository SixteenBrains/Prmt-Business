import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import 'screens/dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          fontFamily: 'GoogleSans',
        ),
        //home: const SplashScreen(),
        home: const DashBoard(),
      ),
    );
  }
}
