import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstagramPreview extends StatelessWidget {
  const InstagramPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Image.network(
                  'https://m.media-amazon.com/images/I/81HHLzHnF0L._SL1500_.jpg',
                  height: 240.0,
                  width: 240.0,
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
                        fontSize: 17.0,
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
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.heart,
                                size: 22.0,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 12.0),
                              Icon(
                                FontAwesomeIcons.comment,
                                size: 22.0,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 12.0),
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                size: 22.0,
                                color: Colors.black87,
                              )
                            ],
                          ),
                          const Icon(
                            FontAwesomeIcons.bookmark,
                            size: 22.0,
                            color: Colors.black87,
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        '15,254 likes',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        )
      ],
    );
  }
}
