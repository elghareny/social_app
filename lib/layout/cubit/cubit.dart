import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
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



////////////////////////////////////////////////////////////////////////////////////////////////////


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
          final PickedFileCover = await picker.pickImage(source: ImageSource.gallery);
          if(PickedFileCover != null)
          {
            coverImage = File(PickedFileCover.path);
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



        
/////////////////////////////////////////////////////////////////////////////////////////////////////////




File? postImage;

        Future <void> getPostImage()async
        {
          final PickedFile = await picker.pickImage(source: ImageSource.gallery);
          if(PickedFile != null)
          {
            postImage = File(PickedFile.path);
            emit(PostImagePickedSuccessState());
          }else{
            print('no image selected');
            emit(PostImagePickedErrorState());
          }
        }


        void removePostImage()
        {
          postImage = null;
          emit(RemovePostImageErrorState());
        }




void uploadPostImage({
  @required String? text,
  @required String? dateTime,
  context
})
{
  emit(CreatePostLoadingState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  .putFile(postImage!).then((value)
  {
    value.ref.getDownloadURL().then((value) 
    {
     createPost(
    text: text, 
     dateTime: dateTime,
     postImage: value
     );
     removePostImage();
     posts = [];
    getPosts();
     Navigator.pop(context);
    }).catchError((error)
    {
      emit(CreatePostErrorState(error.toString()));
    });
  }).catchError((error)
  {
    emit(CreatePostErrorState(error.toString()));
  });
}



void createPost({
  @required String? text,
  @required String? dateTime,
   String? postImage,   
   context,
})
{
  emit(CreatePostLoadingState());
   PostModel model = PostModel(
    name : userModel!.name, 
    image : userModel!.image,
    uId : userModel!.uId!,
    dateTime: dateTime,
    psotImage: postImage ?? '',
    text: text,
    );

  FirebaseFirestore.instance.collection('posts')
  .add(model.toMap())
  .then((value) 
  {
    posts = [];
    getPosts();
    Navigator.pop(context);
    emit(CreatePostSuccessState());
  })
  .catchError((error)
  {
    emit(CreatePostErrorState(error.toString()));
  });
  }



List<PostModel> posts = [];

List<String> postsId = [];

List<int> likes = [];

void getPosts()
{
  FirebaseFirestore.instance.collection('posts')
  .get()
  .then((value) 
  {
    value.docs.forEach((element) {
      element
      .reference
      .collection('likes')
      .get()
      .then((value) 
      {
        likes.add(value.docs.length);
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      })
      .catchError((error){});
    },);
    emit(GetPostsSuccessState());
  }).catchError((error)
  {
    emit(GetPostsErrorState(error.toString()));
  });
}




//////////////////////////////////////////////////////////////////////////////////////////



void likePost(String? postId)
{
  FirebaseFirestore.instance
  .collection('posts')
  .doc(postId)
  .collection('likes')
  .doc(userModel!.uId)
  .set({
    'like':true,
  })
  .then((value) 
  {
    emit(LikePostSuccessState());
  })
  .catchError((error)
  {
    emit(LikePostErrorState(error.toString()));
  });
}


void commentPost(String? postId, String? comment)
{
  FirebaseFirestore.instance
  .collection('posts')
  .doc(postId)
  .collection('comments')
  .doc(userModel!.uId)
  .set({
    'comment':comment,
  })
  .then((value) 
  {
    emit(CommentPostSuccessState());
  })
  .catchError((error)
  {
    emit(CommentPostErrorState(error.toString()));
  });
}




}