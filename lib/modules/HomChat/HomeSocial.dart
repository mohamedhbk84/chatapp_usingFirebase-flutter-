// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/Shared/component/componentButton.dart';
// import 'package:newchat/Shared/component/componentButton.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';
import 'package:newchat/modules/HomChat/new_pos/addPosts.dart';

class HomeSocial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostStates) {
          navigateTo(context, AddPostsScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: cubit.screen[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.amber,
              onTap: (value) {
                cubit.changeBottomNav(value);
              },
              items: cubit.item),
        );
      },
    );
  }
}

// ConditionalBuilder(
//               condition: SocialCubit.get(context).model != null,
//               builder: (context) {
//                 var model = FirebaseAuth.instance.currentUser.emailVerified;
//                 return Column(
//                   children: [
//                     if (!model)
//                       Container(
//                         color: Colors.amber.withOpacity(.6),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             children: [
//                               Icon(Icons.info_outline_rounded),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text("Please Verify Your Email "),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               defaultTextButton(
//                                   function: () {
//                                     FirebaseAuth.instance.currentUser
//                                         .sendEmailVerification()
//                                         .then((value) {
//                                       showToast(
//                                           text: "Check Your Mail",
//                                           states: ToastStates.Sucess);
//                                     }).catchError((onError) {
//                                       showToast(
//                                           text: onError.toString(),
//                                           states: ToastStates.Error);
//                                     });
//                                   },
//                                   text: "Send")
//                             ],
//                           ),
//                         ),
//                       )
//                   ],
//                 );
//               },
//               fallback: (context) => Center(child: CircularProgressIndicator()),
//             ));
