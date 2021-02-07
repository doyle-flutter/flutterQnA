// * 네이버 카페 문의(https://cafe.naver.com/flutterjames)
// : 최대한 다른 내용을 건드리지않고 해당하는 부분만 수정하였습니다 :)
//   영상으로 관련 내용 업로드 할 예정입니다.

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  /// 질문
  /// //////////////////////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////////////////////
  // 기존
  _makingPhoneCall() async {
    const url = 'tel://snap.data["phone"]';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /// 수정 (1) 기본
  _makingPhoneCallUpdate(String phone) async {
    final url = "tel://$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /// 수정 (2) 네이밍 옵션
  _makingPhoneCallUpdate2({String phone}) async {
    final url = "tel://$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /// 수정 (3) 네이밍 옵션 - 필수 입력
  _makingPhoneCallUpdate3({@required String phone}) async {
    final url = "tel://$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /// //////////////////////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////////////////////
  _search() async {
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
      applicationId: '',
      apiKey: '',
    );

    AlgoliaQuery query = algolia.instance.index('firemanager');
    query = query.search(_searchText.text);
    _results = (await query.getObjects()).hits;
    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("찾기"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              controller: _searchText,
              decoration: InputDecoration(hintText: "주소를 입력하세요."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  color: Colors.red,
                  child: Text(
                    "검색",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  onPressed: _search,
                ),
              ],
            ),
            Expanded(
              child: _searching == true
                  ? Center(
                child: Text(
                  "기다려 주세요...",
                  style: TextStyle(fontSize: 16.0),
                ),
              )
                  : _results.length == 0
                  ? Center(
                child: Text(
                  "찾는 주소가 없습니다.",
                  style: TextStyle(fontSize: 16.0),
                ),
              )
                  : ListView.builder(
                itemCount: _results.length,
                itemBuilder: (BuildContext ctx, int index) {
                  AlgoliaObjectSnapshot snap = _results[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                            snap.data["building"],
                            style: TextStyle(fontSize: 18.0),
                          ), //so big text
                          alignment: FractionalOffset.topLeft,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Align(
                          child: Text(snap.data["address"]),
                          alignment: FractionalOffset.topLeft,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Align(
                          child: Text(snap.data["name"]),
                          alignment: FractionalOffset.topLeft,
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                        Align(
                          child: Text(snap.data["phone"]),
                          alignment: FractionalOffset.topLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              /// 질문
                              /// //////////////////////////////////////////////////////////////////////
                              /// //////////////////////////////////////////////////////////////////////
                              //  기존
                              //   onPressed: _makingPhoneCall,
                              /// 수정 (1) 기본
                              ///   onPressed: () => this._makingPhoneCallUpdate(snap.data["phone"].toString()),
                              /// 수정 (2) 네이밍 옵션
                              ///  onPressed: () => this._makingPhoneCallUpdate2(phone: snap.data["phone"].toString()),
                              /// 수정 (3) 네이밍 옵션 - 필수 입력
                              onPressed: () => this._makingPhoneCallUpdate3(phone: snap.data["phone"].toString()),
                              /// //////////////////////////////////////////////////////////////////////
                              /// //////////////////////////////////////////////////////////////////////
                                child: Text(
                                  "전화걸기",
                                  style: TextStyle(
                                      color: Colors.redAccent),
                                ))
                          ],
                        ),
                      ],
                    ),
                  );

                  // return ListTile(
                  //   title: Text(snap.data["name"]),
                  //   subtitle: Text(snap.data["address"]),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
