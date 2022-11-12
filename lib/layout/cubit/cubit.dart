import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);


  int? currentIndex = 0;

  List<Widget> homeScreens = 
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = 
  [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void ChangeNavBar(int? index)
  {
    
    if(index == 2 )
      emit(NewPostState());
    else
    {
      currentIndex = index ;
      emit(ChangeNavBarState());
    }
     
  }

UserModel? model;

void getUserModel()
{
  emit(SocialGetUserLoadingState());
  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) 
  {
    model = UserModel.fromJson(value.data()!);
    emit(SocialGetUserSuccessState());
  }).catchError((error)
  {
    emit(SocialGetUserErrorState(error));
  });
}

}