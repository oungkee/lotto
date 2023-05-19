import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http 패키지 추가.
import 'dart:convert'; // json을 수동으로 직렬화 시키기 위해 convert 패키지 추가.
import 'dart:async'; //timer 를 사용하기 위함 package
import 'wgseo_module.dart';
import 'cp949_uni_conversion.dart';

class informNum extends StatefulWidget {
  const informNum({Key? key}) : super(key: key);

  @override
  State<informNum> createState() => _informNumState();
}

class _informNumState extends State<informNum> {
  //해당 회차의 당첨 정보를 기록하기 위한 글러벌 Map 변수 선언.
  var data = {};

  @override
  void initState() {
    // 최초 시작될 때 실행.
    super.initState();
    // 1. 현 회차를 불러온다.
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
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        wgseo_Sized_Heigh(),
        // data Map 에 등록된 값을 Text 값으로 표시하고, showFormatNum 함수를 통하여 천단위 , 를 표시한다.
        Text('현재 추첨 회차는 ${showFormatNum(data['drwNo'].toString())} 회 입니다'),
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
            '금주 총 판매금액 ${showFormatNum(data['totSellamnt'].toString())} 원 입니다.'),
        wgseo_Sized_Heigh(),
        Text(
            '금주 1등 총 담첨금액은 ${showFormatNum(data['firstAccumamnt'].toString())} 원 입니다'),
        wgseo_Sized_Heigh(),
        Text(
            '1등 당첨 게임수 는 ${showFormatNum(data['firstPrzwnerCo'].toString())} 게임 입니다.'),
        wgseo_Sized_Heigh(),
        Text(
            '1게임당 당첨금액은 ${showFormatNum(data['firstWinamnt'].toString())} 원 입니다'),
      ],
    ));
  }

  Future<void> fetchNowGameNo() async {
    //1. 현재의 추첨회차를 읽어온다.
    // await Future.delayed(
    //     const Duration(milliseconds: 2)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.

    final response = await http
        .get(Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin'));

    // 한글이 깨지는 경우 cp949toUni 를 통하여 한글로 변환.
    var tempStr = cp949toUni(response.body.codeUnits);

    // 반환된 json 데이터를 resultNo에 넣는다.
    var resultNo = tempStr.substring(
        // substring으로 문자를 자른다
        tempStr.indexOf(
              // indexOf 를 통하여 자를 글자의 시작과 끝점을 지정하여 Result 변수에 값을 저장한다.
              'content="동행복권 ',
            ) +
            14,
        tempStr.indexOf('회 당첨번호'));

    // getJSONData 함수에 현재의 추첨 회차를 넣어 데이터를 조회한다.
    getJSONData(resultNo);
  }

  Future<void> getJSONData(String tempNo) async {
    // 2. 지정된 회차의 당첨번호를 JSON으로 받아 data Map 변수에 저장한다.
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
      // 데이터 호출에 실패하는 경우 오류 표시.
      throw Exception('API 요청실패');
    }
  }
}
