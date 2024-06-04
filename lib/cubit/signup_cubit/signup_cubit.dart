import 'package:ace_chat_app/firebase/fire_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of<SignupCubit>(context);

  Future<void> createNewUser(
      {required String email,
      required String password,
      required String name}) async {
    emit(SignupLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => FireAuth.createUser(name: name));
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(
            errMessage: 'The account already exists for that email.'));
      } else {
        emit(SignupFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(SignupFailure(errMessage: 'There was an error'));
    }
  }
}
