// Import Flutter material package
import 'package:flutter/material.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenBreakpoints {
  static const double mobile = 600.0;  // Mobile breakpoint (e.g., width < 600 for small devices)
  static const double tablet = 768.0;  // Tablet breakpoint
  static const double desktop = 1024.0; // Desktop breakpoint
}
// Define MyTextStyles class
class MyTextStyles {

  static TextStyle bekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      color: AppColors.darkshade,
    );
  }



  static TextStyle nagybekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 18.0;
    } else {
      fontSize = 20.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle nagybekezdesappbar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle bluebekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.blueish,
    );
  }

  static TextStyle nemferde_bekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle huszonkettobekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 20.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 22.0;
    } else {
      fontSize = 24.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle huszonegybekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 19.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 21.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle vastagbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.darkshade,
    );
  }

  static TextStyle vastagblueish(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blueish,
    );
  }

  static TextStyle vastagblue(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blue,
    );
  }

  static TextStyle vastaggreenish(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle vastagyellow(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.yellow,
    );
  }

  static TextStyle vastaggreen(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle huszonkettovastagyellow(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 20.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 22.0;
    } else {
      fontSize = 24.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.yellow,
    );
  }

  static TextStyle huszonkettovastaggreen(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 20.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 22.0;
    } else {
      fontSize = 24.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle vastagnagybekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 18.0;
    } else {
      fontSize = 20.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.darkshade,
    );
  }

  static TextStyle feherbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.lightshade,
    );
  }

  static TextStyle cim(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 18.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 20.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.bethesdacolor,
    );
  }

  static TextStyle bethesdabekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 18.0;
    } else {
      fontSize = 20.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.bethesdacolor,
    );
  }

  static TextStyle lightbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 18.0;
    } else {
      fontSize = 20.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.lightaccentcolor,
    );
  }

  static TextStyle bethesdavastagbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 18.0;
    } else {
      fontSize = 20.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.bethesdacolor,
    );
  }

  static TextStyle fehercim(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 18.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 20.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.whitewhite,
    );
  }

  static TextStyle feherkovercim(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 18.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 20.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.whitewhite,
    );
  }

  static TextStyle feherkicsikovercim(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 14.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 16.0;
    } else {
      fontSize = 18.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.whitewhite,
    );
  }

  static TextStyle gomb(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 20.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.whitewhite,
    );
  }

  static TextStyle szinesgomb(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 16.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 20.0;
    } else {
      fontSize = 22.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.lightaccentcolor,
    );
  }

  static TextStyle bethesdagomb(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 22.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 24.0;
    } else {
      fontSize = 26.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.bethesdacolor,
    );
  }

  static TextStyle bethesdagomb_lila(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 22.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 24.0;
    } else {
      fontSize = 26.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blueish,
    );
  }

  static TextStyle bethesdagomb_zold(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 22.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 24.0;
    } else {
      fontSize = 26.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle bethesdagomb_kek(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 22.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 24.0;
    } else {
      fontSize = 26.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blue,
    );
  }

  static TextStyle bluegomb(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 20.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 22.0;
    } else {
      fontSize = 24.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blueish,
    );
  }

  static TextStyle greengomb(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 20.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 22.0;
    } else {
      fontSize = 24.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle kicsibekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.darkshade,
    );
  }

  static TextStyle kicsibekezdes2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: Colors.grey,
    );
  }

  static TextStyle kicsibluebekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.blueish,
    );
  }

  static TextStyle kicsigreenbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.greenish,
    );
  }

  static TextStyle kicsiszinesbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.lightaccentcolor,
    );
  }

  static TextStyle kicsisbethesdabekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.bethesdacolor,
    );
  }

  static TextStyle kicsisbluebekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.blue,
    );
  }

  static TextStyle kicsislightbekezdes(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize;

    if (screenWidth < ScreenBreakpoints.mobile) {
      fontSize = 12.0;
    } else if (screenWidth < ScreenBreakpoints.desktop) {
      fontSize = 14.0;
    } else {
      fontSize = 16.0;
    }

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: fontSize,
      color: AppColors.lightaccentcolor,
    );
  }
}
