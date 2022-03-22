import 'package:flutter/material.dart';

class WhatsAppPreview extends StatelessWidget {
  const WhatsAppPreview({Key? key}) : super(key: key);

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
              horizontal: 10.0,
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
                            Image.network(
                              'https://m.media-amazon.com/images/I/81HHLzHnF0L._SL1500_.jpg',
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
                                  // width: 195.0,
                                  width: _canvas.width * 0.48,
                                  child: const Text(
                                    'Himalaya Ashvagandha',
                                    style: TextStyle(
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
                                    'Get 20% discount on Himalaya Ashvagandha - General Wellness Tablets, 60 Tablets | Stress Relief | Rejuvenates Mind & Body',
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
                        text: const TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text:
                                    'Get 20% Off on Himalaya Ashvagandha on Amazon, Click to BUY from, offer valid till stock lasts. Hurry! '),
                            TextSpan(
                                text: 'https://prmt.com/YXz1365x',
                                style: TextStyle(color: Colors.blue))
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
