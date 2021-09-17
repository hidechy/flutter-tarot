import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

import '../utilities/utility.dart';

class Tarot3SpreadScreen extends StatefulWidget {
  @override
  _Tarot3SpreadScreenState createState() => _Tarot3SpreadScreenState();
}

class _Tarot3SpreadScreenState extends State<Tarot3SpreadScreen> {
  Utility _utility = Utility();

  List<Map<dynamic, dynamic>> _spreadData = List();

  String name = "-";
  String just_reverse = "-";

  String prof1 = "-";
  String prof2 = "-";

  String word = "-";
  String msg = "-";
  String msg2 = "-";
  String msg3 = "-";

  int _dispExplanation = 0;

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
    String url = "http://toyohide.work/BrainLog/api/tarotthree";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"number": 3});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      for (var i = 0; i < data['data'].length; i++) {
        Map _map = Map();
        _map['name'] = data['data'][i]['name'];
        _map['image'] =
            "http://toyohide.work/BrainLog/tarotcards/${data['data'][i]['image']}.jpg";
        _map['flag'] = data['data'][i]['image'].replaceAll('big', 'Major');

        _map['reverse'] = data['data'][i]['reverse'];

        _map['prof1'] = data['data'][i]['prof1'];
        _map['prof2'] = data['data'][i]['prof2'];

        _map['word'] = data['data'][i]['word'];
        _map['msg'] = data['data'][i]['msg1'];
        _map['msg2'] = data['data'][i]['msg2'];
        _map['msg3'] = data['data'][i]['msg3'];

        _spreadData.add(_map);
      }
    }

    setState(() {});
  }

  /**
   *
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('3 Spreads'),
        centerTitle: true,

        //-------------------------//これを消すと「←」が出てくる（消さない）
        leading: Icon(
          Icons.check_box_outline_blank,
          color: Color(0xFF2e2e2e),
        ),
        //-------------------------//これを消すと「←」が出てくる（消さない）

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _goTarot3SpreadScreen(),
            color: Colors.greenAccent,
          ),
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
            child: Column(
              children: <Widget>[
                _disp3cards(),
                _dispCardExplanation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /**
   *
   */
  Widget _disp3cards() {
    List<Widget> _list = List();

    Size size = MediaQuery.of(context).size;

    List _midashi1 = List();
    _midashi1.add('過去');
    _midashi1.add('現在');
    _midashi1.add('近未来');

    List _midashi2 = List();
    _midashi2.add('原因');
    _midashi2.add('結果');
    _midashi2.add('アドバイス');

    List _midashi3 = List();
    _midashi3.add('Yes');
    _midashi3.add('Pending');
    _midashi3.add('No');

    for (var i = 0; i < _spreadData.length; i++) {
      _list.add(
        Column(
          children: <Widget>[
            Text('${_midashi1[i]}'),
            Text('${_midashi2[i]}'),
            Text('${_midashi3[i]}'),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () => _changeCardExplanation(index: i),
              child: RotatedBox(
                quarterTurns: (_spreadData[i]['reverse'] == 'just') ? 0 : 2,
                child: Image.network(
                  _spreadData[i]['image'],
                  width: (size.width / 3) - 20,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text('${_spreadData[i]['name']}'),
            Text((_spreadData[i]['reverse'] == 'just') ? '正位置' : '逆位置'),
            Text('${_spreadData[i]['flag']}'),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _list,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.yellowAccent.withOpacity(0.3),
            width: 10,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: 20),
    );
  }

  /**
   *
   */
  void _changeCardExplanation({index}) {
    name = _spreadData[index]['name'];
    just_reverse = _spreadData[index]['reverse'];

    prof1 = _spreadData[index]['prof1'];
    prof2 = _spreadData[index]['prof2'];

    word = _spreadData[index]['word'];

    msg = _spreadData[index]['msg'];
    msg2 = _spreadData[index]['msg2'];
    msg3 = _spreadData[index]['msg3'];

    _dispExplanation = 1;

    setState(() {});
  }

  /**
   *
   */
  Widget _dispCardExplanation() {
    if (_dispExplanation == 0) {
      return Container();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${name}',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${prof1}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${prof2}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Divider(color: Colors.indigo),
          Container(
            alignment: Alignment.topLeft,
            decoration:
                BoxDecoration(color: Colors.greenAccent.withOpacity(0.3)),
            padding: EdgeInsets.only(left: 10),
            child: Text(
              (just_reverse == "just") ? "正位置" : "逆位置",
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${word}',
              style: TextStyle(fontSize: 14, color: Colors.yellowAccent),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              '${msg}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${msg2}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${msg3}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  /**
   *
   */
  void _goTarot3SpreadScreen({id}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Tarot3SpreadScreen(),
      ),
    );
  }
}
