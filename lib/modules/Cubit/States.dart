abstract class AppStates {}

class AppInitionalStates extends AppStates {}

class LoginChangeLockPassword extends AppStates {}

class LoginLoadingStates extends AppStates {}

class LoginScuessStates extends AppStates {
  final String uId;

  LoginScuessStates(this.uId);
}

class LoginErrorStates extends AppStates {
  final String error;

  LoginErrorStates(this.error);
}
