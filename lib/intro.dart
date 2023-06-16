import 'package:flutter/material.dart';
import 'dart:async'; //timer 를 사용하기 위함 package
import 'main.dart';
import 'package:lottie/lottie.dart'; // 애니메이션을 사용하기 위한 package

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    // 5초 지연 후 onDoneLoading 으로 페이지 이동한다.
    // return Timer(Duration(seconds: 3), onDoneLoading);
    //테스트 기간에는 1초로 한다.
    return Timer(Duration(milliseconds: 30), onDoneLoading);
  }

  // 지연이 완료 된 후
  onDoneLoading() async {
    // 인트로가 완료되면 다시 main의 MyHome 위젯으로 이동한다.
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar 없이 진행.
      body: Container(
        // 중앙 정렬
        alignment: Alignment.center,
        child: Column(
          // 가로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,
          // 세로 중앙 정렬
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // height: 300,
              // width: 300,
              //사이즈 박스에 Lottie 애니메이션 삽입
              // child: Lottie.asset('assets/96916-searching.zip'),
              child: Lottie.asset('assets/animation.json'),
            )
          ],
        ),
      ),
    );
  }
}
