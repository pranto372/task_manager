import 'package:flutter/material.dart';
import 'package:task_manager/data.network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/snack_message.dart';

import '../../data.network_caller/data.utility/urls.dart';
import '../../data.network_caller/network_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                        "Join With Us",
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your valid first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your valid last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your valid mobile';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if(value?.isEmpty ?? true){
                          return 'Enter your valid password';
                        }
                        if(value!.length>6){
                          return 'Enter password less than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(color: Colors.green,),
                        ),
                        child: ElevatedButton(
                            onPressed: _signUp,
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                              ),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account?",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,
                              color: Colors.black54
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 16,color: Colors.green),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      if(mounted){
        setState(() {});
      }
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration, body: {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
      });
      _signUpInProgress = false;
      if(mounted){
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextFields ();
        if (mounted) {
          showSnackMessage(context, 'Account has been created! please login.');
        }
      } else{
        if (mounted) {
          showSnackMessage(context, 'Account creation failed! please try again.', true);
        }
      }
    }
  }

  void _clearTextFields () {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
}

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
