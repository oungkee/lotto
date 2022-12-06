import 'package:flutter/material.dart';
// 팝업 toast 를 사용하기 위한 패키지. (main 에서 최초 import 하여 사용해야 함)
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'informNum.dart'; // 당첨번호 및 등록번호 당첨 여부
import 'manageNum.dart'; // 번호 관리
import 'makeNum.dart'; // 번호 생성
// import 'test.dart'; //테스트
import 'history.dart'; //이력
import 'rank.dart'; //랭크

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i do not auto lotto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //=== EasyLoding 패키지를 사용하기 위해서는 Material App에서 전처리를 해줘야 한다.=======
      builder: (BuildContext context, Widget? child) {
        return FlutterEasyLoading(
            child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: child,
        ));
      },
      //=== EasyLoding 패키지를 사용하기 위해서는 Material App에서 전처리를 해줘야 한다.=======
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
    // page 변수를 index 별 이동할 클래스를 설정한다. 0,1,2
    const informNum(),
    manageNum(),
    const makeNum(),
    const history(),
    const rank(),
  ];

  @override
  void initState() {
    super.initState();
    // 정상적으로 EasyLoading 패키지가 적용되었는지 확인.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   EasyLoading.showSuccess('Use in initState');
    // });
  }

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
              // color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨.
            ),
            onPressed: () {},
          )
        ],
        centerTitle: true, // 앱바 타이블을 가운데 정렬
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // 중요!! item이 4개 이상일 경우 추가
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
            BottomNavigationBarItem(
              label: '이력',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: '랭킹',
              icon: Icon(Icons.cyclone),
            ),
          ]),
    );
  }
}
