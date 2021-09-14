import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class Utility {
  /**
   * 背景取得
   */
  Widget getBackGround({context}) {
    Size size = MediaQuery.of(context).size;

    return Image.asset(
      'assets/image/bg.jpg',
      fit: BoxFit.fitHeight,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}
