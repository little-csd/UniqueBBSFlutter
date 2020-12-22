import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';

// todo : refactor
class ForumItem2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
              'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/'
                  'it/u=1336318030,2258820972&fm=26&gp=0.jpg'),
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          height: 48,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "2020年举办全球Hackday吧",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                  Text(
                    " HOT",
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Text(
                "2020.01.19 肖宇轩 发布",
                style: TextStyle(
                  color: ColorConstant.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}



