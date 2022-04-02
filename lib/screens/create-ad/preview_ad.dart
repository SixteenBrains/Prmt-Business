import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prmt_business/models/ad_model.dart';
import '/screens/payment/payment_screen.dart';
import '/widgets/bottom_nav_button.dart';
import '/screens/create-ad/widgets/whatsapp_preview.dart';
import 'widgets/facebook_preview.dart';
import 'widgets/instagram_preview.dart';

class PreviewAdArgs {
  final AdModel? adModel;

  PreviewAdArgs({required this.adModel});
}

class PreviewAd extends StatelessWidget {
  static const String routeName = '/preview-ad';
  final AdModel? adModel;
  const PreviewAd({
    Key? key,
    required this.adModel,
  }) : super(key: key);

  static Route route({required PreviewAdArgs args}) => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => PreviewAd(adModel: args.adModel),
      );

  @override
  Widget build(BuildContext context) {
    print('Ad Mode - $adModel');
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
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              const Expanded(
                child: TabBarView(
                  children: [
                    WhatsAppPreview(),
                    FacebookPreview(),
                    InstagramPreview(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
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
                    onTap: () {},
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
  }
}
