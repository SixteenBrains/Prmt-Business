import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/my-ads/my_ads.dart';
import '/screens/notifications/my_notifications.dart';
import '/screens/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300.0,
            width: double.infinity,
            color: const Color(0xffCAF0F8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25.0),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: const [
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/photos/face-of-a-serious-adult-man-in-studio-picture-id1211615197?k=20&m=1211615197&s=612x612&w=0&h=QA3M1TkxP5qXwTtI5Q6aQ53xGPMo3COzNov8P00SHyk='),
                      ),
                      CircleAvatar(
                        radius: 18.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.edit,
                          size: 16.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 22.0),
                  const Text(
                    'Welcome to PRMT, Amolendu',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MyAds(),
                        ),
                      ),
                      child: Container(
                        // height: 90.0,
                        width: _canvas.width * 0.43,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 20.0,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.bullhorn,
                                  size: 20.0,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    'My Ads',
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EditProfile(),
                        ),
                      ),
                      child: Container(
                        // height: 90.0,
                        width: _canvas.width * 0.43,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 20.0,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 22.0,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    'https://media.istockphoto.com/photos/face-of-a-serious-adult-man-in-studio-picture-id1211615197?k=20&m=1211615197&s=612x612&w=0&h=QA3M1TkxP5qXwTtI5Q6aQ53xGPMo3COzNov8P00SHyk='),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'My',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    'Profile',
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MyNotifications())),
                      child: Container(
                        // height: 90.0,
                        width: _canvas.width * 0.43,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 20.0,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.notifications),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'My',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    'Notificaton',
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 90.0,
                      width: _canvas.width * 0.43,
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F4F9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 20.0,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.question,
                                size: 20.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Help &',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  'Support',
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
