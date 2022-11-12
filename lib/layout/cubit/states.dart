abstract class SocialStates{}

class SocialInitialState extends SocialStates{}


class ChangePasswordState extends SocialStates{}

class ChangeNavBarState extends SocialStates{}

class NewPostState extends SocialStates{}


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