import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

import '../utilities/utility.dart';

class DrawTarotScreen extends StatefulWidget {
  @override
  _DrawTarotScreenState createState() => _DrawTarotScreenState();
}

class _DrawTarotScreenState extends State<DrawTarotScreen> {
  Utility _utility = Utility();

  String name = "";
  String justReverse = "";
  String image = "";
  String word = "";
  String msg = "";
  String msg2 = "";
  String msg3 = "";

  String prof1 = "";
  String prof2 = "";

  String flag = "";

  /// 初期動作
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /// 初期データ作成
  void _makeDefaultDisplayData() async {
    String url = "http://toyohide.work/BrainLog/api/tarotcard";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);
      name = data['data']['name'];
      justReverse = data['data']['just_reverse'];
      image =
          "http://toyohide.work/BrainLog/tarotcards/${data['data']['image']}.jpg";

      flag = data['data']['image'].replaceAll('big', 'Major');

      word = data['data']['word'];
      msg = data['data']['msg'];
      msg2 = data['data']['msg2'];
      msg3 = data['data']['msg3'];

      prof1 = data['data']['prof1'];
      prof2 = data['data']['prof2'];
    }

    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    int _qt = (justReverse == "just") ? 0 : 2;

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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _utility.getBackGround(context: context),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent.withOpacity(0.3)),
                        child: Text(flag),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 30),
                  ),
                  RotatedBox(
                    quarterTurns: _qt,
                    child: Image.network(image),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      prof1,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      prof2,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const Divider(color: Colors.indigo),
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.3)),
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      (justReverse == "just") ? "正位置" : "逆位置",
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      word,
                      style:
                          TextStyle(fontSize: 14, color: Colors.yellowAccent),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      msg,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      msg2,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      msg3,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
