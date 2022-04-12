import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_admin/config/responsive.dart';
import '/enums/enums.dart';
import '/screens/ads/cubit/ads_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/show_media.dart';
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
                  child: GridView.builder(
                    itemCount: state.ads.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                      // mainAxisExtent: 1.2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final ad = state.ads[index];
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ShowMedia(
                                  mediaUrl: ad?.mediaUrl,
                                  mediaType: ad?.adType ?? MediaType.none,
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  ad?.title ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  ad?.description ?? '',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  //  ListView.builder(
                  //   itemCount: state.ads.length,
                  //   // gridDelegate:
                  //   //     const SliverGridDelegateWithFixedCrossAxisCount(
                  //   //   crossAxisCount: 3,
                  //   // ),
                  //   itemBuilder: (context, index) {
                  //     final ad = state.ads[index];
                  //     print('Ad name ${ad?.title}');
                  //     return Stack(
                  //       children: [
                  //         Card(
                  //           color: Colors.grey.shade700,
                  //           child: ListTile(
                  //             leading: Image.network(
                  //               ad?.mediaUrl ?? '',
                  //               height: 100,
                  //               width: 100,
                  //             ),
                  //             title: Text(
                  //               ad?.title ?? 'N/A',
                  //               style: const TextStyle(
                  //                   fontSize: 16.0, color: Colors.white),
                  //             ),
                  //             subtitle: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   ad?.description ?? 'N/A',
                  //                   style: const TextStyle(
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                     ad?.targetLink?.substring(0, 50) ?? 'N/A')
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Align(
                  //           alignment: Alignment.topRight,
                  //           child: Container(
                  //             color: Colors.blue,
                  //             height: 30.0,
                  //             width: 100.0,
                  //             child: Center(
                  //               child: Text(
                  //                 ad?.author?.name ?? '',
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     );

                  //     // Card(
                  //     //   child: Image.network(
                  //     //     ad?.mediaUrl ?? '',
                  //     //     height: 100,
                  //     //     width: 100.0,
                  //     //     fit: BoxFit.cover,
                  //     //   ),
                  //     // );
                  //   },
                  // ),
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
