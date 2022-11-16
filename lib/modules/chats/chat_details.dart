import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, this.userModel});

  UserModel? userModel;

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userModel!.image!),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(userModel!.name!, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) 
                          {
                            var message = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel!.uId == message.senderId) 
                            {
                              return buildMyMessage(message);
                            }else
                            return buildMessage(message);
                          }, 
                          separatorBuilder: (context, index) => SizedBox(height: 15,), 
                          itemCount: SocialCubit.get(context).messages.length),
                      ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                                    messageController.text = '';
                              },
                              minWidth: 1,
                              child: Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          
        },
      );
  }





Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          child: Text(message.text!),
        ),
      );

  Widget buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          child: Text(message.text!),
        ),
      );


  }

  

