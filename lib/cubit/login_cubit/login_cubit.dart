import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  Future<void> loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(LoginFailure(errMessage: 'Wrong email or password.'));
      }else{
        emit(LoginFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'There was an error'));
    }
  }
}
