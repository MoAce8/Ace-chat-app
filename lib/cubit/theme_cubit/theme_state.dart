part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeDark extends ThemeState {}

class ThemeLite extends ThemeState {}

class ThemeChangeColor extends ThemeState {}
