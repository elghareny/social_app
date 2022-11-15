import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) 
      {
      },
      builder: (context, state) {

        var cubit = SocialCubit.get(context);

        

        return ConditionalBuilder(
          condition: cubit.posts.length > 0 && cubit.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Stack(children: const [
                    Image(
                      image: NetworkImage(
                          'https://as1.ftcdn.net/v2/jpg/02/67/28/70/1000_F_267287089_EfjIf0FgT6AyPYjmKdQQIvjnbd7fgOMk.jpg'),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ]),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(cubit.posts[index],context , index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                  itemCount: cubit.posts.length,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model , context , index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text('${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                  iconSize: 18,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: TextStyle(
                  height: 1.3, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10, top: 5),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(children: [
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6),
            //         child: Container(
            //           height: 20,
            //           child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#software',
            //                 style: TextStyle(
            //                   color: Colors.blue,
            //                   height: 1.3,
            //                   fontSize: 14,
            //                 ),
            //               )),
            //         ),
            //       ),
            //     ]),
            //   ),
            // ),
            if(model.psotImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          '${model.psotImage}',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () 
                      {
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.heart_broken_outlined,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${SocialCubit.get(context).likes[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              size: 20,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('0 comment')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.heart_broken_outlined,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('like')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
