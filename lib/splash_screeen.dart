import 'package:bloc_curd/screen/AddUser/add_user_detail.dart';
import 'package:bloc_curd/screen/ShowUser/show_user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => GetUserDetails()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Sqflite Using \nBloc",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
