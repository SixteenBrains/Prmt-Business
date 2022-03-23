import 'package:flutter/material.dart';
import 'package:prmt_business/widgets/display_image.dart';

class MyNotifications extends StatelessWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey,
          size: 25.0,
        ),
        title: const Text('My Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: const [
            NotificationCard(
              imageUrl:
                  'https://images-us.nivea.com/-/media/local/in/boday_page/3_banner_3080x806.png?rx=1304&ry=0&rw=1452&rh=805',
              time: '1 day ago',
              title: 'Only 3 conversion left to complete Your daily budget',
            ),
            SizedBox(height: 5.0),
            NotificationCard(
              imageUrl:
                  'https://m.media-amazon.com/images/I/81HHLzHnF0L._SL1500_.jpg',
              time: '1 day ago',
              title: 'You have got 43 click on Himalaya Ashvagandha ad',
            )
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;

  const NotificationCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: DisplayImage(
                imageUrl: imageUrl,
                height: 55.0,
                width: 55.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _canvas.width * 0.6,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
