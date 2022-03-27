import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/repositories/auth/auth_wrapper.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/nav/nav_bloc.dart';
import '/repositories/auth/auth_repository.dart';
import '/repositories/services/firebase_services.dart';
import '/screens/contact/cubit/contact_cubit.dart';
import '/config/custom_router.dart';

import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDNSISVIlT_CQttZeymbqSmnDWk5sTRfR8',
        appId: '1:316229040452:web:69e9cbebf0be9c015cbf11',
        messagingSenderId: '316229040452',
        projectId: 'prmt-business',
        storageBucket: 'prmt-business.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);
//#PrmtB2021
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => FirebaseServices(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => ContactCubit(
              firebaseServices: context.read<FirebaseServices>(),
            ),
          ),
          BlocProvider<NavBloc>(
            create: (_) => NavBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PRMT Admin',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          initialRoute: AuthWrapper.routeName,
          onGenerateRoute: CustomRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
