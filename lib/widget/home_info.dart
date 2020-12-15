import 'package:flutter/material.dart';

class HomeInfoWidget extends StatefulWidget {
  @override
  State createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
          FlatButton(
            child: Container(),
          )
        ],
      ),
    );
  }
}
