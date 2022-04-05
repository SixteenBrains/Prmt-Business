import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:prmt_business/utils/media_util.dart';
import 'package:prmt_business/widgets/display_image.dart';
import 'package:prmt_business/widgets/loading_indicator.dart';
import 'package:prmt_business/widgets/show_snackbar.dart';
import '/repositories/profile/profile_repo.dart';
import '/screens/profile/cubit/profile_cubit.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/my-ads/my_ads.dart';
import '/screens/notifications/my_notifications.dart';
import '/screens/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(
          profileRepository: context.read<ProfileRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..loadProfile(),
        child: const ProfileScreen(),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await MediaUtil.pickImageFromGallery(
      cropStyle: CropStyle.circle,
      context: context,
      imageQuality: 60,
      title: 'Crop and resize',
    );
    if (pickedImage != null) {
      context.read<ProfileCubit>().imagePicked(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.imgUploaded) {
            ShowSnackBar.showSnackBar(context, title: 'Pofile image updated');
          }
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const LoadingIndicator();
          }
          return Column(
            children: [
              Container(
                height: 310.0,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context
                                .read<AuthBloc>()
                                .add(AuthLogoutRequested()),
                            icon: const Icon(Icons.logout),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70.0,
                            child: ClipOval(
                              child: state.imageFile == null
                                  ? DisplayImage(
                                      imageUrl: state.user?.profileImg,
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    )
                                  : Image.file(
                                      state.imageFile!,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickImage(context),
                            child: const CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.edit,
                                size: 16.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 22.0),
                      SizedBox(
                        height: 30.0,
                        child: Text(
                          'Welcome to PRMT, ${state.user?.name ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    ),
                    //const Spacer(),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('Logout'),
                    // ),
                    // const SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
