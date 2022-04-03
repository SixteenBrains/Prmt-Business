import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/dashboard/dashboard.dart';
import '/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ad/ad_repository.dart';
import '/screens/preview-ad/cubit/preview_ad_cubit.dart';
import '/widgets/error_dialog.dart';
import '/models/ad_model.dart';
import '/screens/payment/payment_screen.dart';
import '/widgets/bottom_nav_button.dart';
import 'widgets/facebook_preview.dart';
import 'widgets/instagram_preview.dart';
import 'widgets/whatsapp_preview.dart';

class PreviewAdArgs {
  final AdModel? adModel;

  PreviewAdArgs({required this.adModel});
}

class PreviewAdScreen extends StatelessWidget {
  static const String routeName = '/preview-ad';

  const PreviewAdScreen({
    Key? key,
  }) : super(key: key);

  static Route route({required PreviewAdArgs args}) => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => BlocProvider(
          create: (context) => PreviewAdCubit(
            adModel: args.adModel,
            adRepository: context.read<AdRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..loadPreviewAd(),
          child: const PreviewAdScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // print('Ad Mode - $adModel');
    return BlocConsumer<PreviewAdCubit, PreviewAdState>(
      listener: (context, state) {
        if (state.status == PreviewAdStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
        if (state.status == PreviewAdStatus.succuss) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(DashBoard.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        if (state.status == PreviewAdStatus.loading) {
          return const Scaffold(body: LoadingIndicator());
        }
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: const Color(0XFFF5F5F5),
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey.shade600),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              bottom: const TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                indicatorWeight: 1.2,
                tabs: [
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.whatsappSquare,
                      size: 35.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.facebookSquare,
                      size: 35.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
              title: const Text('Preview Ad'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 12.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        WhatsAppPreview(ad: state.ad),
                        FacebookPreview(ad: state.ad),
                        InstagramPreview(ad: state.ad),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(true),
                        child: Container(
                          height: 40.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Edit Ad',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<PreviewAdCubit>().draftAd(),
                        child: Container(
                          height: 40.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Save as Draft',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  BottomNavButton(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PaymentScreen(),
                      ),
                    ),
                    label: 'PROCEED TO PAYMENT',
                    isEnabled: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
