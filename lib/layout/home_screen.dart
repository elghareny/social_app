import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/notifications/notifications.dart';
import 'package:social_app/modules/search/search.dart';
import 'package:social_app/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {
        if(state is NewPostState)
        {
          navigatTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state)
          {
          },
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex!],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                  ),
                ),
                actions: [
                  IconButton(onPressed: ()
                  {
                    navigatTo(context, NotificationsScreen());
                  }, 
                  icon: Icon(Icons.notifications_active_outlined)),

                  IconButton(onPressed: ()
                  {
                    navigatTo(context, SearchScreen());
                  }, 
                  icon: Icon(Icons.search)),
                ],
              ),
              body: cubit.homeScreens[cubit.currentIndex!],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex!,
                onTap: (index) {
                  cubit.ChangeNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                  BottomNavigationBarItem(icon: Icon(Icons.upload_outlined), label: 'Post'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
