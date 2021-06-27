// import 'dart:html';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newchat/Network/endPoint.dart';
import 'package:newchat/models/MessageModel.dart';
import 'package:newchat/models/PostsModels.dart';
import 'package:newchat/models/SocialUserModel.dart';
import 'package:newchat/modules/HomChat/Chat/Chat.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';
import 'package:newchat/modules/HomChat/Feeds/Feed.dart';
import 'package:newchat/modules/HomChat/Setting/Setting.dart';
import 'package:newchat/modules/HomChat/new_pos/addPosts.dart';
import 'package:newchat/modules/HomChat/user/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitionalStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel model;
  void getUserData() {
    emit(SocialLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data());
      emit(SocialScuessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialErrorStates(onError.toString()));
    });
  }

  int currentindex = 0;

  List<Widget> screen = [
    FeedScreen(),
    ChatScreen(),
    AddPostsScreen(),
    UserScreen(),
    SettingScreen()
  ];
  List<BottomNavigationBarItem> item = [
    BottomNavigationBarItem(icon: Icon(Icons.flip_sharp), label: "Feeds"),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
    BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Posts"),
    BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_sharp), label: "Users"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUser();
    if (index == 2)
      emit(SocialAddPostStates());
    else {
      currentindex = index;

      emit(ScoialChangeBottomNavStates());
    }
  }

///// Profile Image ///
  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfilesPickedScuessedStates());
    } else {
      print('No image selected.');
      emit(SocialProfilesPickedErrorStates());
    }
  }

  void uploadProfileImage(
      {@required String name, @required String phone, @required String bio}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  ///// Cover Image /////
  // image_picker7901250412914563370.jpg

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void updateCoverImage(
      {@required String name, @required String phone, @required String bio}) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((onError) {
        emit(SocialUpdateCoverImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUpdateCoverErrorState());
    });
  }

//////////////////////

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
    SocialUserModel modelUpdate = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model.email,
      cover: cover ?? model.cover,
      image: image ?? model.image,
      uId: model.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(modelUpdate.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialUpdateUserErrorStates());
    });
  }

  /////// getPostImage //////
  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  ////// delete PostImage ////

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((onError) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    PostsModel postsModel = PostsModel(
      name: model.name,
      image: model.image,
      uId: model.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postsModel.toMap())
        .then((value) {
      emit(SocialaddPostImageScuessStates());
    }).catchError((onError) {
      emit(SocialaddPostImageErrorStates());
    });
  }

  List<PostsModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostsModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> user = [];
  void getUser() {
    if (user.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId)
            user.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel modelll = MessageModel(
      text: text,
      senderId: model.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(modelll.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(modelll.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }

////////// remove message //////

  void removeMessage({
    String receiverId,
    String id,
  }) {
    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc()
        .delete();
    emit(RemoveMessgae());
    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .doc()
        .delete();
    emit(RemoveMessgae());
  }
}
