part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState{}
class ForgotPasswordEnterOTP extends ForgotPasswordState{}
class ForgotPasswordFinal extends ForgotPasswordState{}
class ForgotPasswordError extends ForgotPasswordState{}

