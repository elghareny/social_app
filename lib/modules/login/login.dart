import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cachehelper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) 
        {
          if(state is LoginErrorState)
          {
            showToast(state.error, ToastStates.ERROR);
          }
          else if(state is LoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId', 
              value: state.uId).then((value) 
              {
                navigatToAndFinish(context, SocialLayout());
              });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        textField(
                          controller: emailController,
                          text: 'Email',
                          prefixIcon: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        textField(
                          controller: passwordController,
                          text: 'Password',
                          prefixIcon: Icons.password,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword!,
                          suffixIcon: cubit.suffixIcon,
                          suffixPressed: () 
                          {
                            cubit.changePassword();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                              text: 'Login',
                              backcolor: Colors.blue,
                              radius: 20,
                              function: () 
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userLogin(
                                    email: emailController.text, 
                                    password: passwordController.text);
                                }
                              }),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                                onPressed: () 
                                {
                                  navigatTo(context, Register());
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 20),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
