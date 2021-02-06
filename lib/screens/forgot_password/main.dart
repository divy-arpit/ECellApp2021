import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/screens/forgot_password/forgot_password.dart';
import 'package:ecellapp/screens/forgot_password/forgot_password_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:BlocProvider(
        create: (context)=>ForgotPasswordCubit(FakeForgotPasswordRepository()),
        child: ForgotPasswordScreen(),
      ),
    );
  }

}
