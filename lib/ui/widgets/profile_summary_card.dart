import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
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
        child: Icon(Icons.person),
      ),
      title: Text(
        "Pranto Deb",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        "Prantodeb62@gmail.com",
        style: TextStyle(color: Colors.white),
      ),
      trailing: enableOnTap? Icon(Icons.arrow_forward) : null,
      tileColor: Colors.green,
    );
  }
}
