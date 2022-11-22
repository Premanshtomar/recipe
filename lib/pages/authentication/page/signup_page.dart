// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/pages/authentication/repo/repository.dart';
import 'package:recipe/pages/authentication/utils/alert_dialog.dart';

import '../utils/exceptions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool onChanged = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ('asset/sign in.png'),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Container(
              // padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * .31,
              width: MediaQuery.of(context).size.width * .90,
              // color: Colors.red,
              child: Column(
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.at_circle),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.grey,
                      filled: true,
                      label: const Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextField(
                    controller: _password,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.lock_circle),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.grey,
                      filled: true,
                      label: const Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(onChanged ? 150 : 10),
                    color: onChanged
                        ? Colors.lightBlueAccent.shade200
                        : Colors.grey.shade200,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          onChanged = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 500));
                        final email = _email.text.trim();
                        final password = _password.text;
                        final firebaseUser = FirebaseUser();
                        // ignore: duplicate_ignore, duplicate_ignore
                        try {
                          await firebaseUser.createUser(
                              email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await user.sendEmailVerification();
                            showEmailVerificationDialog(context,
                                'Email verification link is sent to your Email');
                            setState(() {
                              onChanged = false;
                            });
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed('/email_verify/');
                        } on WeakPasswordAuthException catch (_) {
                          showErrorDialog(context, 'Password Is Too Weak');
                        } on EmailAlreadyInUseAuthException catch (_) {
                          showErrorDialog(context, 'Email Already In Use.');
                        } on InvalidEmailAuthException catch (_) {
                          showErrorDialog(context, 'Invalid Email');
                        } on GenericAuthException catch (_) {
                          showErrorDialog(context, 'Authentication Error.');
                        }
                        setState(() {
                          onChanged = false;
                        });
                      },
                      child: AnimatedContainer(
                        // alignment: Alignment.center,
                        width: onChanged
                            ? MediaQuery.of(context).size.width * 0.12
                            : MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.14,
                        duration: const Duration(milliseconds: 500),
                        child: onChanged
                            ? const Icon(
                                Icons.done,
                                color: Colors.black,
                                size: 50,
                              )
                            : const Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textScaleFactor: 3,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Already Registered?Login here->',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.blueGrey),
                  textScaleFactor: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/logging/', (route) => false);
                    },
                    child: const Text(
                      'Login!',
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                      textScaleFactor: 1.5,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
