import 'package:flutter/material.dart';
import 'package:kuis_api_kel29/auth/auth_api.dart'; 

class HomePage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const HomePage({
    Key? key,
    required this.userID,
    required this.accessToken,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> 
{

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: Scaffold
      (
        appBar: AppBar
        (

        ),
        body: SingleChildScrollView
        (
          child: Center
          (
            child: Text
            (
              "NIGEER"
            )
          ),
        ),
      ),
    );
  }
}