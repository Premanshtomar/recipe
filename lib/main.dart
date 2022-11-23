import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/pages/authentication/page/forget_password.dart';
import 'package:recipe/pages/authentication/page/login_page.dart';
import 'package:recipe/pages/authentication/page/signup_page.dart';
import 'package:recipe/pages/details/details.dart';
import 'package:recipe/pages/home/pages/home_page.dart';

// import 'package:firebase_core/firebase_core.dart';
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark

  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const HomePage()  ,
    routes:{'/homepage/' : (context) => const HomePage(),
      '/logging/': (context)=> const LogInPage(),
      '/signing/': (context)=> const SignUpPage(),
      '/reset_pass/': ( context)=> const ForgetPassword(),
      '/details/': ( context)=> const Details(),
  });
}}
