import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/screens/forgot_password/widgets/otp_field.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/screens/forgot_password/widgets/confirm_password_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ForgotEmailInitial) {
            return _initialForgotPassword(context, state);
          } else if (state is ForgotLoading) {
            return _buildLoading();
          } else if (state is ForgotOTPInitial) {
            return _enterOTP(context, state);
          } else if (state is ForgotPasswordError) {
            return _uiUpdateForNetworkError(context, state.state);
          } else if (state is ForgotResetInitial) {
            return _resetPassword(context, state);
          } else if (state is ForgotResetSuccess) {
            return _passwordResetSuccess();
          } else {
            return _initialForgotPassword(context, state);
          }
        },
      ),
    );
  }

  Widget _uiUpdateForNetworkError(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotEmailInitial) {
      return _initialForgotPassword(context, state);
    } else if (state is ForgotOTPInitial) {
      return _enterOTP(context, state);
    } else if (state is ForgotPasswordError) {
      return _enterOTP(context, state);
    } else if (state is ForgotResetInitial) {
      return _resetPassword(context, state);
    } else {
      return _initialForgotPassword(context, state);
    }
  }

  Widget _initialForgotPassword(BuildContext context, ForgotPasswordState state) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    if (_scrollController.hasClients) {
      if (bottom > height * 0.25) {
        _scrollController.animateTo(
          bottom - height * 0.25,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          ScreenBackground(elementId: 1),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height * 1.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, heightFactor * 100, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          "Step 1/3",
                          style:
                              TextStyle(fontSize: 35 * heightFactor, fontWeight: FontWeight.w600),
                        ),
                      )),
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: D.horizontalPadding + 1),
                          child: Image.asset(
                            S.assetEcellLogoWhite,
                            width: width * 0.25 * heightFactor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: D.horizontalPadding, top: 20),
                          child: Text(
                            "Welcome",
                            style:
                                TextStyle(fontSize: 35 * heightFactor, fontWeight: FontWeight.w600),
                          ),
                        ),
                        //Text Greeting
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Forgot your ",
                                    style: TextStyle(
                                        color: C.primaryUnHighlightedColor,
                                        fontWeight: FontWeight.w300)),
                                TextSpan(
                                  text: "Password ",
                                  style: TextStyle(color: C.primaryHighlightedColor),
                                ),
                                TextSpan(
                                    text: "? \n",
                                    style: TextStyle(
                                        color: C.primaryUnHighlightedColor,
                                        fontWeight: FontWeight.w300)),
                                TextSpan(
                                    text:
                                        "We got you covered.\nJust enter your registered email address.",
                                    style: TextStyle(
                                        color: C.primaryUnHighlightedColor,
                                        fontWeight: FontWeight.w300)),
                              ],
                              style: TextStyle(fontSize: 25 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 23 * heightFactor),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  EmailField(emailController),
                                  SizedBox(height: 20 * heightFactor),
                                  SizedBox(height: 10 * heightFactor),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  //LoginButton
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          color: C.authButtonColor,
                          onPressed: () => _sendOTP(context, state),
                          child: Container(
                            height: 60,
                            width: 120,
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: C.primaryUnHighlightedColor, fontSize: 20 * heightFactor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //To flex background
                  Expanded(flex: 9, child: Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _enterOTP(BuildContext context, ForgotPasswordState state) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter otp"),
          OTPField(otpController),
          FlatButton(
              onPressed: () {
                _verifyOtp(context, state);
              },
              child: Text("Press me")),
        ],
      ),
    );
  }

  Widget _passwordResetSuccess() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Text("success"),
    );
  }

  Widget _resetPassword(BuildContext context, ForgotPasswordState state) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    if (_scrollController.hasClients) {
      if (bottom > height * 0.25) {
        _scrollController.animateTo(
          bottom - height * 0.25,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          //background
          ScreenBackground(elementId: 0),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height * 1.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //3/3 text
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, heightFactor * 100, 0, 0),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Step 3/3",
                            style:
                                TextStyle(fontSize: 35 * heightFactor, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 23 * heightFactor),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                color: C.primaryHighlightedColor,
                                fontSize: heightFactor * 30,
                              ),
                            ),
                          ),
                          SizedBox(height: 23 * heightFactor),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Please enter new password",
                              style: TextStyle(
                                fontSize: heightFactor * 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // password and confirm password fields
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PasswordField(passwordController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConfirmPasswordField(confirmPasswordController),
                          ),
                          SizedBox(height: 20 * heightFactor),
                          Container(
                            padding: EdgeInsets.only(right: D.horizontalPadding),
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: C.authButtonColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                    offset: Offset(0, 12),
                                  )
                                ],
                              ),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                color: C.authButtonColor,
                                onPressed: () => _changePassword(context, state),
                                child: Container(
                                  height: 60,
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                        color: C.primaryUnHighlightedColor,
                                        fontSize: 20 * heightFactor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendOTP(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.sendOTP(emailController.text, state);
  }

  void _verifyOtp(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.checkOTP(otpController.text, state, emailController.text);
  }

  void _changePassword(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.changePassword(emailController.text, otpController.text, passwordController.text,
        confirmPasswordController.text, state);
  }
}