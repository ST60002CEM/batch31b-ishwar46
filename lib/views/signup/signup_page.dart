import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/appcolor.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var versionName;
    return Scaffold(
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
                        "SIGNUP",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            color: AppColor.primaryColor),
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
                        "Please fillup the form to continue",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 1.5,
                            color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: AppColor.primaryColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColor.secondaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: AppColor.secondaryColor,
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
                          style:
                              const TextStyle(color: AppColor.secondaryColor),
                          showCursor: true,
                          //controller: passwordController,
                          //obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor),
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
                                    color: AppColor.secondaryColor),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_open_outlined,
                                size: 20,
                                color: AppColor.secondaryColor,
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
                        TextFormField(
                          style: const TextStyle(color: AppColor.primaryColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColor.secondaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: AppColor.secondaryColor,
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: AppColor.primaryColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColor.secondaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: AppColor.secondaryColor,
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: AppColor.primaryColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColor.secondaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: AppColor.secondaryColor,
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: AppColor.primaryColor),
                          showCursor: true,
                          //controller: usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            label: Text(
                              "Username",
                              //localization.username,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColor.secondaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              size: 20,
                              color: AppColor.secondaryColor,
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
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 80,
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(278, 30),
                      ),
                    ),
                    child: Text(
                      "Sign up",
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
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "© ${DateTime.now().year} Herchaha Mobile Application",
                          style: const TextStyle(
                              color: AppColor.secondaryColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Version $versionName",
                          style: const TextStyle(
                              color: AppColor.secondaryColor, fontSize: 10),
                        ),
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
