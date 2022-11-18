import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/pages/authentication/repo/repository.dart';

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
                      ('asset/login1.png'),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const Text(
              'Welcome User',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * .40,
              width: MediaQuery.of(context).size.width * .90,
              color: Colors.transparent,
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
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text('Login',
                      // style: TextStyle(fontWeight: FontWeight.w700,
                      // ),
                      //   textScaleFactor: 3,
                      // ),
                      // CircleAvatar(
                      //     radius: MediaQuery.of(context).size.width * .08,
                      //     child: onChanged
                      //         ? Icon(
                      //             CupertinoIcons.check_mark,
                      //             size: MediaQuery.of(context).size.width * .15,
                      //           )
                      //         : Icon(
                      //             CupertinoIcons.arrow_right,
                      //             size: MediaQuery.of(context).size.width * .15,
                      //           )),
                      Material(
                        borderRadius:
                            BorderRadius.circular(onChanged ? 150 : 10),
                        color: onChanged?Colors.lightBlueAccent.shade200:Colors.grey.shade200,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              onChanged = true;
                            });
                            await Future.delayed(const Duration(milliseconds: 500));
                            final email = _email.text.trim();
                            final password = _password.text;
                            try {
                              // print('here');
                              // print(email);
                              // print(password);
                              await FirebaseUser.createUser(email, password);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamed('/homepage/');
                              setState(() {
                                onChanged = false;
                              });
                            } catch (e, s) {
                              // print(e);
                              // print(s);
                            }
                          },
                          child: AnimatedContainer(
                            // alignment: Alignment.center,
                            width: onChanged
                                ? MediaQuery.of(context).size.width * 0.12
                                : MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.11,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
