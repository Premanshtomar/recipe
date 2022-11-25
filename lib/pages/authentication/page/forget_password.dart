import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/alert_dialog.dart';
import '../../../utils/exceptions.dart';
import '../repo/repository.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _email = TextEditingController();
  bool onChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('asset/forget.png'),
                fit: BoxFit.cover,
              )),
            ),
            const Text(
              'Forget Password?',
              style: TextStyle(fontWeight: FontWeight.w700),
              textScaleFactor: 2,
            ),
            const Text(
              "Don't worry it happens!",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const Text(
              'Enter your Email so we can help you!',
              style: TextStyle(fontWeight: FontWeight.w700),
              textScaleFactor: 2.75,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(24),
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
                    height: MediaQuery.of(context).size.height * 0.02,
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
                        final firebaseUser = FirebaseUser();
                        try {
                          await firebaseUser.forgetPassword(email: email);
                          if (FirebaseAuth.instance.currentUser != null) {
                            // ignore: use_build_context_synchronously
                            showErrorDialog(context, 'text');
                          }
                          setState(() {
                            onChanged = false;
                          });
                        } on UserNotFoundAuthException catch (_) {
                          // ignore: use_build_context_synchronously
                          showErrorDialog(context, 'User Not Found');
                        } on InvalidEmailAuthException catch (_) {
                          // ignore: use_build_context_synchronously
                          showErrorDialog(context, 'Invalid Email Address');
                        } on GenericAuthException catch (_) {
                          // ignore: use_build_context_synchronously
                          showErrorDialog(context, 'Authentication Error');
                        }

                        setState(() {
                          onChanged = false;
                        });
                      },
                      child: AnimatedContainer(
                        // alignment: Alignment.center,
                        width: onChanged
                            ? MediaQuery.of(context).size.width * 0.12
                            : MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.13,
                        duration: const Duration(milliseconds: 500),
                        child: onChanged
                            ? const Icon(
                                Icons.done,
                                color: Colors.black,
                                size: 50,
                              )
                            : const Center(
                                child: Text(
                                  'Send link',
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
                  'Click here to Login->',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey,
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
