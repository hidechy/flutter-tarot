import 'package:flutter/material.dart';

class Utility {
  /// 背景取得
  Widget getBackGround({context}) {
    return Image.asset(
      'assets/image/bg.jpg',
      fit: BoxFit.fitHeight,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}
