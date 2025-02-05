import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refresher/models/auth.dart';
import 'package:refresher/models/failure.dart';
import 'package:refresher/services/auth_service.dart';
import 'package:refresher/services/hive_service.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SigninCubit extends Cubit<SignInState> {
  SigninCubit({
    required AuthService authService,
    required HiveService hiveService,
  }) : super(const SignInState.initial()) {
    _authService = authService;
    _hiveService = hiveService;
  }
  late HiveService _hiveService;
  late AuthService _authService;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const SignInState.loading());
    try {
      final token = await _authService.signIn(
        signInDTO: SignInDTO(
          email: email,
          password: password,
        ),
      );

      _hiveService.persistToken(token);

      // Fetch user records using the token
      final user = await _authService.getUser();
      _hiveService.persistUser(user);

      emit(const SignInState.loaded());
    } on Failure catch (e) {
      emit(SignInState.error(e.message));
    } catch (e) {
      emit(const SignInState.error('An unknown error occurred'));
    }
  }
}
