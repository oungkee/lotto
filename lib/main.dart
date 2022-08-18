import 'package:flutter/material.dart';
// 맥북에어 에서 테스트 합니다.

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'idonotautolotto',
      debugShowCheckedModeBanner: false,
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
  // 텍스트 박스의 문자를 입력 받을 변수.
  String tempChar = '';
  // 입력된 텍스트를 숫자로 변환하여 다시 전달받을 변수
  String ascValue = '';
  // 입력된 텍스트를 숫자로 변환하기 위한 변수.
  double sumAscValue = 0;
  // 텍스트 입력 박스 컨트롤러
  final _inputChar = TextEditingController();
  // 임의의 6개 숫자 저장 리스트 변수.
  List<int> selNums = List<int>.filled(6, 0);

  @override
  void dispose() {
    //위젯 트리에서 해제한다.
    _inputChar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _clearScreen();
  }

  _calAscii() {
    ascValue = '';
    // ascii 코드의 합산을 저장할 double 변수.
    sumAscValue = 1;
    tempChar = tempChar.replaceAll(' ', '');

    for (int i = 0; i < tempChar.length; i++) {
      // codeUnitAt(위치) 특정 문자의 위치를 유니코드로 반환.
      //[@2022-08-08] 가나다, 다나가, 다가나 의 순서와 상관없이 동일한 값이 표현됨. 수정이 필요함.
      sumAscValue = (sumAscValue *
              tempChar.codeUnitAt(i) *
              // 원주율
              3.14159265358979) /
          // 임의숫자
          1228;
    }

    ascValue = ((sumAscValue.toString().replaceAll('.', ''))
        .replaceAll('e', '')
        .replaceAll('+', '')
        .replaceAll(' ', '')
        .replaceAll('0', ''));

    // 리스트 초기화.
    for (int i = 0; i < 6; i++) {
      selNums[i] = 0;
    }

    for (int i = 0; i < 6; i++) {
      int temp = int.parse(ascValue.substring((i * 2) + 0, (i * 2) + 2));

      if (temp > 45) {
        if (temp > 90) {
          temp = temp - 90;
        } else {
          temp = temp - 45;
        }
      }

      while (selNums.contains(temp)) {
        if (temp + 1 > 45) {
          temp = 1;
        } else {
          temp = temp + 1;
        }
      }
      selNums[i] = temp;
    }
    //리스트를 오름 차순으로 정렬한다.
    selNums.sort();
  }

  _showImages(int tempValue) {
    if (tempChar == '') {
      return const Text('');
    } else {
      return (Image.network(
        'http://sstatic.naver.net/keypage/lifesrch/lotto/img/ball${selNums[tempValue].toString()}.gif',
        fit: BoxFit.fill,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('난 로또 자동으로 안해 ver 1.01'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('문자를 입력하십시오'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        // 차후 텍스트 입력 상자에서 줄바꿈이 가능한지 확인할 것 (현재는 줄바꿈 적용이 안됨)
                        '아무 문자나 입력 하십시오. \n Please input the any characters.'),
                controller: _inputChar,
                keyboardType: TextInputType.text,
                //텍스트 변경 시 아래의 메서드를 실행.
                onChanged: (text) {
                  super.setState(() {
                    // 공백은 삭제한다.
                    tempChar = _inputChar.text.replaceAll(' ', '');

                    // 텍스트 입력 상자에 문자가 입력된 경우에만
                    if (tempChar != '') {
                      // 입력받은 문자를 공식에 의해 임의숫자로 변환한다.
                      _calAscii();
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //************************상태 숨김**********************************
              // Text(
              //   // 사용자 입력 문자를 그대로 표시.
              //   tempChar,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   // 입력된 문자를 유니코드로 변환하여 숫자를 합산한 후 문자로 반환.
              //   ascValue,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //     // 입력된 문자를 유니코드로 변환하여 숫자를 합산한 후 문자로 반환.
              //     selNums.toString()),
              // const SizedBox(
              //   height: 20,
              // ),
              //************************상태 숨김**********************************
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _showImages(0),
                  _showImages(1),
                  _showImages(2),
                  _showImages(3),
                  _showImages(4),
                  _showImages(5),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
