import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/body_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
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
                  "Get Started With",
                  style: Theme.of(context).textTheme.titleLarge
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
