import 'package:flutter/material.dart';
// 팝업 toast 를 사용하기 위한 패키지. (main 에서 최초 import 하여 사용해야 함)
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'intro.dart'; // 인트로 화면 표시를 위해.
import 'informNum.dart'; // 당첨번호 및 등록번호 당첨 여부
import 'manageNum.dart'; // 번호 관리
import 'makeNum.dart'; // 번호 생성
// import 'test.dart'; //테스트
import 'history.dart'; //이력
import 'rank.dart'; //랭크
// import 'package:hive/hive.dart'; //저장을 위한 hive 패키지.
import 'package:firebase_core/firebase_core.dart'; //firebase 사용을 위한 패키지.
import 'firebase_options.dart'; //파일의 구성으로 firebase_core 패키지에서 Firebase.initializeApp을 호출한다.
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //Firebase 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I do not auto lotto',
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
      home: IntroPage(),
      // home: LoginPage(),
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
  // final _pages = [
  //   // page 변수를 index 별 이동할 클래스를 설정한다. 0,1,2
  //   const informNum(),
  //   manageNum(),
  //   makeNum(),
  //   const history(),
  //   const rank(),
  // ];

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
          'I do not auto',
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
      //[@2022-12-08] 중요!!'
      // 탭바 화면 전환 시 이전 화면이 초기화 되는 것을 방지하기 위해 IndexedStack 을 사용한다.
      body: IndexedStack(index: _index, children: const [
        // 각 탭의 화면을 지정해 준다.
        informNum(),
        manageNum(),
        makeNum(),
        history(),
        rank()
      ]),
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
