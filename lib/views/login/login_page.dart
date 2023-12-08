import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/appcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisiable = false;
  @override
  Widget build(BuildContext context) {
    var versionName;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/img/logo.png",
                    repeat: ImageRepeat.noRepeat,
                    width: 80,
                    height: 80,
                    //color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "LOGIN",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Login Message
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Please Login to Continue",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 1.5,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //SVG
                  SvgPicture.asset(
                    "assets/svg/login_image.svg",
                    width: 200,
                    height: 200,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          validator: (value) {
                            if (value == "") {
                              //return localization.username_required;
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor),
                          showCursor: true,
                          //controller: passwordController,
                          //obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              label: Text(
                                "Password",
                                //localization.password,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                size: 20,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    //passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: const Icon(
                                  //passwordVisible
                                  //? Icons.visibility
                                  //: Icons.visibility_off,
                                  Icons.visibility_off,
                                  color: AppColor.secondaryColor,
                                ),
                              )),
                          validator: (value) {
                            if (value == "") {
                              // return localization.password_cannot_be_empty;
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                          activeColor: AppColor.primaryColor,
                        ),
                        Text(
                          "Remember Me",
                          //localization.remember_me,
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).secondaryHeaderColor,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(278, 30),
                      ),
                    ),

                    child: Text(
                      "Login",
                      //localization.login.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        letterSpacing: 1.3,
                        color: AppColor.whiteText,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    // onPressed: () async {
                    //   FocusScope.of(context).requestFocus(FocusNode());
                    //   EasyLoading.show(status: localization.logging_in);
                    //   _loginBloc.add(
                    //     LoginClickEvent(
                    //       username: usernameController.text,
                    //       password: passwordController.text,
                    //     ),
                    //   );
                    // },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Text(
                      "New User? Create Account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/signuppage'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "© ${DateTime.now().year} Herchaha Mobile Application",
                          style: GoogleFonts.montserrat(
                              fontSize: 10,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Version $versionName",
                            style: GoogleFonts.montserrat(
                                fontSize: 10,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).secondaryHeaderColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
