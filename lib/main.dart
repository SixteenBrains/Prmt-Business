import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/services/firebase_services.dart';
import '/screens/contact/cubit/contact_cubit.dart';
import '/config/custom_router.dart';

import 'screens/contact/contact_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD2FKUw4RTVPVihT30a3DCPZ71eLV_W9a0',
        appId: '1:192154253963:web:aba27a9b8521873c81328e',
        messagingSenderId: '192154253963',
        projectId: 'prmt-97b51',
        storageBucket: 'prmt-97b51.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => FirebaseServices(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ContactCubit(
              firebaseServices: context.read<FirebaseServices>(),
            ),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: ContactScreen.routeName,
          onGenerateRoute: CustomRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
