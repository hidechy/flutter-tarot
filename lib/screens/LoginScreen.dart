import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';

import '../utilities/utility.dart';

import 'TarotMainScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Utility _utility = Utility();

  String _email = '';
  TextEditingController _teContEmail = TextEditingController();

  String _password = '';
  TextEditingController _teContPassword = TextEditingController();

  String _errorMsg = "";

  /// 初期動作
  @override
  void initState() {
    super.initState();

    _makeDefaultDisplayData();
  }

  /// 初期データ作成
  void _makeDefaultDisplayData() async {
    _teContEmail.text = '';
    _teContPassword.text = '';
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Login'),
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
            onPressed: () => _goLoginScreen(),
            color: Colors.greenAccent,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(context: context),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(fontSize: 13),
                  controller: _teContEmail,
                  onChanged: (value) {
                    setState(
                      () {
                        _email = value;
                      },
                    );
                  },
                ),
                TextField(
                  style: TextStyle(fontSize: 13),
                  controller: _teContPassword,
                  onChanged: (value) {
                    setState(
                      () {
                        _password = value;
                      },
                    );
                  },
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  child: (_errorMsg != "")
                      ? Text(
                          _errorMsg,
                          style: TextStyle(color: Colors.yellowAccent),
                        )
                      : null,
                ),
                ElevatedButton(
                  onPressed: () => _getLoginToken(),
                  child: Text('login'),
                ),
                ElevatedButton(
                  onPressed: () => _setMyAccount(),
                  child: Text('set my account'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent.withOpacity(0.3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  void _getLoginToken() async {
    String url = "http://toyohide.work/BrainLog/api/login";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"email": _email, "password": _password});
    Response response = await post(url, headers: headers, body: body);

    if (response != null) {
      Map data = jsonDecode(response.body);

      if (data['token'] == "") {
        _errorMsg = "login error";
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TarotMainScreen(),
          ),
        );
      }
    }

    setState(() {});
  }

  ///
  void _setMyAccount() {
    _teContEmail.text = "hide.toyoda@gmail.com";
    _teContPassword.text = "Hidechy4819@";

    _email = "hide.toyoda@gmail.com";
    _password = "Hidechy4819@";
  }

  ///
  void _goLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
