import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ForgotPasswordInitial) {
            return _initialForgotPasswrod(context);
          } else if (state is ForgotPasswordLoading) {
            return _buildLoading();
          } else if (state is ForgotPasswordEnterOTP) {
            return _enterOTP();
          } else {
            return _initialForgotPasswrod(context);
          }
        },
      ),
    );
  }

  Widget _initialForgotPasswrod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter email"),
          EmailField(emailController),
          FlatButton(
              onPressed: () {
                _generatOTP(context);
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

  Widget _enterOTP() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter otp"),
          EmailField(emailController),
          FlatButton(onPressed: () {}, child: Text("Press me")),
        ],
      ),
    );
  }

  void _generatOTP(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.generateOTPInCubit(emailController.text);
  }

  void _verifyOtp(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.verifyOTP(int.parse(otpController.text));
  }
}
