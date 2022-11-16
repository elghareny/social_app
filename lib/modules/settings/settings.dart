import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cachehelper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${userModel!.cover}',
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.name}',
                style: TextStyle(fontSize: 25, height: 1.3),
              ),
              Text(
                '${userModel.bio}',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            Text(
                              'post',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '156',
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            Text(
                              'Photos',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '720',
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '65',
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            Text(
                              'Followings',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text('Add photo',style: TextStyle(
                        fontSize: 20,
                      ),),
                      onPressed: ()
                      {

                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(
                      child: Icon(Icons.edit,size: 16,),
                      onPressed: ()
                      {
                        navigatTo(context, EditProfileScreen());
                      },
                    ),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  child: Text('Logout',style: TextStyle(
                    fontSize: 20,
                  ),),
                  onPressed: ()
                  {
                    SocialCubit.get(context).userLogout();
                    CacheHelper.removeData(key: 'uId');
                    navigatTo(context, LoginScreen());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
