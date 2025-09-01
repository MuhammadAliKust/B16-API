import 'package:b16_api/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile View")),
      body: Column(
        children: [
          Text(
            "Name: ${userProvider.getUser().user!.name.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Email: ${userProvider.getUser().user!.email.toString()}",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
