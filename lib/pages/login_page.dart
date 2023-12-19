import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/app_data.dart';
import '../services/authentication.dart';
import '../services/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextEditingController uNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool loading = false; // for login progress on the login button

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              // bottom: MediaQuery.of(context).viewInsets.bottom,
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
                //------------------------------------------------------------------Email TextField
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
                    controller: emailController,
                    autocorrect: false,
                    // style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                            child: Text(
                              "Forgot password?",
                              style:
                                  TextStyle(color: ThemeClass.secondaryColor),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await Authentication().forgotPassword(
                                  email: emailController.text,
                                  context: context);
                            })),
                  ],
                ),
                //----------------------------------------------------------------------------Login button
                GestureDetector(
                  onTap: () async {
                    //When login tapped, show loading indicator
                    setState(() {
                      loading = true;
                    });

                    FocusScope.of(context).unfocus();
                    var result = await Authentication().login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                        data: data);

                    //If successful signin, clear and go to home
                    if (result) {
                      passwordController.clear();
                      emailController.clear();
                      Navigator.of(context).pushReplacementNamed('/homePage');
                    }

                    //hide loading indicator
                    setState(() {
                      loading = false;
                    });
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
                      child: loading
                          ? CircularProgressIndicator(
                              color: ThemeClass.secondaryColor)
                          : Text("Login",
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
                      GestureDetector(
                        onTap: () async {
                          bool result = await Authentication()
                              .googleLogin(context: context, data: data);
                          //Navigator.of(context).pop();
                          if (result) {
                            passwordController.clear();
                            emailController.clear();
                            Navigator.of(context)
                                .pushReplacementNamed('/homePage');
                          } else {
                            Navigator.of(context)
                                .pushReplacementNamed('/homePage');
                          }
                        },
                        child: Container(
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
                    const Text('Are you new?'),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/registerPage'),
                        child: Text('Register now',
                            style: TextStyle(color: ThemeClass.secondaryColor)))
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
