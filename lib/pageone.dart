import 'package:flutter/material.dart';
// 당첨 번호 표시 및 당첨여부를 확인 할 수 있도록 함.
// 하단에는 리스트로 자신의 번호를 관리할 수 있도록 입력 받는다.

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Number',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('true Numbers'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('33 Count true number is as below'),
            Row(
              children: [
                Text('1,2,3,4,5,6 + 7'),
              ],
            ),
            ListView(
                //  번호를 저장하기 위한 리스트
                )
          ],
        ),
      ),
    );
  }
}
