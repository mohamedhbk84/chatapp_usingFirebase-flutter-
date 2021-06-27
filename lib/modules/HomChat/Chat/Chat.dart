import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/Shared/component/componentButton.dart';
import 'package:newchat/models/SocialUserModel.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';
import 'package:newchat/modules/HomChat/chat_Details/ChatDetails.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).user.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).user[index], context),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: SocialCubit.get(context).user.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
}
