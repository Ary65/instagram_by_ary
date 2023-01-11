import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_by_ary/resources/auth_methods.dart';
import 'package:instagram_by_ary/responsive/mobile_screen_layout.dart';
import 'package:instagram_by_ary/responsive/responsive_layout_screen.dart';
import 'package:instagram_by_ary/responsive/web_screen_layout.dart';
import 'package:instagram_by_ary/screens/login_screen.dart';
import 'package:instagram_by_ary/utils/colors.dart';
import 'package:instagram_by_ary/utils/global_variables.dart';
import 'package:instagram_by_ary/utils/utils.dart';
import 'package:instagram_by_ary/widgets/elevated_button.dart';
import 'package:instagram_by_ary/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const ResponsiveLatout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout());
    }));
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 2),
                //* svg logo
                const SizedBox(height: 60),
                SvgPicture.asset(
                  'assets/Instagram-Wordmark-Logo.wine.svg',
                  height: 64,
                ),
                const SizedBox(height: 20),
                //* Circular Widget to show our selected image
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://media.istockphoto.com/vectors/mental-gears-network-mind-vector-id1170901141'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                //* text field input for username
                TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: 'Enter your Username',
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),
                //* text field input for email
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: 'Enter your Email',
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),
                //* text field input for password
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: 'Enter your Password',
                    textInputType: TextInputType.text,
                    isPass: true),
                const SizedBox(height: 24),
                //* text field input for bio
                TextFieldInput(
                    textEditingController: _bioController,
                    hintText: 'Enter your Bio',
                    textInputType: TextInputType.text),
                const SizedBox(height: 24),
                //* Login button
                MyElevatedButton(
                    borderRadius: BorderRadius.circular(4),
                    onPressed: () {
                      signUpUser();
                    },
                    child: _isLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )),

                const SizedBox(height: 110),
                Flexible(child: Container(), flex: 2),

                //* Transitionto signup screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Already have an account?'),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: const Text('Login',
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
          ),
        )));
  }
}
