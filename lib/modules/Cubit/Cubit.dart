import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/modules/Cubit/States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitionalStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool shownPassword = true;
  void changePassword() {
    shownPassword = !shownPassword;
    emit(LoginChangeLockPassword());
  }

  void userLogin({String email, String password}) {
    emit(LoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(LoginScuessStates(value.user.uid));
    }).catchError((onError) {
      emit(LoginErrorStates(onError.toString()));
    });
  }
}
