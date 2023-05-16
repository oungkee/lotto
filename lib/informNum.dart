import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http 패키지 추가.
// import 'package:html/dom.dart' as dom; //웹 크롤링을 위한 dom 패키지 추가.
// import 'package:html/parser.dart' as parse; //웹 크롤링을 위한 parse 패키지 추가.
import 'dart:convert'; // json을 수동으로 직렬화 시키기 위해 convert 패키지 추가.
import 'dart:async';
import 'wgseo_module.dart';
import 'cp949_uni_conversion.dart';

class informNum extends StatefulWidget {
  const informNum({Key? key}) : super(key: key);

  @override
  State<informNum> createState() => _informNumState();
}

class _informNumState extends State<informNum> {
  var nowGameNo = '';
  var data = {};
  @override
  void initState() {
    super.initState();
    // data = ;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Lotto Result numbers',
          style: TextStyle(fontSize: 20),
        ),

        Text('현재 추첨 회차는 ${data['drwNoDate'].toString()} 회 입니다'),

        ElevatedButton(
            onPressed: () {
              getJSONData(nowGameNo);
            },
            child: Text('ddd')),

        wgseo_Sized_Heigh(),

        FutureBuilder(
            future: fetchNowGameNo(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                nowGameNo = snapshot.data.toString();
                return Text('최종 추첨 회차는 ${snapshot.data.toString()}회 입니다.');
              }
            }),

        wgseo_Sized_Heigh(),
        // FutureBuilder 예시 코드
        FutureBuilder(
            future: fetchPost(nowGameNo),
            builder: (context, snapshot) {
              // 해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
              if (snapshot.hasData == false) {
                return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
              }

              // error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // 에러명을 텍스트에 뿌려줌
              }

              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
              else {
                return Text(snapshot.data.toString());
              }
            }),
      ],
    ));
  }

  Future<String> fetchNowGameNo() async {
    //현재의 추첨회차를 읽어온다.
    // await Future.delayed(
    //     const Duration(milliseconds: 2)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.

    final response = await http
        .get(Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin'));

    var tempStr = cp949toUni(response.body.codeUnits);

    var resultNo = tempStr.substring(
        tempStr.indexOf(
              'content="동행복권 ',
            ) +
            14,
        tempStr.indexOf('회 당첨번호'));

    return resultNo;
  }

  Future<void> getJSONData(String tempNo) async {
    final response = await http.get(Uri.parse(
        'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$tempNo'));
    if (response.statusCode == 200) {
      setState(() {
        var dataConvertedToJSON = json.decode(response.body);
        // data List 초기화.
        data = {};
        // List 변수에 해당 당첨번호를 입력한다.
        data['drwNoDate'] = dataConvertedToJSON['drwNoDate'];
        data['drwNo'] = dataConvertedToJSON['drwNo'];
        data['drwtNo1'] = dataConvertedToJSON['drwtNo1'];
        data['drwtNo2'] = dataConvertedToJSON['drwtNo2'];
        data['drwtNo3'] = dataConvertedToJSON['drwtNo3'];
        data['drwtNo4'] = dataConvertedToJSON['drwtNo4'];
        data['drwtNo5'] = dataConvertedToJSON['drwtNo5'];
        data['drwtNo6'] = dataConvertedToJSON['drwtNo6'];
        data['bnusNo'] = dataConvertedToJSON['bnusNo'];
        data['totSellamnt'] = dataConvertedToJSON['totSellamnt'];
        data['firstWinamnt'] = dataConvertedToJSON['firstWinamnt'];
        data['firstPrzwnerCo'] = dataConvertedToJSON['firstPrzwnerCo'];
        data['firstAccumamnt'] = dataConvertedToJSON['firstAccumamnt'];
      });
    } else {
      throw Exception('API 요청실패');
    }
  }
}

// 비동기를 통해 네트워크 요청
Future fetchPost(String tempNo) async {
  // 지정된 회차의 당첨 정보를 읽어온다.
  // await Future.delayed(
  //     const Duration(milliseconds: 4)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.

  String page = tempNo;
  String lottoUrl =
      'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$page'; // 동행복권 Lotto api url

  final response = await http.get(Uri.parse(lottoUrl)); // http 데이터를 가져온다.
  var LottoNums = []; // 날짜, 회차, 로또 당첨 번호

  // 만약 서버 상태 코드가 200과 함께 OK 응답을 반환하면, JSON을 파싱한다.
  if (response.statusCode == 200) {
    final nums = await json.decode(response.body);

    // 필요한 정보만을 가져온다.
    LottoNums.add(nums['drwNoDate']); // 날짜
    LottoNums.add(nums['drwNo']); // 회차
    LottoNums.add(nums['drwtNo1']); // 번호1
    LottoNums.add(nums['drwtNo2']); // 번호2
    LottoNums.add(nums['drwtNo3']); // 번호3
    LottoNums.add(nums['drwtNo4']); // 번호4
    LottoNums.add(nums['drwtNo5']); // 번호5
    LottoNums.add(nums['drwtNo6']); // 번호6
    LottoNums.add(nums['bnusNo']); // 보너스 번호

    return '추첨 회차는 ${nums['drwNo']} 이며,  \n\n'
        '당첨 번호는 ${nums['drwtNo1']},${nums['drwtNo2']},${nums['drwtNo3']},${nums['drwtNo4']},${nums['drwtNo5']},${nums['drwtNo6']} + 보너스 번호 ${nums['bnusNo']}입니다.';

    // return LottoNums;
  } else {
    return "Error";
  }
}
