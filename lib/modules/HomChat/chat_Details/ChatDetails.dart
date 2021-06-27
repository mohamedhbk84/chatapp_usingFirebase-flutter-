// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newchat/Shared/Style/Icon_Broken.dart';
// import 'package:newchat/Shared/component/componentButton.dart';
// import 'package:newchat/Shared/Style/Icon_Broken.dart';
import 'package:newchat/models/MessageModel.dart';
import 'package:newchat/models/SocialUserModel.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';
// import 'package:newchat/src/pages/index.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatefulWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({
    this.userModel,
  });

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
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
        0, "ChatMe", "1 Message open the message", generalNotificationDetails);
  }

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: widget.userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        widget.userModel.image,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      widget.userModel.name,
                    ),
                  ],
                ),
                actions: [
                  // TextButton(
                  //     onPressed: () {
                  //       // navigateAndFinish(context, IndexPage);
                  //     },
                  //     child: Text(
                  //       "camera",
                  //       style: TextStyle(color: Colors.white),
                  //     ))
                ],
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];

                            if (SocialCubit.get(context).model.uId ==
                                message.senderId)
                              return buildMyMessage(message, index);

                            return buildMessage(message, index);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: widget.userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.clear();
                                  showNotification();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model, index) => Dismissible(
        key: UniqueKey(),

        // only allows the user swipe from right to left
        direction: DismissDirection.endToStart,

        // Remove this product from the list
        // In production enviroment, you may want to send some request to delete it on server side
        onDismissed: (_) {
          setState(() {
            SocialCubit.get(context).messages.removeAt(index);
            // FirebaseFirestore.instance
            //     .collection('users')
            //     .doc(SocialCubit.get(context).model.uId)
            //     .collection('chats')
            //     .doc(widget.userModel.uId)
            //     .collection('messages')
            //     // .doc(SocialCubit.get(context).messages[index].toString())
            //     .delete();

            SocialCubit.get(context).removeMessage(
              receiverId: widget.userModel.uId,
              id: widget.userModel.uId,
            );
          });
        },
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                Text(
                  model.text,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model, index) => Dismissible(
        key: UniqueKey(),

        // only allows the user swipe from right to left
        direction: DismissDirection.endToStart,

        // Remove this product from the list
        // In production enviroment, you may want to send some request to delete it on server side
        onDismissed: (_) {
          setState(() {
            SocialCubit.get(context).messages.removeAt(index);
            SocialCubit.get(context).removeMessage(
              receiverId: widget.userModel.uId,
              id: widget.userModel.uId,
            );
          });
        },
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(
                .2,
              ),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text(
              model.text,
            ),
          ),
        ),
      );
}
