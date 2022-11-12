import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

 UserModel? userModel;

void getUserData()
{
  emit(SocialGetUserLoadingState());
  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) 
  {
    userModel = UserModel.fromJson(value.data()!);
    emit(SocialGetUserSuccessState());
  }).catchError((error)
  {
    emit(SocialGetUserErrorState(error));
  });
}


File? profileImage;
        var picker = ImagePicker();

        Future <void> getProfileImage()async
        {
          final PickedFile = await picker.pickImage(source: ImageSource.gallery);
          if(PickedFile != null)
          {
            profileImage = File(PickedFile.path);
            emit(ProfileImagePickedSuccessState());
          }else{
            print('no image selected');
            emit(ProfileImagePickedErrorState());
          }
        }


File? coverImage;

        Future <void> getCoverImage()async
        {
          final PickedFile = await picker.pickImage(source: ImageSource.gallery);
          if(PickedFile != null)
          {
            coverImage = File(PickedFile.path);
            emit(CoverImagePickedSuccessState());
          }else{
            print('no image selected');
            emit(CoverImagePickedErrorState());
          }
        }



void uploadProfileImage({
  @required String? name,
  @required String? phone,
  @required String? bio,
})
{
  emit(UserUpdateLoadingState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  .putFile(profileImage!).then((value)
  {
    value.ref.getDownloadURL().then((value) 
    {
      //emit(UploadProfileImageSuccessState());
      updateUser(
        bio: bio,
        name: name,
        phone: phone,
        profile: value
      );
    }).catchError((error)
    {
      emit(UploadProfileImageErrorState());
    });
  }).catchError((error)
  {
    emit(UploadProfileImageErrorState());
  });
}


void uploadCoverImage({
  @required String? name,
  @required String? phone,
  @required String? bio,
})
{
  emit(UserUpdateLoadingState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
  .putFile(coverImage!).then((value)
  {
    value.ref.getDownloadURL().then((value) 
    {
      //emit(UploadCoverImageSuccessState());
      updateUser(
        bio: bio,
        name: name,
        phone: phone,
        cover: value
      );
    }).catchError((error)
    {
      emit(UploadCoverImageErrorState());
    });
  }).catchError((error)
  {
    emit(UploadCoverImageErrorState());
  });
}




// void updateUserImages({
//   @required String? name,
//   @required String? phone,
//   @required String? bio,
// })
// {
//   emit(UserUpdateLoadingState());

//   if(coverImage != null)
//   {
//     uploadCoverImage();
//   }else if(profileImage != null)
//   {
//     uploadProfileImage();
//   }else if(coverImage != null && profileImage != null)
//   {

//   }else
//   {
//     updateUser(name: name, phone: phone, bio: bio);
//   }
// }

void updateUser({
  @required String? name,
  @required String? phone,
  @required String? bio,
  String? profile,
  String? cover,
})
{
  emit(UserUpdateLoadingState());
   UserModel model = UserModel(
    name : name, 
    phone : phone, 
    bio : bio,
    image : profile ?? userModel!.image,
    cover : cover ?? userModel!.cover,
    email : userModel!.email!,
    uId : userModel!.uId!,
    );

  FirebaseFirestore.instance.collection('users').doc(userModel!.uId)
  .update(model.toMap())
  .then((value) 
  {
    getUserData();
  })
  .catchError((error)
  {
    emit(UserUpdateErrorState());
  });
  }
        

}