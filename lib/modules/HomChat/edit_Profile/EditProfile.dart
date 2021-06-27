import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/Shared/Style/Icon_Broken.dart';
import 'package:newchat/Shared/component/componentButton.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).model;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = userModel.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade200,
              // foregroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                defaultTextButton(
                    function: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    text: "UPDate"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,

                        // alignment: AlignmentDirectional.center,
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
                                  image: coverImage == null
                                      ? NetworkImage("${userModel.cover}")
                                      // 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg')
                                      : FileImage(coverImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Align(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    }),
                              ),
                            ),
                            alignment: AlignmentDirectional.topEnd,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.grey[300],
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage("${userModel.image}")
                                      // "https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg")
                                      : FileImage(profileImage),
                                ),
                              ),
                              CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getProfileImage();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    defaultTextField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "name must not empty";
                        }
                        return null;
                      },
                      label: "name",
                      hint: " Your name",
                      icon: IconBroken.Arrow___Down,
                      isShown: false,
                      istrue: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      context: context,
                      controller: bioController,
                      type: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Bio must not empty";
                        }
                        return null;
                      },
                      label: "Bio",
                      hint: " Enter The Bio ....... ",
                      icon: Icons.biotech,
                      isShown: false,
                      istrue: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      context: context,
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Phone must not empty";
                        }
                        return null;
                      },
                      label: "Phone",
                      hint: " Enter The Phone ",
                      icon: Icons.biotech,
                      isShown: false,
                      istrue: false,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Row(
                          children: [
                            defaultButton(
                                width: MediaQuery.of(context).size.width / 2.5,
                                background: Colors.blue,
                                function: () {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: "UPLoadProfile"),
                            Spacer(),
                            defaultButton(
                                width: MediaQuery.of(context).size.width / 2.5,
                                background: Colors.blue,
                                function: () {
                                  SocialCubit.get(context).updateCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: "UPLoadCover"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
