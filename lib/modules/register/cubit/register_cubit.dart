import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

//   LoginModel? registerModel ;

void userRegister(
  {
    @required String? email,
    @required String? name,
    @required String? phone,
    @required String? password,
})
{
  emit(RegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!)
  .then((value) 
  {
    print('id = ${value.user!.uid}');
    print('email = ${value.user!.email}');
    userCreate(
      uId: value.user!.uid,
      email: email,
      name: name,
      phone: phone
      );
  })
  .catchError((error)
  {
    emit(RegisterErrorState(error.toString()));
  });
}


void userCreate
({
    @required String? uId,
    @required String? email,
    @required String? name,
    @required String? phone,
    @required String? image = 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=826&t=st=1668172524~exp=1668173124~hmac=c9feacee1a78539060605a211cb0f1d14066df91193874814bece357dd9ff5f4',
    @required String? cover = 'https://img.freepik.com/free-photo/beautiful-autumn-leaves-autumn-red-background-sunny-daylight-horizontal_1220-1660.jpg?w=996&t=st=1668172297~exp=1668172897~hmac=53d654625d4c56772a1e052334876c4915959b65a7aaa4219b6c800996cff6af',
    @required String? bio = 'write your bio ...',
})
{
  UserModel model = UserModel(
    uId : uId, 
    name : name, 
    phone : phone, 
    email : email,
    image : image,
    cover : cover,
    bio : bio,
    );
  FirebaseFirestore.instance
  .collection('users')
  .doc(uId)
  .set(model.toMap()).then((value) 
  {
    emit(CreateUserSuccessState(uId!));
  })
  .catchError((error)
  {
    emit(CreateUserErrorState(error.toString()));
  });
}


IconData suffixIcon = Icons.lock_open;
bool isPassword = true;
void changePassword()
{
  isPassword = !isPassword;
  suffixIcon =isPassword ? Icons.lock_open : Icons.lock;
  emit(ChangePasswordRegisterState());
}

}
