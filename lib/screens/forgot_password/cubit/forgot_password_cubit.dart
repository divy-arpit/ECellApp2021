import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/screens/forgot_password/forgot_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ecellapp/core/res/strings.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordCubit(this._forgotPasswordRepository) : super(ForgotInitial());

  void sendOTP(String email) async {
    try {
      emit(ForgotLoading());
      await _forgotPasswordRepository.sendOTP(email);
      emit(ForgotEnterOTP());
    } on NetworkException {
      emit(ForgotNetworkError(S.networkException));
    }
  }

  Future<void> verifyOTP(String a) async {
    emit(ForgotLoading());
    try {
      bool b = await _forgotPasswordRepository.verifyOTP(a);
      if (b) {
        emit(ForgotCreateNewPassword());
      } else {
        emit(ForgotWrongOTP());
      }
    } on NetworkException {
      emit(ForgotNetworkError(S.networkException));
    }
  }

  Future<void> changePassword(String email, String otp, String password) async {
    emit(ForgotLoading());
    try {
      await _forgotPasswordRepository.changePassword(email, otp, password);
      emit(ForgotPasswordSuccess());
    } on NetworkException {
      emit(ForgotNetworkError(S.networkException));
    }
  }
}