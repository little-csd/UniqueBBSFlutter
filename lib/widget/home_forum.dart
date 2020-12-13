import 'package:flutter/material.dart';

class HomeForumWidget extends StatefulWidget {
  @override
  State createState() => _HomeForumState();
}

class _HomeForumState extends State<HomeForumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Forum'),
      alignment: Alignment.center,
    );
  }
}
