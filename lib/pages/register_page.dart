import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_data.dart';
import '../services/themes.dart';
import '../services/authentication.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool loading = false; // for login progress on the login button
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
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
                  //-------------------------------------------------------------Email TextField
                  Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: ThemeClass.secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: emailController,
                      //focusNode: emailNode,
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
                        FocusScope.of(context).requestFocus(confirmNode);
                      },
                    ),
                  ),
                  //------------------------------------------------------------------Confirm password TextField
                  Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: ThemeClass.secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      autocorrect: false,
                      // style: const TextStyle(color: Colors.white70),
                      focusNode: confirmNode,
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: ThemeClass.darkmodeBackground,
                        ),
                        border: InputBorder.none,
                        //labelStyle: TextStyle(color: Colors.white70),
                      ),
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),

                  //----------------------------------------------------------------------------Register button
                  GestureDetector(
                    onTap: () async {
                      //When login tapped, show loading indicator
                      setState(() {
                        loading = true;
                      });
                      var result = await Authentication().register(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          context: context);

                      if (result) {
                        Navigator.of(context).pushNamed('/');
                      }
                      //hide loading indicator
                      setState(() {
                        loading = false;
                      });

                      FocusScope.of(context).unfocus();
                      confirmPasswordController.clear();
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
                        child: loading
                            ? CircularProgressIndicator(
                                color: ThemeClass.secondaryColor)
                            : Text("Register",
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
                        //Google button
                        GestureDetector(
                          onTap: () async {
                            bool result = await Authentication()
                                .googleLogin(context: context, data: data);

                            if (result) {
                              Navigator.of(context).pushNamed('/homePage');
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
                                color: Colors.black),
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
