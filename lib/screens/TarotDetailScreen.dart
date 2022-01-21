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

  List<Map<dynamic, dynamic>> _tarotData = [];

  final PageController pageController = PageController();

  // ページインデックス
  int currentPage = 0;

  /// 初期動作
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /// 初期データ作成
  void _makeDefaultDisplayData() async {
    String url = "http://toyohide.work/BrainLog/api/getAllTarot";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"id": widget.id});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      for (var i = 0; i < data['data'].length; i++) {
        Map _map = Map();
        _map['name'] = data['data'][i]['name'];
        _map['image'] =
            "http://toyohide.work/BrainLog/tarotcards/${data['data'][i]['image']}.jpg";
        _map['flag'] = data['data'][i]['image'].replaceAll('big', 'Major');

        _map['prof1'] = data['data'][i]['prof1'];
        _map['prof2'] = data['data'][i]['prof2'];

        _map['word_j'] = data['data'][i]['word_j'];
        _map['msg_j'] = data['data'][i]['msg_j'];
        _map['msg2_j'] = data['data'][i]['msg2_j'];
        _map['msg3_j'] = data['data'][i]['msg3_j'];

        _map['word_r'] = data['data'][i]['word_r'];
        _map['msg_r'] = data['data'][i]['msg_r'];
        _map['msg2_r'] = data['data'][i]['msg2_r'];
        _map['msg3_r'] = data['data'][i]['msg3_r'];

        _tarotData.add(_map);
      }
    }

    pageController.jumpToPage(int.parse(widget.id) - 1);

    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Tarot Detail'),
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
          PageView.builder(
            controller: pageController,
            itemCount: _tarotData.length,
            itemBuilder: (context, index) {
              //--------------------------------------// リセット
              bool active = (index == currentPage);
              if (active == false) {}
              //--------------------------------------//

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: dispTarotDetail(index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ///
  Widget dispTarotDetail(int index) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                decoration:
                    BoxDecoration(color: Colors.yellowAccent.withOpacity(0.3)),
                child: Text('${_tarotData[index]['flag']}'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${_tarotData[index]['name']}',
            style: TextStyle(fontSize: 30),
          ),
          Image.network(_tarotData[index]['image']),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${_tarotData[index]['prof1']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${_tarotData[index]['prof2']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Divider(color: Colors.indigo),
          Container(
            alignment: Alignment.topLeft,
            decoration:
                BoxDecoration(color: Colors.greenAccent.withOpacity(0.3)),
            padding: EdgeInsets.only(left: 10),
            child: Text('正位置'),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${_tarotData[index]['word_j']}',
              style: TextStyle(fontSize: 14, color: Colors.yellowAccent),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              '${_tarotData[index]['msg_j']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${_tarotData[index]['msg2_j']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${_tarotData[index]['msg3_j']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Divider(color: Colors.indigo),
          Container(
            alignment: Alignment.topLeft,
            decoration:
                BoxDecoration(color: Colors.greenAccent.withOpacity(0.3)),
            padding: EdgeInsets.only(left: 10),
            child: Text('逆位置'),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '${_tarotData[index]['word_r']}',
              style: TextStyle(fontSize: 14, color: Colors.yellowAccent),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              '${_tarotData[index]['msg_r']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${_tarotData[index]['msg2_r']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${_tarotData[index]['msg3_r']}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
