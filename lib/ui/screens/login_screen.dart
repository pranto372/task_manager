import 'package:flutter/material.dart';
import 'package:task_manager/data.network_caller/data.utility/urls.dart';
import 'package:task_manager/data.network_caller/network_caller.dart';
import 'package:task_manager/data.network_caller/network_response.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/snack_message.dart';

import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

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
                      "Get Started With",
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
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(color: Colors.green,),
                        ),
                        child: ElevatedButton(
                            onPressed: login,
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
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don\'t have an account?",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,
                          color: Colors.black54
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
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

  Future<void> login() async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    _loginInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body: {
      'email' : _emailTEController.text.trim(),
      'password' : _passwordTEController.text
    }, isLogin: true);
    _loginInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      await AuthController.saveUserInformation(
          response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data']));
      if(mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const MainBottomNavScreen(),),);
      }
    }else{
      if(response.statusCode == 401){
        if(mounted) {
          showSnackMessage(context, 'please check your email or password');
        }
      }else{
        if(mounted) {
          showSnackMessage(context, 'login failed! Try again.');
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
