import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/register/cubit/register_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cachehelper.dart';


class Register extends StatelessWidget {
   Register({Key? key}) : super(key: key);


  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (BuildContext context, state) 
        {
          if(state is RegisterErrorState)
          {
            showToast(state.error, ToastStates.ERROR);
          }
          if(state is CreateUserSuccessState)
        {
          
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) 
          {
            navigatToAndFinish(context, SocialLayout());
            showToast('Registerion success', ToastStates.SUCCESS);
          });
          
        }
        },
        builder: (BuildContext context, state) 
        {
          return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Register',style: TextStyle(
                          fontSize: 50
                        ),),
                        SizedBox(height: 60,),
                        textField(
                          prefixIcon: Icons.person,
                          type: TextInputType.name,
                          controller: nameController, 
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your name';
                            }
                          }, 
                          text: 'Name'),
                           SizedBox(height: 40,),
                        textField(
                          prefixIcon: Icons.email,
                          type: TextInputType.emailAddress,
                          controller: emailController, 
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email';
                            }return null;
                          }, 
                          text: 'Email'),
                          SizedBox(height: 40,),
                        textField(
                          prefixIcon: Icons.password,
                          suffixIcon: RegisterCubit.get(context).suffixIcon,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).changePassword();
                          },
                          type: TextInputType.visiblePassword,
                          controller: passwordController, 
                          onSubmit: (value)
                          {
                          },
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your password';
                            }return null;
                          }, 
                          text: 'Password'),
                          SizedBox(height: 40,),
                          textField(
                          prefixIcon: Icons.phone,
                          type: TextInputType.phone,
                          controller: phoneController, 
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your phone';
                            }return null;
                          }, 
                          text: 'Phone'),
                          SizedBox(height: 50,),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder:(context) => defaultButton(
                              text: 'Register',
                              backcolor: Colors.blue,
                              radius: 20,
                              function: (){
                                if(formkey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                                }
                              },
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
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