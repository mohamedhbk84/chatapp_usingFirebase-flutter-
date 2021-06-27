import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newchat/Shared/Style/Icon_Broken.dart';

import 'package:newchat/Shared/component/componentButton.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';
import 'package:newchat/modules/HomChat/edit_Profile/EditProfile.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  FlutterLocalNotificationsPlugin localNotifications;

  @override
  void initState() {
    super.initState();
    var androidInitialize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitalialize = new IOSInitializationSettings();
    var initalialiazationSettings = InitializationSettings(
        android: androidInitialize, iOS: iosInitalialize);
    localNotifications = new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initalialiazationSettings);
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails("channelId",
        "Local Notification", "this is description of notification",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.show(
        0, "ChatMe", "unSubscribe", generalNotificationDetails);
  }

  Future showNotification1() async {
    var androidDetails = new AndroidNotificationDetails("channelId",
        "Local Notification", "this is description of notification",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.show(
        0, "ChatMe", "Subscribe", generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).model;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            width: double.infinity,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  4.0,
                                ),
                                topRight: Radius.circular(
                                  4.0,
                                ),
                              ),
                              image: DecorationImage(
                                image: NetworkImage("${userModel.cover}"
                                    // 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
                                    ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blueAccent,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage("${userModel.image}"
                                // 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9.0,
                  ),
                  Text(
                    '${userModel.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${userModel.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 9.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '265',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photos',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(
                            context,
                            EditProfile(),
                          );
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // ignore: deprecated_member_use
                      OutlineButton(
                        onPressed: () {
                          showNotification1();

                          FirebaseMessaging.instance
                              .subscribeToTopic('announcment');
                        },
                        child: Text(
                          "SubScribe",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      Spacer(),
                      // ignore: deprecated_member_use
                      OutlineButton(
                        onPressed: () {
                          showNotification();

                          FirebaseMessaging.instance
                              .unsubscribeFromTopic('announcment');
                        },
                        child: Text(
                          "UnSubScribe",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
