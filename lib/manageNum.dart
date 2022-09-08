import 'package:flutter/material.dart';
import 'common_Size.dart';
// 내부 저장소를 사용하기 위한 외부 패키지.
import 'package:shared_preferences/shared_preferences.dart';

class manageNum extends StatefulWidget {
  const manageNum({Key? key}) : super(key: key);

  @override
  State<manageNum> createState() => _manageNumState();
}

class _manageNumState extends State<manageNum> {
  final _num1 = TextEditingController();
  final _num2 = TextEditingController();
  final _num3 = TextEditingController();
  final _num4 = TextEditingController();
  final _num5 = TextEditingController();
  final _num6 = TextEditingController();
  final _remarks = TextEditingController();

  // 내부 저장소에 저장할 변수.
  String _saveData = '';

  void _setData(String value) async {
    // 저장소에 저장될 key 값.
    var key = 'data';
    // pref 변수에 인스턴스를 호출한다.
    SharedPreferences pref = await SharedPreferences.getInstance();
    // 키, 값 으로 데이터를 저장한다.
    pref.setString(key, value);
  }

  void _loadData(String tempKey) async {
    // var key = 'data';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getString(tempKey);
      if (value == null) {
        _saveData = '';
      } else {
        _saveData = value;
      }
    });
  }

  void _delData(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // key 가 전달받은 인자 key 의 값 삭제
    _saveData = '';

    // 모든 데이터 삭제
    // pref.clear();
  }

  @override
  void initState() {
    super.initState();
    _loadData('data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildTop(),
            common_Sized_Heigh(),
            const Text('관리번호 List'),
            common_Sized_Heigh(),
            _buildMiddle(),
          ],
        ),
      ),
    );
  }

  _buildTop() {
    return Column(
      children: [
        common_Sized_Heigh(),
        const Text('관리할 번호를 입력 하십시오.'),
        // common_Sized_Heigh(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: _remarks,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '내용을 입력하세요.',
            ),
            //============================
            onChanged: (text) {
              super.setState(() {
                // 공백은 삭제한다.
                // _counter = _remarks.text;
                _saveData = _remarks.text;
                _setData(_saveData);
              });
            },
            //============================
          ),
        ),
        Row(
          children: [
            common_Sized_Weight(),
            _initTextFormField(_num1),
            common_Sized_Weight(),
            _initTextFormField(_num2),
            common_Sized_Weight(),
            _initTextFormField(_num3),
            common_Sized_Weight(),
            _initTextFormField(_num4),
            common_Sized_Weight(),
            _initTextFormField(_num5),
            common_Sized_Weight(),
            _initTextFormField(_num6),
            common_Sized_Weight(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // 입력되지 않은 정보가 있는지 검증한다
                  _checkData;
                  // _delData('data');
                });
              },
              child: const Text('SAVE'),
            ),
            common_Sized_Weight(),
          ],
        ),
      ],
    );
  }

  _checkData() {
    // if (int.parse(_num1.toString()) > 0 && int.parse(_num1.toString()) < 47) {
    if (int.parse(_num1.toString()) > 0) {
      // print('overleng');
      AlertDialog dialog = const AlertDialog(
        content: Text('dsgag'),
      );
    } else {
      //
    }
  }

  _buildMiddle() {
    return Expanded(
      //!!!!중요 Column 내부에 List View를 작성하는 경우 Expanded 위젯으로 감싸야 한다.
      child: ListView(
        // shrinkWrap: true, // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정해야 함
        children: [
          Text('저장된 숫자는 $_saveData 입니다.'),
        ],
      ),
    );
  }

  _initTextFormField(var number) {
    return Flexible(
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText:
              // 차후 텍스트 입력 상자에서 줄바꿈이 가능한지 확인할 것 (현재는 줄바꿈 적용이 안됨)
              '?',
        ),
        controller: number,
        keyboardType: TextInputType.number,
        onChanged: (text) {
          super.setState(() {
            _checkData();
          });
        },
        validator: (value) {
          RegExp regExp = RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');
          // RegExp(r'^[+]?([0-9]+([0-9]*)?|[0-9]+)$');
          if (value!.trim().isEmpty) {
            return "숫자를 입력 하세요.";
          } else if (!regExp.hasMatch(value.trim())) {
            return "숫자만 입력되어야 합니다.";
          }
          return null;
        },
      ),
    );
  }
}
