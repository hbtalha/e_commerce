import 'package:e_commerce/common/widgets/app_title.dart';
import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/common/widgets/custom_textfield.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/auth/services/auth_service.dart';
import 'package:e_commerce/features/auth/widgets/bezierContainer.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authFormKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool toSignIn = true;

  void signUpUser() {
    _authService.signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    _authService.signInUser(
      mounted: mounted,
      context: context,
      loginValue: toSignIn ? _nameController.text : _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -MediaQuery.of(context).size.height * .10,
                right: -MediaQuery.of(context).size.width * .3,
                child: const BezierContainer(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .2),
                    const AppTitle(),
                    const SizedBox(height: 50),
                    Form(
                      key: _authFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            title: toSignIn ? "Name/Email" : "Name",
                          ),
                          if (!toSignIn)
                            CustomTextField(
                              controller: _emailController,
                              title: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                          CustomTextField(
                            controller: _passwordController,
                            title: "Password",
                            obscureText: true,
                          ),
                          CustomButton(
                              text: toSignIn ? "Sign In" : "Sign Up",
                              onTap: () {
                                if (_authFormKey.currentState!.validate()) {
                                  if (toSignIn) {
                                    signInUser();
                                  } else {
                                    signUpUser();
                                  }
                                }
                              }),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        toSignIn = !toSignIn;
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              toSignIn ? "Don't have an account?" : 'Already have an account ?',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              toSignIn ? 'Sign Up' : "Sign In",
                              style: const TextStyle(
                                  color: GlobalVariables.secondaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
