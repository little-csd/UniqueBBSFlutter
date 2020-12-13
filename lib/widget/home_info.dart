import 'package:flutter/material.dart';

class HomeInfoWidget extends StatefulWidget {
  @override
  State createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Info'),
      alignment: Alignment.center,
    );
  }
}
