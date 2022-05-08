import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_by_ary/resources/auth_methods.dart';
import 'package:instagram_by_ary/responsive/mobile_screen_layout.dart';
import 'package:instagram_by_ary/responsive/responsive_layout_screen.dart';
import 'package:instagram_by_ary/responsive/web_screen_layout.dart';
import 'package:instagram_by_ary/screens/signup_screen.dart';
import 'package:instagram_by_ary/utils/colors.dart';
import 'package:instagram_by_ary/utils/global_variables.dart';
import 'package:instagram_by_ary/utils/utils.dart';
import 'package:instagram_by_ary/widgets/elevated_button.dart';
import 'package:instagram_by_ary/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const ResponsiveLatout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout());
      }));
    }

    //&
    else {
      showSnackBar(res, context);
    }
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: MediaQuery.of(context).size.width > webScreenSize
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
          : const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Container(), flex: 2),
          //* svg logo
          SvgPicture.asset(
            'assets/Instagram-Wordmark-Logo.wine.svg',
            height: 64,
          ),
          const SizedBox(height: 64),

          //* text field input for email
          TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter your Email',
              textInputType: TextInputType.emailAddress),
          const SizedBox(height: 24),
          //* text field input for password
          TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your Password',
              textInputType: TextInputType.text,
              isPass: true),
          const SizedBox(height: 24),
          //* Login button
          MyElevatedButton(
            borderRadius: BorderRadius.circular(4),
            onPressed: () {
              loginUser();
            },
            child: _isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: primaryColor,
                    ),
                  )
                : const Text(
                    'Log in',
                    style: TextStyle(fontSize: 16),
                  ),
          ),

          const SizedBox(height: 12),
          Flexible(child: Container(), flex: 2),

          //* Transitionto signup screen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text('Don\'t have an account?'),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: navigateToSignup,
                child: Container(
                  child: const Text('Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}
