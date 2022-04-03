import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_admin/screens/ads/cubit/ads_cubit.dart';
import 'package:prmt_admin/widgets/loading_indicator.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AdsStatus.succuss) {
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const Header(),
                //Spacer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.ads.length,
                    // gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 3,
                    // ),
                    itemBuilder: (context, index) {
                      final ad = state.ads[index];
                      print('Ad name ${ad?.name}');
                      return Stack(
                        children: [
                          Card(
                            color: Colors.grey.shade700,
                            child: ListTile(
                              leading: Image.network(
                                ad?.mediaUrl ?? '',
                                height: 100,
                                width: 100,
                              ),
                              title: Text(
                                ad?.name ?? 'N/A',
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ad?.description ?? 'N/A',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                      ad?.targetLink?.substring(0, 50) ?? 'N/A')
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              color: Colors.blue,
                              height: 30.0,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  ad?.author?.name ?? '',
                                ),
                              ),
                            ),
                          )
                        ],
                      );

                      // Card(
                      //   child: Image.network(
                      //     ad?.mediaUrl ?? '',
                      //     height: 100,
                      //     width: 100.0,
                      //     fit: BoxFit.cover,
                      //   ),
                      // );
                    },
                  ),
                )

                // Center(
                //   child: Text(
                //     'Ads',
                //     style: TextStyle(
                //       fontSize: 25.0,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // Spacer(),
              ],
            ),
          );
        }
        return const LoadingIndicator();

        ///  );
      },
    );
  }
}
