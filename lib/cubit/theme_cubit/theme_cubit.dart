import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit get(context) => BlocProvider.of<ThemeCubit>(context);

  ThemeMode theme = ThemeMode.dark;
  Color mainColor = Colors.indigo;

  changeTheme({required bool dark}) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Dark', dark);
    if(dark){
      theme = ThemeMode.dark;
      emit(ThemeDark());
    }else{
      theme = ThemeMode.light;
      emit(ThemeLite());
    }
  }

  changeColor({required Color color})async{
    mainColor = color;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Color', color.value);
    emit(ThemeChangeColor());
  }

  getPrefs()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('Dark') != null) {
      bool isDark = prefs.getBool('Dark')!;
      theme = isDark? ThemeMode.dark : ThemeMode.light;
    }
    mainColor = Color(prefs.getInt('Color')?? Colors.indigo.value);
  }
}
