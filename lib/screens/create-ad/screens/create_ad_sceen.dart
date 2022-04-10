import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/ad/ad_repository.dart';
import '/screens/create-ad/ad_media.dart';
import '/screens/create-ad/ad_content.dart';
import '/screens/create-ad/ad_created.dart';
import '/screens/create-ad/ad_duration.dart';
import '/screens/create-ad/demographics.dart';
import '/screens/create-ad/target_group.dart';
import '/screens/create-ad/target_link.dart';
import '/screens/create-ad/ad_name.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';

class CreateAdScreen extends StatelessWidget {
  static const String routeName = '/create-ad';
  const CreateAdScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) =>
            CreateAdCubit(adRepository: context.read<AdRepository>()),
        child: const CreateAdScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAdCubit, CreateAdState>(
      listener: (context, state) {
        // if (state.currentPage == AdCurrentPage.demographics) {
        //   context.read<CreateAdCubit>().loadCites();
        // }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            bool canPop = false;
            final _adCubit = context.read<CreateAdCubit>();

            switch (state.currentPage) {
              case AdCurrentPage.adName:
                canPop = true;
                break;

              case AdCurrentPage.adType:
                _adCubit.changePage(AdCurrentPage.adName);
                break;

              case AdCurrentPage.adContent:
                _adCubit.changePage(AdCurrentPage.adType);
                break;

              case AdCurrentPage.adTargetLink:
                _adCubit.changePage(AdCurrentPage.adContent);
                break;

              case AdCurrentPage.date:
                _adCubit.changePage(AdCurrentPage.adTargetLink);
                break;

              case AdCurrentPage.awesome:
                _adCubit.changePage(AdCurrentPage.date);
                break;

              case AdCurrentPage.targetGroup:
                _adCubit.changePage(AdCurrentPage.awesome);
                break;

              case AdCurrentPage.demographics:
                _adCubit.changePage(AdCurrentPage.targetGroup);
                break;
              default:
            }

            return canPop;
          },

          // async => false,
          child: GestureDetector(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final _adCubit = context.read<CreateAdCubit>();

                              switch (state.currentPage) {
                                case AdCurrentPage.adName:
                                  Navigator.of(context).pop();
                                  break;

                                case AdCurrentPage.adType:
                                  _adCubit.changePage(AdCurrentPage.adName);
                                  break;

                                case AdCurrentPage.adContent:
                                  _adCubit.changePage(AdCurrentPage.adType);
                                  break;

                                case AdCurrentPage.adTargetLink:
                                  _adCubit.changePage(AdCurrentPage.adContent);
                                  break;

                                case AdCurrentPage.date:
                                  _adCubit
                                      .changePage(AdCurrentPage.adTargetLink);
                                  break;

                                case AdCurrentPage.awesome:
                                  _adCubit.changePage(AdCurrentPage.date);
                                  break;

                                case AdCurrentPage.targetGroup:
                                  _adCubit.changePage(AdCurrentPage.awesome);
                                  break;

                                case AdCurrentPage.demographics:
                                  _adCubit
                                      .changePage(AdCurrentPage.targetGroup);
                                  break;
                                default:
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffF4F4F9),
                              radius: 25.0,
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xff999999),
                              ),
                            ),
                          ),
                          // if (SharedPrefs().skipAd)
                          //   TextButton(
                          //     onPressed: () async {
                          //       await SharedPrefs().setSkipAd(false);
                          //       Navigator.of(context)
                          //           .pushNamed(DashBoard.routeName);
                          //     },
                          //     child: const Text('Skip Now'),
                          //   )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: CreateAdContents(currentPage: state.currentPage),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CreateAdContents extends StatelessWidget {
  final AdCurrentPage currentPage;
  const CreateAdContents({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case AdCurrentPage.adName:
        return const AdName();

      case AdCurrentPage.adType:
        return const AdMediaType();

      case AdCurrentPage.adContent:
        return const AdContent();

      case AdCurrentPage.adTargetLink:
        return const AdTargetLink();

      case AdCurrentPage.awesome:
        return const AdCreated();

      case AdCurrentPage.date:
        return const AdDuration();

      case AdCurrentPage.demographics:
        return const DemoGraphics();

      case AdCurrentPage.targetGroup:
        return const TargetGroup();

      default:
        return const Scaffold(
          body: Center(
            child: Text(
              'No Page ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
    }
  }
}
