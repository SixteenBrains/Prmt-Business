import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookPreview extends StatelessWidget {
  const FacebookPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _canvas = MediaQuery.of(context).size;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          'https://i.pinimg.com/originals/39/44/6c/39446caa52f53369b92bc97253d2b2f1.png',
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
    );
  }
}
