import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {


        var cubit = SocialCubit.get(context);
        var textController = TextEditingController();


        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create post',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            titleSpacing: 5,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {

                    var now = DateTime.now();

                    if(cubit.postImage == null )
                    {
                      cubit.createPost(text: textController.text, dateTime: now.toString(), context: context);
                      
                    }
                    else{
                      cubit.uploadPostImage(text: textController.text, dateTime: now.toString(), context: context);
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${cubit.userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.userModel!.name}',
                        style: TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none
                    ),
                  ),
                ),
                 SizedBox(height: 20,),
                if(cubit.postImage != null)
                Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(cubit.postImage!),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(4)),
                              )
                              ,
                              IconButton(onPressed: ()
                            {
                              cubit.removePostImage();
                            }, 
                            icon: CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.close_rounded,size: 18,))),
                            ],
                          ),
                          SizedBox(height: 20,),
                          
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                        cubit.getPostImage();
                      }, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined),
                          SizedBox(width: 5,),
                          Text('add photo'),
                        ],
                      ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                    
                      }, 
                      child: 
                          Text('# tags'),
                       
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
