import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users![index], context),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                endIndent: 20,
                indent: 20,
              ),
              itemCount: SocialCubit.get(context).users!.length),
          fallback: (context) =>  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model , context) => InkWell(
    onTap: ()
    {
      SocialCubit.get(context).getMessages(receiverId: model.uId);
      navigatTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                    height: 1.3, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
    ),
  );
}
