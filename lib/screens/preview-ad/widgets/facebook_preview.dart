import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prmt_business/models/ad_model.dart';
import '/widgets/error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookPreview extends StatelessWidget {
  final AdModel? ad;
  final Uint8List? previewImg;
  const FacebookPreview({Key? key, required this.ad, required this.previewImg})
      : super(key: key);

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
    // final _canvas = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  previewImg != null
                      ? Image.memory(
                          previewImg!,
                          // height: 240.0,
                          // width: 240.0,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          'assets/images/error-image.png',
                          // height: 240.0,
                          // width: 240.0,
                          fit: BoxFit.contain,
                        ),
                  // Image.network(
                  //   'https://m.media-amazon.com/images/I/81HHLzHnF0L._SL1500_.jpg',
                  //   height: 240.0,
                  //   width: 240.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 8.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ad?.description ?? 'N/A',
                          ), // 'Get 20% Off on Himalaya Ashvagandha on Amazon, Click to BUY from, offer valid till stock lasts. Hurry! '),

                          const TextSpan(text: ' '),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/like-thumb.png',
                            height: 20.0,
                            width: 20.0,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '84',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '3 shares',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(),
                  const SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            FontAwesomeIcons.thumbsUp,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            'Like',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 5.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            'Comment',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 5.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            FontAwesomeIcons.share,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
