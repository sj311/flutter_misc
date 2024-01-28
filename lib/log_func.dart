import 'package:sprintf/sprintf.dart';

enum LogColor {
  // italic and blink may not work depending of your terminal
  bold,dark,italic,underline,blink,reverse,concealed,

  // foreground colors
  black, red,green,yellow,blue,magenta,cyan,white,

  // background colors
  // ignore: constant_identifier_names
  bg_black,bg_red,bg_green,bg_yellow,bg_blue,bg_magenta,bg_cyan,bg_white
}

void logcolor(LogColor clr, String log){
    const Map<LogColor,String> colorFormats = {
        // styles
        // italic and blink may not work depending of your terminal
        LogColor.bold : "\x1b[1m%s\x1b[0m",
        LogColor.dark : "\x1b[2m%s\x1b[0m",
        LogColor.italic : "\x1b[3m%s\x1b[0m",
        LogColor.underline : "\x1b[4m%s\x1b[0m",
        LogColor.blink : "\x1b[5m%s\x1b[0m",
        LogColor.reverse : "\x1b[7m%s\x1b[0m",
        LogColor.concealed : "\x1b[8m%s\x1b[0m",
                // foreground colors
        LogColor.black : "\x1b[30m%s\x1b[0m",
        LogColor.red : "\x1b[31m%s\x1b[0m",
        LogColor.green : "\x1b[32m%s\x1b[0m",
        LogColor.yellow : "\x1b[33m%s\x1b[0m",
        LogColor.blue : "\x1b[34m%s\x1b[0m",
        LogColor.magenta : "\x1b[35m%s\x1b[0m",
        LogColor.cyan : "\x1b[36m%s\x1b[0m",
        LogColor.white : "\x1b[37m%s\x1b[0m",
                // background colors
        LogColor.bg_black : "\x1b[40m%s\x1b[0m",
        LogColor.bg_red : "\x1b[41m%s\x1b[0m",
        LogColor.bg_green : "\x1b[42m%s\x1b[0m",
        LogColor.bg_yellow : "\x1b[43m%s\x1b[0m",
        LogColor.bg_blue : "\x1b[44m%s\x1b[0m",
        LogColor.bg_magenta : "\x1b[45m%s\x1b[0m",
        LogColor.bg_cyan : "\x1b[46m%s\x1b[0m",
        LogColor.bg_white : "\x1b[47m%s\x1b[0m",
    };

    print(sprintf(colorFormats[clr]!, [log]));
}