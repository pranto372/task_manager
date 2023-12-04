import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    String imageData = AuthController.user!.photo!.split("data:image/png;base64")[0];
    String base64String = AuthController.user?.photo ?? '';
    if (base64String.startsWith('data:image')) {
      // Remove data URI prefix if present
      base64String =
          base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    }
    print(base64String);
    Uint8List imageBytes = Base64Decoder().convert(base64String);
    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: AuthController.user?.photo == null
            ? Icon(Icons.person)
            : Image.memory(imageBytes),
      ),
      title: Text(
        fullName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () async{
          await AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context)=> const LoginScreen()), (route) => false);
        },
        icon: const Icon(Icons.logout, color: Colors.white,),
      ),
      tileColor: Colors.green,
    );
  }
  String get fullName{
    return '${AuthController.user?.firstName ?? ''}  ${AuthController.user?.lastName ?? ')'}';
  }
}
