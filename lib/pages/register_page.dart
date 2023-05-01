import 'package:flutter/material.dart';

import '../themes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController uNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: Theme.of(context).primaryColor,
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
                    margin: const EdgeInsets.only(bottom: 15, top: 15),
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
                        FocusScope.of(context).requestFocus(emailNode);
                      },
                    ),
                  ),
                  //-------------------------------------------------------------Email TextField

                  Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: ThemeClass.secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: emailController,
                      focusNode: emailNode,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: ThemeClass.darkmodeBackground,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(passwordNode);
                      },
                    ),
                  ),

                  //------------------------------------------------------------------------------Password Textfield
                  Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: ThemeClass.secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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

                  //----------------------------------------------------------------------------Register button
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      uNameController.clear();
                      passwordController.clear();
                      emailController.clear();
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
                        child: Text("Register",
                            style: Theme.of(context).textTheme.titleMedium,
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
                              color: Colors.black),
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
                              color: Colors.black),
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
    );
  }
}
