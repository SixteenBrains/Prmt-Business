import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/models/ad_model.dart';

class WhatsAppPreview extends StatelessWidget {
  final AdModel? ad;
  const WhatsAppPreview({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Column(
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
                            ad?.adImage != null
                                ? Image.memory(
                                    ad!.adImage!,
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
                                    ad?.adName ?? 'N/A',
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
                                    ad?.adContent ?? 'N/A',
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
                              text: ad?.adContent ?? 'N/A',
                            ),
                            const TextSpan(text: ' '),
                            // text:
                            //     'Get 20% Off on Himalaya Ashvagandha on Amazon, Click to BUY from, offer valid till stock lasts. Hurry! '),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => print('Tap Here onTap'),
                              text: ad?.adTargetLink ?? 'N/A',
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
    );
  }
}
