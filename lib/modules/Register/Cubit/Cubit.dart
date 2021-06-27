import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/models/SocialUserModel.dart';
import 'package:newchat/modules/Register/Cubit/States.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(AppRegisterInitionalStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  void changeShowPassword() {
    showPassword = !showPassword;
    emit(RegisterChangeShown());
  }

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        uId: value.user.uid,
        phone: phone,
        email: email,
        name: name,
      );
      emit(SocialRegisterScuessStates());
    }).catchError((onError) {
      emit(SocialRegisterErrorStates(onError.toString()));
    });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio ...',
      cover:
          'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      image:
          'https://image.freepik.com/free-photo/bearded-happy-looking-man-with-brunette-hair-has-piercing-wearing-black-sweater-holding-pointing-finger-smartphone-copy-space-isolated-yellow-wall_295783-14549.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialUserScuessStates());
    }).catchError((onError) {
      emit(SocialUserErrorStates(onError.toString()));
    });
  }
}
