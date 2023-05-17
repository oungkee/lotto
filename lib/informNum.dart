import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http 패키지 추가.
import 'dart:convert'; // json을 수동으로 직렬화 시키기 위해 convert 패키지 추가.
import 'dart:async'; //timer 를 사용하기 위함 package
import 'wgseo_module.dart';
import 'cp949_uni_conversion.dart';
import 'package:intl/intl.dart';

class informNum extends StatefulWidget {
  const informNum({Key? key}) : super(key: key);

  @override
  State<informNum> createState() => _informNumState();
}

class _informNumState extends State<informNum> {
  var data = {};
  @override
  void initState() {
    super.initState();
    // return Timer(Duration(seconds: 3), fetchNowGameNo());
    fetchNowGameNo();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Lotto Result numbers',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        wgseo_Sized_Heigh(),

        Text('현재 추첨 회차는 ${data['drwNo'].toString()} 회 입니다'),
        wgseo_Sized_Heigh(),
        wgseo_Sized_Heigh(),
        Text('당첨번호는 ${data['drwtNo1'].toString()}, '
            '${data['drwtNo2'].toString()}, '
            '${data['drwtNo3'].toString()}, '
            '${data['drwtNo4'].toString()}, '
            '${data['drwtNo5'].toString()}, '
            '${data['drwtNo6'].toString()} + '
            '${data['bnusNo'].toString()}(보너스) 입니다.'),

        wgseo_Sized_Heigh(),

        Text(
            '금주 총 판매금액 ${NumberFormat('###,###').format(int.parse(data['totSellamnt'].toString())).replaceAll(' ', '')} 원 입니다.'),
        // Text(
        wgseo_Sized_Heigh(),
        Text(
            '금주 1등 총 담첨금액은 ${NumberFormat('###,###').format(int.parse(data['firstAccumamnt'].toString())).replaceAll(' ', '')} 원 입니다'),
        wgseo_Sized_Heigh(),
        Text(
            '1등 당첨 게임수 는 ${NumberFormat('###,###').format(int.parse(data['firstPrzwnerCo'].toString())).replaceAll(' ', '')} 게임 입니다.'),
        wgseo_Sized_Heigh(),
        Text(
            '1게임당 당첨금액은 ${NumberFormat('###,###').format(int.parse(data['firstWinamnt'].toString())).replaceAll(' ', '')} 원 입니다'),
      ],
    ));
  }

  // writeNumericNumber(String tempStr) {
  //   //전달받은 형식이 숫자가 아닌 경우 공백을 표시한다.
  //   // if ())
  // }

  Future<void> fetchNowGameNo() async {
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
    getJSONData(resultNo);
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

        // Future.delayed(
        //     const Duration(milliseconds: 2)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.
      });
    } else {
      throw Exception('API 요청실패');
    }
  }
}
