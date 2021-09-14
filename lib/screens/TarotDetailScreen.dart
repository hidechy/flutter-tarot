import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'dart:convert';

import '../utilities/utility.dart';

class TarotDetailScreen extends StatefulWidget {
  final String id;
  TarotDetailScreen({this.id});

  @override
  _TarotDetailScreenState createState() => _TarotDetailScreenState();
}

class _TarotDetailScreenState extends State<TarotDetailScreen> {
  Utility _utility = Utility();

  String name = "";
  String image = "";
  String word = "";
  String msg_j = "";
  String msg_r = "";
  String msg2_j = "";
  String msg2_r = "";
  String msg3_j = "";
  String msg3_r = "";

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
    String url = "http://toyohide.work/BrainLog/api/tarotselect";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"id": widget.id});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      name = data['data']['name'];
      image =
          "http://toyohide.work/BrainLog/tarotcards/${data['data']['image']}.jpg";
      word = data['data']['word'];
      msg_j = data['data']['msg_j'];
      msg_r = data['data']['msg_r'];
      msg2_j = data['data']['msg2_j'];
      msg2_r = data['data']['msg2_r'];
      msg3_j = data['data']['msg3_j'];
      msg3_r = data['data']['msg3_r'];
    }

    setState(() {});
  }

  /**
   *
   */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${name}'),
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
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 20),
                child: Column(
                  children: <Widget>[
                    Image.network(image),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${word}',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Divider(color: Colors.indigo),
                    Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.3)),
                      padding: EdgeInsets.only(left: 10),
                      child: Text('正位置'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${msg_j}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${msg2_j}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${msg3_j}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const Divider(color: Colors.indigo),
                    Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.3)),
                      padding: EdgeInsets.only(left: 10),
                      child: Text('逆位置'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${msg_r}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${msg2_r}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${msg3_r}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
