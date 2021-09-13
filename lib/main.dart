import 'package:flutter/material.dart';
import 'package:tarotcard/screens/DrawTarotScreen.dart';

import 'package:http/http.dart';

import 'dart:convert';

import 'package:tarotcard/screens/TarotDetailScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'Tarot Card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<dynamic, dynamic>> _tarot_cups = List();
  List<Map<dynamic, dynamic>> _tarot_wands = List();
  List<Map<dynamic, dynamic>> _tarot_pentacles = List();
  List<Map<dynamic, dynamic>> _tarot_swords = List();
  List<Map<dynamic, dynamic>> _tarot_bigs = List();

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
    //------------------------// cups
    String url = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"category": "cups"});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      for (var i1 = 0; i1 < data['data'].length; i1++) {
        var ex_data1 = (data['data'][i1]).split(':');

        Map _map1 = Map();
        _map1['id'] = ex_data1[0];
        _map1['name'] = ex_data1[1];
        _tarot_cups.add(_map1);
      }
    }
    //------------------------// cups

    //------------------------// wands
    String url2 = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers2 = {'content-type': 'application/json'};
    String body2 = json.encode({"category": "wands"});
    Response response2 = await post(url2, headers: headers2, body: body2);

    if (response2 != null) {
      Map data2 = jsonDecode(response2.body);

      for (var i2 = 0; i2 < data2['data'].length; i2++) {
        var ex_data2 = (data2['data'][i2]).split(':');

        Map _map2 = Map();
        _map2['id'] = ex_data2[0];
        _map2['name'] = ex_data2[1];
        _tarot_wands.add(_map2);
      }
    }
    //------------------------// wands

    //------------------------// pentacles
    String url3 = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers3 = {'content-type': 'application/json'};
    String body3 = json.encode({"category": "pentacles"});
    Response response3 = await post(url3, headers: headers3, body: body3);

    if (response3 != null) {
      Map data3 = jsonDecode(response3.body);

      for (var i3 = 0; i3 < data3['data'].length; i3++) {
        var ex_data3 = (data3['data'][i3]).split(':');

        Map _map3 = Map();
        _map3['id'] = ex_data3[0];
        _map3['name'] = ex_data3[1];
        _tarot_pentacles.add(_map3);
      }
    }
    //------------------------// pentacles

    //------------------------// swords
    String url4 = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers4 = {'content-type': 'application/json'};
    String body4 = json.encode({"category": "swords"});
    Response response4 = await post(url4, headers: headers4, body: body4);

    if (response4 != null) {
      Map data4 = jsonDecode(response4.body);

      for (var i4 = 0; i4 < data4['data'].length; i4++) {
        var ex_data4 = (data4['data'][i4]).split(':');

        Map _map4 = Map();
        _map4['id'] = ex_data4[0];
        _map4['name'] = ex_data4[1];
        _tarot_swords.add(_map4);
      }
    }
    //------------------------// swords

    //------------------------// big
    String url5 = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers5 = {'content-type': 'application/json'};
    String body5 = json.encode({"category": "big"});
    Response response5 = await post(url5, headers: headers5, body: body5);

    if (response5 != null) {
      Map data5 = jsonDecode(response5.body);

      for (var i5 = 0; i5 < data5['data'].length; i5++) {
        var ex_data5 = (data5['data'][i5]).split(':');

        Map _map5 = Map();
        _map5['id'] = ex_data5[0];
        _map5['name'] = ex_data5[1];
        _tarot_bigs.add(_map5);
      }
    }
    //------------------------// swords

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
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: RaisedButton(
                child: Text('Get Today\'s Fortune.'),
                onPressed: () => _goDrawTarotScreen(),
              ),
            ),
            const Divider(color: Colors.indigo),
            _dispCards(data: _tarot_bigs),
            const Divider(color: Colors.indigo),
            _dispCards(data: _tarot_cups),
            const Divider(color: Colors.indigo),
            _dispCards(data: _tarot_pentacles),
            const Divider(color: Colors.indigo),
            _dispCards(data: _tarot_swords),
            const Divider(color: Colors.indigo),
            _dispCards(data: _tarot_wands),
            SizedBox(
              height: (size.height / 10),
            )
          ],
        ),
      ),
    );
  }

  /**
   *
   */
  Widget _dispCards({List<Map> data}) {
    List<Widget> _list = List();

    Size size = MediaQuery.of(context).size;

    for (var i = 0; i < data.length; i++) {
      _list.add(
        Container(
          width: (size.width / 2) - 20,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: RaisedButton(
            child: Text(
              '${data[i]['name']}',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () => _goTarotDetailScreen(id: data[i]['id']),
          ),
        ),
      );
    }

    return Wrap(
      children: _list,
    );
  }

  /**
   *
   */
  void _goDrawTarotScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrawTarotScreen(),
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
