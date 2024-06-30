import 'package:ace_chat_app/firebase/fire_auth.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  late UserModel user;

  getUserInfo() async {
    Future.delayed(const Duration(seconds: 1),() async{
      emit(UserLoading());
      try {
        final String myId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('users').doc(myId).get().then(
              (value) => user = UserModel.fromJson(value.data()),
        );
        FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getToken().then((value) {
          if(value != null){
            updateUser(token: value);
            FireAuth().updateToken(value);
          }
        },);
        emit(UserGotInfo());
      } catch (e) {
        emit(UserFailure());
      }
    },);
  }

  updateUser({String? image, String? name, String? about, String? token}) {
    user =
        user.copyWith(image: image, name: name, about: about, pushToken: token);
    emit(UserProfileUpdated());
  }
}
