import 'package:ansicolor/ansicolor.dart';

import 'package:inappwebview_test/helpers/rgbColor.dart';

/// 指定 console 訊息的顏色，顏色為自定的 RGBColor 型態（預設值為 RGB 綠色）
String colorMsg(String msg, {RGBColor color = const RGBColor(r: 0, g: 255, b: 0)})
{
    double red = color.r.toDouble() / 255;
    double green = color.g.toDouble() / 255;
    double blue = color.b.toDouble() / 255;

    AnsiPen pen = AnsiPen()..rgb(r: red, g: green, b: blue);

    return pen(msg);
}
