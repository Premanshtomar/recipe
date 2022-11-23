// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/pages/authentication/repo/repository.dart';

import '../../../utils/alert_dialog.dart';
import '../../../utils/exceptions.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
                      ('asset/login.png'),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const Text(
              'Hello User',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * .90,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/reset_pass/', (route) => false);
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
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
                          await firebaseUser.logInUser(
                              email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/homepage/', (route) => false);
                          }
                        } on UserNotFoundAuthException catch (_) {
                          showErrorDialog(context, 'User Not Found.');
                        } on WrongPasswordAuthException catch (_) {
                          showErrorDialog(context, 'Wrong Password.');
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
                                  'Login',
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
                  'Not Registered?Sign-up here->',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.blueGrey),
                  textScaleFactor: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signing/', (route) => false);
                    },
                    child: const Text(
                      'Sign-up!',
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
