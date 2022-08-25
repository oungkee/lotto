import 'package:flutter/material.dart';

import 'informNum.dart'; // 당첨번호 및 등록번호 당첨 여부
import 'manageNum.dart'; // 번호 관리
import 'makeNum.dart'; // 번호 생성

// 다시한번 커밋
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i do not auto lotto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: Colors.white,
      ),
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _index = 0; // 페이지 인덱스 0,1,2
  final _pages = [
    const informNum(),
    const manageNum(),
    const makeNum(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white, //앱바 색상 흰색.
        title: const Text(
          'i do not auto',
          style: TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.bold), // 글자는 검정색
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨.
            ),
            onPressed: () {},
          )
        ],
        centerTitle: true, // 앱바 타이블을 가운데 정렬
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index; //선택된 탭의 인덱스로 _index를 변경.
            });
          },
          currentIndex: _index, //선택된 인덱스
          // items: const <BottomNavigationBarItem>[
          items: const [
            BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: '번호관리',
              icon: Icon(Icons.assignment),
            ),
            BottomNavigationBarItem(
              label: '번호생성',
              icon: Icon(Icons.circle),
            ),
          ]),
    );
  }
}
