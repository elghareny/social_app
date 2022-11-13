import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {


        var cubit = SocialCubit.get(context);
        var userModel = cubit.userModel;

        var namecontroller = TextEditingController();
        var phonecontroller = TextEditingController();
        var biocontroller = TextEditingController();

        namecontroller.text = userModel!.name!;
        phonecontroller.text = userModel.phone!;
        biocontroller.text = userModel.bio!;

        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Edit profile',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            titleSpacing: 5,
            actions: [
              TextButton(
                  onPressed: () 
                  {
                    cubit.updateUser(name: namecontroller.text, phone: phonecontroller.text, bio: biocontroller.text);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is UserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              coverImage == null ? Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          '${userModel.cover}',
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    )),
                              ) :
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(coverImage),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    )),
                              )
                              ,
                              IconButton(onPressed: ()
                            {
                              cubit.getCoverImage();
                            }, 
                            icon: CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.camera_alt_outlined,size: 18,))),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            profileImage == null ? CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage('${userModel.image}') ,
                              ),
                            ) : 
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(profileImage),
                              ),
                            )
                            ,
                            IconButton(onPressed: ()
                            {
                              cubit.getProfileImage();
                            }, 
                            icon: CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.camera_alt_outlined,size: 18,))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(profileImage != null || coverImage != null)
                  Row(
                    children: [
                      if(profileImage != null)
                      Expanded(child: Column(
                        children: [
                          defaultButton(
                            radius: 20,
                            height: 50,
                            text: 'upload profile', 
                            function: ()
                            {
                              cubit.uploadProfileImage(name: namecontroller.text, phone: phonecontroller.text, bio: biocontroller.text);
                            }
                            ),
                            if(state is UserUpdateLoadingState)
                            SizedBox(height: 10,),
                            if(state is UserUpdateLoadingState)
                            LinearProgressIndicator(),
                        ],
                      )),
                        SizedBox(width: 5,),
                        if(coverImage != null)
                      Column(
                        children: [
                          Expanded(child: defaultButton(
                            radius: 20,
                            height: 50,
                            text: 'upload cover', 
                            function: ()
                            {
                              cubit.uploadCoverImage(name: namecontroller.text, phone: phonecontroller.text, bio: biocontroller.text);
                            }
                            )),
                            if(state is UserUpdateLoadingState)
                            SizedBox(height: 5,),
                            if(state is UserUpdateLoadingState)
                            LinearProgressIndicator(),
                        ],
                      ),
                    ],
                  ),
                  if(profileImage != null || coverImage != null)
                  SizedBox(
                    height: 30,
                  ),
                  textField(
                    controller: namecontroller, 
                    type: TextInputType.name,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    }, 
                    text: 'Name', 
                    prefixIcon: Icons.person),
                    SizedBox(
                    height: 20,
                  ),
                  textField(
                    controller: phonecontroller, 
                    type: TextInputType.phone,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    }, 
                    text: 'Phone', 
                    prefixIcon: Icons.phone),
                    SizedBox(
                    height: 20,
                  ),
                  textField(
                    controller: biocontroller, 
                    type: TextInputType.text,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    }, 
                    text: 'Bio', 
                    prefixIcon: Icons.info_outline),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
