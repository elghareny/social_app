import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin(
  {
    @required String? email,
    @required String? password,
})
{
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!)
  .then((value) 
  {
    print('id = ${value.user!.uid}');
    print('email = ${value.user!.email}');
    emit(LoginSuccessState(value.user!.uid));
  })
  .catchError((error)
  {
    emit(LoginErrorState(error));
  });
}




bool? isPassword =true;
IconData? suffixIcon = Icons.lock_open;

void changePassword()
{
    isPassword = !isPassword!;
    suffixIcon = isPassword! ? Icons.lock_open : Icons.lock;
    emit(ChangePasswordState());
}




}