import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/appuser.dart';
import '/repositories/services/firebase_services.dart';
import '/widgets/loading_indicator.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _serviceRepo = context.read<FirebaseServices>();
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const Header(),

          Expanded(
            child: FutureBuilder<List<AppUser?>>(
              future: _serviceRepo.getUsers(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Card(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ListTile(
                              title: Text(
                                user?.name ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              subtitle: Text(
                                user?.email ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Text(
                                user?.businessType ?? 'N/A',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          // Spacer(),
        ],
      ),

      ///  ),
    );
  }
}
