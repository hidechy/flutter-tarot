import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'dart:convert';

import '../utilities/utility.dart';

import 'DrawTarotHistoryScreen.dart';
import 'Tarot3SpreadScreen.dart';
import 'TarotDetailScreen.dart';
import 'DrawTarotScreen.dart';

class TarotMainScreen extends StatefulWidget {
  TarotMainScreen({Key key}) : super(key: key);

  @override
  _TarotMainScreenState createState() => _TarotMainScreenState();
}

class _TarotMainScreenState extends State<TarotMainScreen> {
  Utility _utility = Utility();

  List<Map<dynamic, dynamic>> _tarotCups = [];
  List<Map<dynamic, dynamic>> _tarotWands = [];
  List<Map<dynamic, dynamic>> _tarotPentacles = [];
  List<Map<dynamic, dynamic>> _tarotSwords = [];
  List<Map<dynamic, dynamic>> _tarotBigs = [];

  /// 初期動作
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /// 初期データ作成
  void _makeDefaultDisplayData() async {
    //------------------------// cups
    String url = "http://toyohide.work/BrainLog/api/tarotcategory";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"category": "cups"});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      for (var i1 = 0; i1 < data['data'].length; i1++) {
        var exData1 = (data['data'][i1]).split(':');

        Map _map1 = Map();
        _map1['id'] = exData1[0];
        _map1['name'] = exData1[1];
        _tarotCups.add(_map1);
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
        var exData2 = (data2['data'][i2]).split(':');

        Map _map2 = Map();
        _map2['id'] = exData2[0];
        _map2['name'] = exData2[1];
        _tarotWands.add(_map2);
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
        var exData3 = (data3['data'][i3]).split(':');

        Map _map3 = Map();
        _map3['id'] = exData3[0];
        _map3['name'] = exData3[1];
        _tarotPentacles.add(_map3);
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
        var exData4 = (data4['data'][i4]).split(':');

        Map _map4 = Map();
        _map4['id'] = exData4[0];
        _map4['name'] = exData4[1];
        _tarotSwords.add(_map4);
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
        var exData5 = (data5['data'][i5]).split(':');

        Map _map5 = Map();
        _map5['id'] = exData5[0];
        _map5['name'] = exData5[1];
        _tarotBigs.add(_map5);
      }
    }
    //------------------------// swords

    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Tarot Card'),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: () => _goDrawTarotScreen(),
                        child: Text(
                          'Get Today\'s Fortune.',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () => _goDrawTarotHistoryScreen(),
                        child: Text(
                          'History',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () => _goTarot3SpreadScreen(),
                        child: Text(
                          '3 spreads',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellowAccent.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.indigo),
                _dispCards(category: ""),
                const Divider(color: Colors.indigo),
                _dispCards(category: "Cups"),
                const Divider(color: Colors.indigo),
                _dispCards(category: "Pentacles"),
                const Divider(color: Colors.indigo),
                _dispCards(category: "Swords"),
                const Divider(color: Colors.indigo),
                _dispCards(category: "Wands"),
                SizedBox(
                  height: (size.height / 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _dispCards({String category}) {
    List<Widget> _list = [];

    Size size = MediaQuery.of(context).size;

    List<Map> data = [];
    int devide = 4;
    switch (category) {
      case "Cups":
        data = _tarotCups;
        break;
      case "Pentacles":
        data = _tarotPentacles;
        break;
      case "Swords":
        data = _tarotSwords;
        break;
      case "Wands":
        data = _tarotWands;
        break;
      default:
        data = _tarotBigs;
        devide = 2;
        break;
    }

    for (var i = 0; i < data.length; i++) {
      _list.add(
        Container(
          width: (size.width / devide) - 10,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
            onPressed: () => _goTarotDetailScreen(id: data[i]['id']),
            child: Text(
              '${data[i]['name']}',
              style: TextStyle(fontSize: 10),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent.withOpacity(0.6),
            ),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        (category != "")
            ? Container(
                alignment: Alignment.topLeft,
                decoration:
                    BoxDecoration(color: Colors.greenAccent.withOpacity(0.3)),
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Text(category),
              )
            : Container(),
        (category != "")
            ? _dispCategoryExplanation(category: category)
            : Container(),
        Wrap(
          children: _list,
        ),
      ],
    );
  }

  ///
  Widget _dispCategoryExplanation({String category}) {
    var _cateMsg1 = "";
    var _cateMsg2 = "";
    switch (category) {
      case "Cups":
        _cateMsg1 = "形なく流れる愛や情感を表す";
        _cateMsg2 =
            "液体を注ぐ道具であるカップ。「聖杯」の名の通り、神に捧げものをする儀式や、杯を交わして契りを結ぶ婚姻の儀式など、様々な場面で聖なるアイテムとして使われてきました。エレメントでは水に対応します。形がなく流動的にどんな場所にも染み込む水は、豊かな情感を表します。カップに注がれている水がどのようになっているか、カードを確認してみましょう。";
        break;
      case "Pentacles":
        _cateMsg1 = "物やお金がもたらす、たくさんの豊かさ";
        _cateMsg2 =
            "ペンタクルとは、人間が作り出した金貨のこと。それによって様々な価値を交換し合うことが可能になり、自分の力だけでは得られない、他の人が作った様々な豊かさを味わえるようになりました。エレメントでは地に対応し、お金に限らず、現実に存在する全ての物質を表します。財産や家、持ち物、肉体…日常のあらゆる面で人間を支えるもの。これなくして生活は成り立ちません。";
        break;
      case "Swords":
        _cateMsg1 = "知性と言葉によるコミュニケーション";
        _cateMsg2 =
            "ソードは石や金属加工の技術が確立してから生まれた道具です。つまり人類の知恵の象徴と言えるでしょう。ものを切る便利な道具であると同時に、人間を傷つける恐れもある、怖い道具です。エレメントでは風に対応します。風は知性や言語も象徴します。ソードは肉体に傷を負わせるだけではありません。言葉や策略もまた、精神的に傷つける、見えない刃になると考えるのです。";
        break;
      case "Wands":
        _cateMsg1 = "人間の生命力と行動力、生きる力を支える";
        _cateMsg2 =
            "ワンドとは棍棒のことで、人類が最も古くから用いてきた道具です。食事の際の火おこしに用いたり、護身用の武器となったり、住居を作る材料となったりしてきました。人類の衣食住、生命を支える、最も重要なアイテムと言えるでしょう。エレメントでは火に対応し、人間の生命力や、「何かをやりたい」という情熱、「打ち勝って手に入れたい」という闘争心を表します。";
        break;
    }

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_cateMsg1),
          Text(_cateMsg2),
        ],
      ),
    );
  }

  ///
  void _goDrawTarotScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrawTarotScreen(),
      ),
    );
  }

  ///
  void _goDrawTarotHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrawTarotHistoryScreen(),
      ),
    );
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

  ///
  void _goTarot3SpreadScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tarot3SpreadScreen(),
      ),
    );
  }
}
