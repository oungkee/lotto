import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http 패키지 추가.
import 'package:html/dom.dart' as dom; //웹 크롤링을 위한 dom 패키지 추가.
import 'package:html/parser.dart' as parse; //웹 크롤링을 위한 parse 패키지 추가.
import 'dart:convert'; // json을 수동으로 직렬화 시키기 위해 convert 패키지 추가.
import 'dart:async';
import 'wgseo_module.dart';

class informNum extends StatefulWidget {
  const informNum({Key? key}) : super(key: key);

  @override
  State<informNum> createState() => _informNumState();
}

class _informNumState extends State<informNum> {
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
        wgseo_Sized_Heigh(),
        // FutureBuilder 예시 코드
        FutureBuilder(
            future: fetchPost(),
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
        wgseo_Sized_Heigh(),
        FutureBuilder(
            future: fetchNowSeq(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(snapshot.data.toString());
              }
            }),
      ],
    ));
  }
}

// 비동기를 통해 네트워크 요청
Future fetchPost() async {
  await Future.delayed(
      const Duration(milliseconds: 5)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.

  int page = 994;
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

    return LottoNums;
  } else {
    return "Error";
  }
}

// 비동기를 통해 네트워크 요청
Future fetchNowSeq() async {
  var weather = <String>[];
  var currentTemp = '';

  /*#############################################################################
  final response = await http.get(Uri.parse(
      'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=군포시+날씨'));

  dom.Document document = parse.parse(response.body);

  final temp = document.getElementsByClassName('temperature_text');

  print('temp= $temp');

  weather = temp
      .map((element) => element.getElementsByTagName('strong')[0].innerHtml)
      .toList();

  print('weather = $weather');

  currentTemp = weather[1].replaceAll(RegExp('[^-0-9,.]'), '');

  print('currentTemp = $currentTemp');
  */

  final response = await http
      .get(Uri.parse('https://dhlottery.co.kr/common.do?method=main'));

  dom.Document document = parse.parse(response.body);

  print('body = $document');

  final temp = document.getElementsByClassName('content');

  print('temp= $temp');

  weather = temp
      .map((element) => element.getElementsByTagName('lottoDrwNo')[0].innerHtml)
      .toList();

  print('weather = ${weather.toString()}');

  currentTemp = weather[1].replaceAll(RegExp('[^-0-9,.]'), '');

  print('currentTemp = $currentTemp');

  return currentTemp;
}
