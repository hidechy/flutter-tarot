import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'dart:convert';

import '../utilities/utility.dart';

import 'TarotDetailScreen.dart';

class DrawTarotHistoryScreen extends StatefulWidget {
  @override
  _DrawTarotHistoryScreenState createState() => _DrawTarotHistoryScreenState();
}

class _DrawTarotHistoryScreenState extends State<DrawTarotHistoryScreen> {
  Utility _utility = Utility();

  List<Map<dynamic, dynamic>> _historyData = [];

  final List<Map<dynamic, dynamic>> _ymList = [];

  final ItemScrollController _itemScrollController = ItemScrollController();

  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  int maxNo = 0;

  /// 初期動作
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /// 初期データ作成
  void _makeDefaultDisplayData() async {
    String url = "http://toyohide.work/BrainLog/api/tarothistory";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      var _ym = "";
      for (var i = 0; i < data['data'].length; i++) {
        Map _map = Map();
        _map['year'] = data['data'][i]['year'];
        _map['month'] = data['data'][i]['month'];
        _map['day'] = data['data'][i]['day'];

        if ("${data['data'][i]['year']}-${data['data'][i]['month']}" != _ym) {
          Map _map = {};
          _map['ym'] = "${data['data'][i]['year']}-${data['data'][i]['month']}";
          _map['pos'] = i;
          _ymList.add(_map);
        }

        _map['id'] = data['data'][i]['id'];
        _map['name'] = data['data'][i]['name'];

        _map['image'] =
            "http://toyohide.work/BrainLog/tarotcards/${data['data'][i]['image']}.jpg";

        _map['reverse'] = data['data'][i]['reverse'];

        _map['word'] = data['data'][i]['word'];

        _historyData.add(_map);

        _ym = "${data['data'][i]['year']}-${data['data'][i]['month']}";
      }
    }

    print(_ymList);

    setState(() {});
  }

  ///
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
          Column(
            children: [
              Expanded(
                child: _tarotList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget _tarotList() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
          ),
          child: Wrap(
            children: _makeYmBtn(),
          ),
        ),
        const Divider(color: Colors.indigo),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemBuilder: (context, index) {
              return _listItem(position: index);
            },
            itemCount: _historyData.length,
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
          ),
        ),
      ],
    );
  }

  /// リストアイテム表示
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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _goTarotDetailScreen(
                  id: _historyData[position]['id'].toString()),
              child: Icon(
                Icons.comment,
                color: Colors.greenAccent,
                size: 20,
              ),
            ),
            Text(
              _historyData[position]['id'].toString(),
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  ///
  List<Widget> _makeYmBtn() {
    List<Widget> _btnList = [];
    for (var i = 0; i < _ymList.length; i++) {
      _btnList.add(
        GestureDetector(
          onTap: () => _scroll(
            pos: _ymList[i]['pos'],
            year: _ymList[i]['ym'],
          ),
          child: Container(
            color: Colors.green[900].withOpacity(0.5),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: Text(
              '${_ymList[i]['ym']}',
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
    }
    return _btnList;
  }

  ///
  void _scroll({int pos, String year}) {
    _itemScrollController.scrollTo(
      index: pos,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );

    setState(() {});
  }

  ///
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
