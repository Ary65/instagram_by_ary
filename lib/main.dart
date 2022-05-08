import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_by_ary/providers/user_provider.dart';
import 'package:instagram_by_ary/responsive/mobile_screen_layout.dart';
import 'package:instagram_by_ary/responsive/responsive_layout_screen.dart';
import 'package:instagram_by_ary/responsive/web_screen_layout.dart';
import 'package:instagram_by_ary/screens/login_screen.dart';
import 'package:instagram_by_ary/screens/signup_screen.dart';
import 'package:instagram_by_ary/utils/colors.dart';
import 'package:instagram_by_ary/utils/global_variables.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyB2Pg1uD5vXmmlZPyGIMoNL6Z-bRIeVAv0',
      appId: '1:572160834724:web:39150d9dcdb005fcda7a31',
      messagingSenderId: '572160834724',
      projectId: 'instagram-by-ary',
      storageBucket: 'instagram-by-ary.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Instagram by Ary',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLatout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
