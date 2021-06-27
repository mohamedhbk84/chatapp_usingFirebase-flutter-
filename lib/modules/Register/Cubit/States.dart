abstract class RegisterStates {}

class AppRegisterInitionalStates extends RegisterStates {}

class RegisterChangeShown extends RegisterStates {}

class SocialRegisterLoadingStates extends RegisterStates {}

class SocialRegisterScuessStates extends RegisterStates {}

class SocialRegisterErrorStates extends RegisterStates {
  final String error;

  SocialRegisterErrorStates(this.error);
}

class SocialUserScuessStates extends RegisterStates {}

class SocialUserErrorStates extends RegisterStates {
  final String error;

  SocialUserErrorStates(this.error);
}
