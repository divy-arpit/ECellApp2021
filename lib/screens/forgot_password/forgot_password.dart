import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/screens/forgot_password/widgets/otp_field.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotNetworkError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ForgotOTPFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Wrong OTP")),
            );
          } else if (state is ForgotEmailFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Please check email")),
            );
          } else if (state is ForgotResetFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Failed to reset password")),
            );
          }
        },
        builder: (context, state) {
          if (state is ForgotEmailInitial) {
            return _initialForgotPassword(context);
          } else if (state is ForgotLoading) {
            return _buildLoading();
          } else if (state is ForgotEmailFailure) {
            return _initialForgotPassword(context);
          } else if (state is ForgotOTPInitial) {
            return _enterOTP(context);
          } else if (state is ForgotOTPFailure) {
            return _enterOTP(context);
          } else if (state is ForgotResetInitial) {
            return _resetPassword(context);
          } else if (state is ForgotResetFailure) {
            return _resetPassword(context);
          } else if (state is ForgotResetSuccess) {
            return _passwordResetSuccess();
          } else {
            return _initialForgotPassword(context);
          }
        },
      ),
    );
  }

  Widget _initialForgotPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter email"),
          EmailField(emailController),
          FlatButton(
              onPressed: () {
                _sendOTP(context);
              },
              child: Text("Press me")),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _enterOTP(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter otp"),
          OTPField(otpController),
          FlatButton(
              onPressed: () {
                _verifyOtp(context);
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

  Widget _resetPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          PasswordField(passwordController),
          PasswordField(confirmPasswordController),
          FlatButton(
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  _changePassword(context);
                } else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("Missmatch in passwords")));
                }
              },
              child: Text("change password")),
        ],
      ),
    );
  }

  void _sendOTP(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.sendOTP(emailController.text);
  }

  void _verifyOtp(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.verifyOTP(otpController.text);
  }

  void _changePassword(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.changePassword(emailController.text, otpController.text, passwordController.text);
  }
}