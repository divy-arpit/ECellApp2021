import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/screens/forgot_password/forgot_password_repo.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordCubit(this._forgotPasswordRepository) : super(ForgotPasswordInitial());

  void generateOTPInCubit(String email) async {
    try {
      emit(ForgotPasswordLoading());
      int x = await _forgotPasswordRepository.generateOTP(email);
    } on NetworkException {
      emit(ForgotPasswordError());
    }
  }

  Future<int> verifyOTP(int a) async {
    _forgotPasswordRepository.VerifyOTP(a);
  }
}
