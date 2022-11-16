abstract class SocialStates{}

class SocialInitialState extends SocialStates{}


class ChangePasswordState extends SocialStates{}

class ChangeNavBarState extends SocialStates{}

class NewPostState extends SocialStates{}

class ProfileImagePickedSuccessState extends SocialStates{}
class ProfileImagePickedErrorState extends SocialStates{}

class UploadProfileImageSuccessState extends SocialStates{}
class UploadProfileImageErrorState extends SocialStates{}

class CoverImagePickedSuccessState extends SocialStates{}
class CoverImagePickedErrorState extends SocialStates{}

class UploadCoverImageSuccessState extends SocialStates{}
class UploadCoverImageErrorState extends SocialStates{}


class UserUpdateLoadingState extends SocialStates{}
class UserUpdateErrorState extends SocialStates{}


class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates
{
  // final String uId;

  // SocialGetUserSuccessState(this.uId);
}
class SocialGetUserErrorState extends SocialStates
{
  final String? error;

  SocialGetUserErrorState(this.error);
}



class CreatePostLoadingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class CreatePostErrorState extends SocialStates
{
  final String? error;

  CreatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends SocialStates{}
class PostImagePickedErrorState extends SocialStates{}

class RemovePostImageErrorState extends SocialStates{}




class GetPostsLoadingState extends SocialStates{}
class GetPostsSuccessState extends SocialStates{}
class GetPostsErrorState extends SocialStates
{
  final String? error;

  GetPostsErrorState(this.error);
}


class LikePostSuccessState extends SocialStates{}
class LikePostErrorState extends SocialStates
{
  final String? error;

  LikePostErrorState(this.error);
}


class CommentPostSuccessState extends SocialStates{}
class CommentPostErrorState extends SocialStates
{
  final String? error;

  CommentPostErrorState(this.error);
}



class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates
{
  final String? error;

  SocialGetAllUsersErrorState(this.error);
}




class SendMessageSuccessState extends SocialStates{}
class SendMessageErrorState extends SocialStates{}

class GetMessageSuccessState extends SocialStates{}
class GetMessageErrorState extends SocialStates{}









class LogoutSuccessState extends SocialStates{}
class LogoutErrorState extends SocialStates
{
  final String? error;

  LogoutErrorState(this.error);
}
