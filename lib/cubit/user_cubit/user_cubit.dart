import 'package:ace_chat_app/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  late final UserModel user;

  getUserInfo() async {
    emit(UserLoading());
    try {
      final String myId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .get()
          .then((value) => user = UserModel.fromJson(value.data()),);
      emit(UserGotInfo());
    } catch (e) {
      emit(UserFailure());
    }
  }
}
