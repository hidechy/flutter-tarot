import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

import '../utilities/utility.dart';

import 'TarotDetailScreen.dart';

class DrawTarotHistoryScreen extends StatefulWidget {
  @override
  _DrawTarotHistoryScreenState createState() => _DrawTarotHistoryScreenState();
}

class _DrawTarotHistoryScreenState extends State<DrawTarotHistoryScreen> {
  Utility _utility = Utility();

  List<Map<dynamic, dynamic>> _historyData = List();

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
    String url = "http://toyohide.work/BrainLog/api/tarothistory";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      for (var i = 0; i < data['data'].length; i++) {
        Map _map = Map();
        _map['year'] = data['data'][i]['year'];
        _map['month'] = data['data'][i]['month'];
        _map['day'] = data['data'][i]['day'];

        _map['id'] = data['data'][i]['id'];
        _map['name'] = data['data'][i]['name'];

        _map['image'] =
            "http://toyohide.work/BrainLog/tarotcards/${data['data'][i]['image']}.jpg";

        _map['reverse'] = data['data'][i]['reverse'];

        _map['word'] = data['data'][i]['word'];

        _historyData.add(_map);
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
        title: Text('Tarot Draw History'),
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
          Container(
            child: _tarotHistoryList(),
          ),
        ],
      ),
    );
  }

  /**
   * リスト表示
   */
  Widget _tarotHistoryList() {
    return ListView.builder(
      itemCount: _historyData.length,
      itemBuilder: (context, int position) {
        return _listItem(position: position);
      },
    );
  }

  /**
   * リストアイテム表示
   */
  Widget _listItem({int position}) {
    int _qt = (_historyData[position]['reverse'] == '0') ? 0 : 2;

    return Card(
      color: Colors.black.withOpacity(0.1),
      child: ListTile(
        leading: RotatedBox(
          quarterTurns: _qt,
          child: Image.network(_historyData[position]['image']),
        ),
        title: DefaultTextStyle(
          style: TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: Text(
                    '${_historyData[position]['year']}/${_historyData[position]['month']}/${_historyData[position]['day']}'),
              ),
              (_historyData[position]['reverse'] == '0')
                  ? Text(
                      '${_historyData[position]['name']} : just',
                      style: TextStyle(fontSize: 16),
                    )
                  : Text(
                      '${_historyData[position]['name']} : reverse',
                      style: TextStyle(fontSize: 16),
                    ),
              Text('${_historyData[position]['word']}'),
            ],
          ),
        ),
        trailing: GestureDetector(
          onTap: () =>
              _goTarotDetailScreen(id: _historyData[position]['id'].toString()),
          child: Icon(
            Icons.comment,
            color: Colors.greenAccent,
            size: 20,
          ),
        ),
      ),
    );
  }

  /**
   *
   */
  void _goTarotDetailScreen({id}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TarotDetailScreen(
          id: id,
        ),
      ),
    );
  }
}
