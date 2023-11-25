import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';

import 'sign_up_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 8,),
                  Text("A 6 digit OTP will be sent your Email address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 24,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinVerificationScreen(),
                            ),
                          );
                        },
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
    );
  }
}
