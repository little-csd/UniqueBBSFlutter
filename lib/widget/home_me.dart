import 'package:flutter/material.dart';

class HomeMeWidget extends StatefulWidget {
  @override
  State createState() => _HomeMeState();
}

class _HomeMeState extends State<HomeMeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('me'),
      alignment: Alignment.center,
    );
  }
}
