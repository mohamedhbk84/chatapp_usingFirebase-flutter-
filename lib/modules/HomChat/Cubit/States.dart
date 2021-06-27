abstract class SocialStates {}

class SocialInitionalStates extends SocialStates {}

class SocialLoadingStates extends SocialStates {}

class SocialScuessStates extends SocialStates {}

class SocialErrorStates extends SocialStates {
  final String error;

  SocialErrorStates(this.error);
}

class ScoialChangeBottomNavStates extends SocialStates {}

class SocialAddPostStates extends SocialStates {}

class SocialProfilesPickedScuessedStates extends SocialStates {}

class SocialProfilesPickedErrorStates extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUploadProfileImageScuessState extends SocialStates {}

class SocialUpdateUserErrorStates extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUpdateLoadingState extends SocialStates {}

class SocialUpdateCoverErrorState extends SocialStates {}

class SocialUpdateCoverImageErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageStates extends SocialStates {}

class SocialaddPostImageScuessStates extends SocialStates {}

class SocialaddPostImageErrorStates extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialGetUsersSuccessState extends SocialStates {}

class SocialGetUsersErrorState extends SocialStates {
  final String error;
  SocialGetUsersErrorState(this.error);
}

class SocialSetChatSuccessState extends SocialStates {}

class SocialSetChatErrorState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class RemoveMessgae extends SocialStates {}
