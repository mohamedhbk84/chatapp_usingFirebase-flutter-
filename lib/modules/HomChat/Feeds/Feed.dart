import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/models/PostsModels.dart';
// import 'package:newchat/Shared/Style/Icon_Broken.dart';
import 'package:newchat/modules/HomChat/Cubit/Cubit.dart';
import 'package:newchat/modules/HomChat/Cubit/States.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0 &&
                SocialCubit.get(context).model != null,
            builder: (context) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(
                      8.0,
                    ),
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                              'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                            ),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'communicate with friends',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          )
                        ]),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index], context, index),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildPostItem(PostsModel model, context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        '${model.image}',
                      ),
                      // 'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                // style: TextStyle(fontSize: 11),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            '${model.dateTime}',
                            // " march 30 , 2021 at 12 pm",
                            style: TextStyle(fontSize: 11, height: 1.7),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                        onPressed: () {})
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                ),
                Text(
                  '${model.text}',
                  // "طول عمري بخاف من القرب ، بخاف أتعلق بحد ويبقي جزء من يومي ويسبنى ويمشي ، بخاف أكون تقيل علي اللي قدامى ، بخاف أتعود علي حد ويمل منى ، بخاف أحكى وأندم ، بخاف اللي قدامى يتغير معايا من غير سببي",
                  style: TextStyle(fontSize: 14, height: 1.2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Container(
                          height: 25,
                          child: MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text(
                                "# metab",
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                            '${model.postImage}',
                          ),
                          // 'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.hearing_outlined,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.comment,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              ' 120 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model.image}',
                            )
                            // 'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                            ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Write Your Comment ..."),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit.get(context).postsId[index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.home_repair_service_outlined),
                              Text(" Like"),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
