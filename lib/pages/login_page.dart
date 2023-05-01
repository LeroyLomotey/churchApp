import 'package:flutter/material.dart';

import '../themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController uNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 300,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ICGC\nLiberty Temple',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                //------------------------------------------------------------------Username TextField
                Container(
                  width: 300,
                  height: 50,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  margin: const EdgeInsets.only(
                    bottom: 15,
                    top: 15,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeClass.secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: uNameController,
                    autocorrect: false,
                    // style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: ThemeClass.darkmodeBackground,
                      ),
                      border: InputBorder.none,
                      //labelStyle: TextStyle(color: Colors.white70),
                    ),
                    keyboardType: TextInputType.name,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passwordNode);
                    },
                  ),
                ),
                //------------------------------------------------------------------------------Password Textfield
                Column(
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: ThemeClass.secondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: passwordController,
                        focusNode: passwordNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: ThemeClass.darkmodeBackground,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),

                    //-------------------------------------------------------------------------Forgot password button
                    Container(
                        alignment: Alignment.centerRight,
                        width: 300,
                        height: 30,
                        child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text("Forgot password?",
                                style:
                                    TextStyle(color: ThemeClass.primaryColor)),
                            onPressed: () => {})),
                  ],
                ),
                //----------------------------------------------------------------------------Login button
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    uNameController.clear();
                    passwordController.clear();
                    Navigator.of(context).pushNamed('/homePage');
                  },
                  child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: ThemeClass.primaryColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeClass.tertiaryColor,
                              spreadRadius: 1,
                              blurRadius: 4,
                            )
                          ]),
                      child: Text("Login",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center)),
                ),

                //Continue with
                const Text("- or continue with -"),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Google icon
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: ThemeClass.primaryColor, width: 2),
                          color: ThemeClass.secondaryColor,
                        ),
                        child: Image.asset('assets/icons/google.png',
                            color: const Color(0xFF1C1B1F)),
                      ),
                      //Apple icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: ThemeClass.primaryColor, width: 2),
                          color: ThemeClass.secondaryColor,
                        ),
                        child: Image.asset('assets/icons/apple.png',
                            color: const Color(0xFF1C1B1F)),
                      ),
                      //Facebook icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: ThemeClass.primaryColor, width: 2),
                          color: ThemeClass.secondaryColor,
                        ),
                        child: Image.asset('assets/icons/facebook.png',
                            color: const Color(0xFF1C1B1F)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you new?',
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/registerPage'),
                        child: Text('Register now',
                            style: TextStyle(color: ThemeClass.primaryColor)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
