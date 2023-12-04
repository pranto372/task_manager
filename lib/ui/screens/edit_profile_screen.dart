import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data.network_caller/data.utility/urls.dart';
import 'package:task_manager/data.network_caller/network_caller.dart';
import 'package:task_manager/data.network_caller/network_response.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/snack_message.dart';

import '../widgets/body_background.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _updateProfileInProgress = false;

  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstNameTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        photoPickerField(),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          decoration: InputDecoration(hintText: "E-mail"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _firstNameTEController,
                          decoration: InputDecoration(hintText: "First Name"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _lastNameTEController,
                          decoration: InputDecoration(hintText: "Last Name"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _mobileTEController,
                          decoration: InputDecoration(hintText: "Mobile"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          decoration:
                              InputDecoration(hintText: "Password (Optional)"),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _updateProfileInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: updateProfile,
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }

    if(photo != null){
      List<int> imageBytes = await photo!.readAsBytes();
      String photoInBase64 = base64Encode(imageBytes);
      inputData ['photo'] = photoInBase64;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        AuthController.updateUserInformation(UserModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          photo: photoInBase64 ?? AuthController.user?.photo
        ));
        showSnackMessage(context, 'Update profile success!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed!');
      }
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: Text(
                "Photo",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                if(image != null){
                  photo = image;
                }
              },
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: Text(
                    "Select a photo",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
