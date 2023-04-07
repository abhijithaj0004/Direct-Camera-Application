import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WhiteScreen extends StatefulWidget {
  const WhiteScreen({super.key});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    whiteOnClick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.camera,
          size: 200,
          color: Colors.black,
        ),
      ),
    );
  }

  Future<void> whiteOnClick() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
  }
}
