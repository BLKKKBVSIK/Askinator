import 'dart:ui';

class ColorTheme {
  final Color primary;
  final Color primaryVariant;

  final Color secondary;
  final Color secondaryVariant;

  final Color neutral;

  final Color background;
  final Color onBackground;

  ColorTheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.neutral,
    required this.background,
    required this.onBackground,
  });

  static ColorTheme get theme => ColorTheme._themeA();

  ColorTheme._themeA()
      : primary = const Color(0xff63539c),
        primaryVariant = const Color(0xff45a8d0),
        secondary = const Color(0xffff9a84),
        secondaryVariant = const Color(0xffd14c85),
        neutral = const Color(0xff05091d),
        background = const Color(0xff1d1d1d),
        onBackground = const Color(0xffffffff);

  ColorTheme._themeB()
      : primary = const Color(0xffe26b07),
        primaryVariant = const Color(0xfff1a73a),
        secondary = const Color(0xff9451bb),
        secondaryVariant = const Color(0xff853174),
        neutral = const Color(0xff59351c),
        background = const Color(0xff1d1d1d),
        onBackground = const Color(0xffffffff);

  ColorTheme._themeC()
      : primary = const Color(0xff8a4985),
        primaryVariant = const Color(0xff925aa2),
        secondary = const Color(0xfffd6924),
        secondaryVariant = const Color(0xffe44d19),
        neutral = const Color(0xffcc021a),
        background = const Color(0xff1d1d1d),
        onBackground = const Color(0xffffffff);
}
