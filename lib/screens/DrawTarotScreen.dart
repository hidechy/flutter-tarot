import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import 'package:http/http.dart';

import 'dart:convert';

class DrawTarotScreen extends StatefulWidget {
  @override
  _DrawTarotScreenState createState() => _DrawTarotScreenState();
}

class _DrawTarotScreenState extends State<DrawTarotScreen> {
  String name = "";
  String just_reverse = "";
  String image = "";
  String word = "";
  String msg = "";
  String msg2 = "";
  String msg3 = "";

  /**
   * 初期動作
   */
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /**
   * 初期データ作成
   */
  void _makeDefaultDisplayData() async {
    String url = "http://toyohide.work/BrainLog/api/tarotcard";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);
      name = data['data']['name'];
      just_reverse = data['data']['just_reverse'];
      image =
          "http://toyohide.work/BrainLog/tarotcards/${data['data']['image']}.jpg";
      word = data['data']['word'];
      msg = data['data']['msg'];
      msg2 = data['data']['msg2'];
      msg3 = data['data']['msg3'];
    }

    setState(() {});
  }

  /**
   *
   */
  @override
  Widget build(BuildContext context) {
    int _qt = (just_reverse == "just") ? 0 : 2;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Today\'s Tarot'),
        centerTitle: true,

        //-------------------------//これを消すと「←」が出てくる（消さない）
        leading: Icon(
          Icons.check_box_outline_blank,
          color: Color(0xFF2e2e2e),
        ),
        //-------------------------//これを消すと「←」が出てくる（消さない）

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: Colors.greenAccent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 20),
            child: Column(
              children: <Widget>[
                Text(
                  '${name}',
                  style: TextStyle(fontSize: 30),
                ),
                Text('${just_reverse}'),
                RotatedBox(
                  quarterTurns: _qt,
                  child: Image.network(image),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${word}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${msg}',
                  style: TextStyle(fontSize: 14),
                ),
                const Divider(color: Colors.indigo),
                Container(
                  padding: EdgeInsets.all(10),
                  height: (size.height / 8),
                  child: Text(
                    '${msg2}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const Divider(color: Colors.indigo),
                Container(
                  padding: EdgeInsets.all(10),
                  height: (size.height / 4),
                  child: Text(
                    '${msg3}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
