
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: const [Image(image: NetworkImage('https://as1.ftcdn.net/v2/jpg/02/67/28/70/1000_F_267287089_EfjIf0FgT6AyPYjmKdQQIvjnbd7fgOMk.jpg'),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              ),
              ]
            ),
          ),
    
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(height: 8,),
            itemCount: 10,
          ),
          SizedBox(height: 8,),
    
        ],
      ),
    );
  }



Widget buildPostItem (context) => Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:  [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/16/82/06/1000_F_316820624_1R45ZpURWLJOv0aQZxTvGkEpXS3yeWcV.jpg'),
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
                                Text('Mohamed Said',
                                style: TextStyle(
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                                )
                              ],
                            ),
                            Text('january 21 , 2022 at 11:00 pm',
                            style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3,fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(onPressed: ()
                      {
    
                      }, 
                      icon: Icon(Icons.more_horiz),iconSize: 18,)
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
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Container(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: Container(
                              height: 20,
                              child: MaterialButton(onPressed: (){}, 
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              child: Text(
                                '#software',
                                style: TextStyle(color: Colors.blue,
                                height: 1.3,
                                fontSize: 14,),
                                )),
                            ),
                          ),
                          ]
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(image: DecorationImage(
                        image: NetworkImage('https://as1.ftcdn.net/v2/jpg/02/67/28/70/1000_F_267287089_EfjIf0FgT6AyPYjmKdQQIvjnbd7fgOMk.jpg',),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(4)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Icon(Icons.heart_broken_outlined,
                                    size: 20,
                                    color: Colors.red,),
                                    SizedBox(width: 5,),
                                    Text('1200')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.chat_outlined,
                                    size: 20,
                                    color: Colors.amber,),
                                    SizedBox(width: 5,),
                                    Text('1200 comment')
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
                            onTap: (){},
                            child: Row(
                              children: [
                                CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/16/82/06/1000_F_316820624_1R45ZpURWLJOv0aQZxTvGkEpXS3yeWcV.jpg'),
                                                ),
                                                const SizedBox(
                            width: 15,
                                                ),
                                                Text('write a comment ...',
                                style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                              onTap: (){},
                              child: Row(
                                children: [
                                  Icon(Icons.heart_broken_outlined,
                                  size: 20,
                                  color: Colors.red,),
                                  SizedBox(width: 5,),
                                  Text('like')
                                ],
                              ),
                            ),
                      ],
                    ),
                ],
              ),
            )
          );


}