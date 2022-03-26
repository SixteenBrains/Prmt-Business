import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import 'blocs/bloc/auth_bloc.dart';
import 'config/auth_wrapper.dart';
import 'config/custom_router.dart';
import 'repositories/auth/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyAog5tvJGNb63Hjbe6TpPVPW_Qp_D9iKRs',
    //     appId: '1:526121573343:web:b0caef970924f065c6c26a',
    //     messagingSenderId: '526121573343',
    //     projectId: 'viewyourstories-4bf4d',
    //     storageBucket: 'viewyourstories-4bf4d.appspot.com',
    //   ),
    // );
  } else {
    await Firebase.initializeApp();
  }

  EquatableConfig.stringify = kDebugMode;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

          /// systemNavigationBarColor: Colors.blue, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark // status bar color
          ),
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          // BlocProvider(
          //   create: (context) => SignUpCubit(),
          // )
        ],
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Helvetica'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
          // debugShowCheckedModeBanner: false,
          // title: 'Flutter Demo',
          // theme: ThemeData(
          //   scaffoldBackgroundColor: Colors.white,
          //   primarySwatch: Colors.blue,
          //   fontFamily: 'GoogleSans',
          // ),
          // home: const SplashScreen(),
          //home: const DashBoard(),
        ),
      ),
    );
  }
}
