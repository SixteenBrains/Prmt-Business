import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prmt_business/models/ad_model.dart';
import '/widgets/error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppPreview extends StatelessWidget {
  final AdModel? ad;
  final Uint8List? previewImg;
  const WhatsAppPreview({
    Key? key,
    required this.ad,
    required this.previewImg,
  }) : super(key: key);

  void _launchURL(BuildContext context, {required String? url}) async {
    if (url == null) {
      return;
    }
    try {
      if (!await launch(url)) throw 'Could not launch ';
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorDialog(content: 'Something went wrong');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: Card(
                elevation: 0.2,
                color: const Color(0XFFDBF7C4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                    vertical: 2.0,
                  ),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0.2,
                        color: const Color(0XFFCEE8B7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              previewImg != null
                                  ? Image.memory(
                                      previewImg!,
                                      height: 90.0,
                                      width: 85.0,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/error-image.png',
                                      height: 90.0,
                                      width: 85.0,
                                      fit: BoxFit.cover,
                                    ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _canvas.width * 0.48,
                                    child: Text(
                                      // 'Himalaya Ashvagandha',
                                      ad?.name ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  SizedBox(
                                    width: _canvas.width * 0.48,
                                    // width: 195.0,
                                    child: Text(
                                      ad?.description ?? 'N/A',
                                      //'Get 20% discount on Himalaya Ashvagandha - General Wellness Tablets, 60 Tablets | Stress Relief | Rejuvenates Mind & Body',
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 8.0,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: ad?.description ?? 'N/A',
                              ),
                              const TextSpan(text: ' '),
                              // text:
                              //     'Get 20% Off on Himalaya Ashvagandha on Amazon, Click to BUY from, offer valid till stock lasts. Hurry! '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      _launchURL(context, url: ad?.targetLink),
                                text: ad?.targetLink ?? 'N/A',
                                //text: 'https://prmt.com/YXz1365x',
                                style: const TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
