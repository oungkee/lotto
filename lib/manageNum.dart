import 'package:flutter/material.dart';
import 'common_Size.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _bulidTop(),
      ),
    );
  }

  _bulidTop() {
    return Column(
      children: [
        common_Sized_Heigh(),
        const Text('관리할 번호를 입력 하십시오.'),
        common_Sized_Heigh(),
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
              onPressed: () {},
              child: Text('SAVE'),
            ),
            common_Sized_Weight(),
          ],
        ),
      ],
    );
  }

  _initTextFormField(var number) {
    return Flexible(
      child: TextFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText:
                // 차후 텍스트 입력 상자에서 줄바꿈이 가능한지 확인할 것 (현재는 줄바꿈 적용이 안됨)
                '?'),
        controller: number,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
