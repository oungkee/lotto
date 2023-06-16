import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //정수만 입력 받기 위해 사용될 패키지.inputFormatters
import 'wgseo_module.dart';
// toast 및 로딩 사용을 위한 패키지. (Main에 Import 해도 실제 사용 폼에서도 import 해야 한다.)
import 'package:flutter_easyloading/flutter_easyloading.dart';

class manageNum extends StatefulWidget {
  const manageNum({Key? key}) : super(key: key);
  @override
  State<manageNum> createState() => _manageNumState();
}

// 테스트 입니다.
class _manageNumState extends State<manageNum> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKeyRemark = GlobalKey<FormState>();

  final _num1 = TextEditingController();
  final _num2 = TextEditingController();
  final _num3 = TextEditingController();
  final _num4 = TextEditingController();
  final _num5 = TextEditingController();
  final _num6 = TextEditingController();
  final _remarks = TextEditingController();

  // 포커스 노드 선언 (late 선언?)
  FocusNode? _focus1;
  FocusNode? _focus2;
  FocusNode? _focus3;
  FocusNode? _focus4;
  FocusNode? _focus5;
  FocusNode? _focus6;
  FocusNode? _focusRemark;

  void _addNumber(LottoNo lottoNo) {
    // String tempNo = '';
    // tempNo = '$_num1,$_num2,$_num3,$_num4,$_num5,$_num6';

    // 새로운 문서를 lottoNo 컬렉션에 Map 형식 데이터로 저장한다.
    FirebaseFirestore.instance.collection('lottoNo').add({
      'lottoDesc': lottoNo.lottoDesc,
      'lottoNums': lottoNo.lottoNums,
      'lottoType': lottoNo.lottoType,
      'timeStamp': Timestamp.now(),
    });
    // 입력상자 초기화.
    _num1.text = '';
    _num2.text = '';
    _num3.text = '';
    _num4.text = '';
    _num5.text = '';
    _num6.text = '';
    _remarks.text = '';
  }

  void _delNumber(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('lottoNo').doc(doc.id).delete();
  }

  @override
  void initState() {
    super.initState();

    _focus1 = FocusNode();
    _focus2 = FocusNode();
    _focus3 = FocusNode();
    _focus4 = FocusNode();
    _focus5 = FocusNode();
    _focus6 = FocusNode();
    _focusRemark = FocusNode();

    // _loadData('1');
  }

  @override
  void dispose() {
    //폼이 삭제되면 발생하는 위젯
    _focus1?.dispose();
    _focus2?.dispose();
    _focus3?.dispose();
    _focus4?.dispose();
    _focus5?.dispose();
    _focus6?.dispose();
    _focusRemark?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildTop(),
            wgseo_Sized_Heigh(),
            const Text('관리번호 List'),
            wgseo_Sized_Heigh(),
            _buildMiddle(),
          ],
        ),
      ),
    );
  }

  _buildTop() {
    return Column(
      children: [
        wgseo_Sized_Heigh(),
        const Text('관리할 번호를 입력 하십시오.'),
        // wgseo_Sized_Heigh(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: Form(
              // 글로벌 key 를 입력 상자에 지정한다, key는 텍스트 필드 상위에 선언해 준다.
              key: _formKeyRemark,
              child: TextFormField(
                // 폼이 시작되면 자동으로 포커스를 가진다.
                autofocus: true,
                controller: _remarks,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내용을 입력하세요.',
                ),
                //============================
                onChanged: (text) {
                  super.setState(() {});
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용은 필수 입력 사항입니다!';
                  }
                  return null;
                },
                //============================
              ),
            ),
          ),
        ),
        Row(
          children: [
            wgseo_Sized_Width(),
            _initTextFormField(_num1, _formKey1, _focus1),
            wgseo_Sized_Width(),
            _initTextFormField(_num2, _formKey2, _focus2),
            wgseo_Sized_Width(),
            _initTextFormField(_num3, _formKey3, _focus3),
            wgseo_Sized_Width(),
            _initTextFormField(_num4, _formKey4, _focus4),
            wgseo_Sized_Width(),
            _initTextFormField(_num5, _formKey5, _focus5),
            wgseo_Sized_Width(),
            _initTextFormField(_num6, _formKey6, _focus6),
            wgseo_Sized_Width(),
          ],
        ),
        wgseo_Sized_Heigh(),
        ElevatedButton(
          onPressed: () {
            if (_formKeyRemark.currentState!.validate()) {
              if (_formKey1.currentState!.validate()) {
                if (_formKey2.currentState!.validate()) {
                  if (_formKey3.currentState!.validate()) {
                    if (_formKey4.currentState!.validate()) {
                      if (_formKey5.currentState!.validate()) {
                        if (_formKey6.currentState!.validate()) {
                          String tempNums =
                              '${_num1.text},${_num2.text},${_num3.text},${_num4.text},${_num5.text},${_num6.text}';

                          _addNumber(LottoNo(_remarks.text, tempNums.toString(),
                              '번호관리', 'wgseo'));
                        } else {
                          FocusScope.of(context).requestFocus(_focus6);
                        }
                      } else {
                        FocusScope.of(context).requestFocus(_focus5);
                      }
                    } else {
                      FocusScope.of(context).requestFocus(_focus4);
                    }
                  } else {
                    FocusScope.of(context).requestFocus(_focus3);
                  }
                } else {
                  FocusScope.of(context).requestFocus(_focus2);
                }
              } else {
                FocusScope.of(context).requestFocus(_focus1);
              }
            } else {
              //오류 발생 시 포커스를 입력 상자로 이동한다.
              FocusScope.of(context).requestFocus(_focusRemark);
            }
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }

  Widget _buildMiddle() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('lottoNo')
            .orderBy('timeStamp',
                descending:
                    true) //정렬을위해 orderby 추가. 입력날짜의 정렬을 내림차순(가장 최근이 먼저)으로 지정하는 경우 descending 추가.try
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final documents = snapshot.data?.docs;
          return Expanded(
            //!!!!중요 Column 내부에 List View를 작성하는 경우 Expanded 위젯으로 감싸야 한다.
            child: ListView(
              // shrinkWrap: true, // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정해야 함
              // children: [documents.map((doc))],
              children: documents!.map((doc) => _buildItemWidget(doc)).toList(),
              // children: documents!.map((doc) => _buildItemWidget(doc)).toList(),
              // documents!.map((doc) => _buildItemWidget(doc)).toList(),
            ),
          );
        });
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final lotto =
        LottoNo(doc['lottoDesc'], doc['lottoNums'], doc['lottoType'], 'wgseo');
    return ListTile(
      onTap: () {},
      title: Text(
        lotto.lottoDesc,
      ),
      subtitle: Text('${lotto.lottoNums} (${lotto.lottoType})'),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () {
          _delNumber(doc);
        },
      ),
    );
  }

  Widget _initTextFormField(var number, var tempKey, var tempFocus) {
    return Flexible(
      child: Form(
        // 글로벌 key 를 입력 상자에 지정한다, key는 텍스트 필드 상위에 선언해 준다.
        key: tempKey,
        child: TextFormField(
          // 각 입력 박스의 포커스를 지정한다.
          focusNode: tempFocus,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText:
                // 차후 텍스트 입력 상자에서 줄바꿈이 가능한지 확인할 것 (현재는 줄바꿈 적용이 안됨)
                '?',
          ),
          //힌트 및 입력 문자 가운데 정렬
          textAlign: TextAlign.center,
          controller: number,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 15,
          ),
          //숫자(0-9)만 입력 받는다.
          // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
          // 위와 같이 입력할 숫자를 강제적으로 정의하거나, 아래와 같이 숫자만 입력 하도록 할 수 있음.
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (text) {
            super.setState(() {
              if (int.parse(text.toString()) > 46) {
                print('입력 숫자 초과');
                // toast 알림.
                EasyLoading.showToast(
                  '입력 숫자가 46을 초과 할 수 없습니다!',
                  // Toast 창 가운데
                  toastPosition: EasyLoadingToastPosition.center,
                );
                // 재입력을 위해 초과된 필드에 포커스를 이동한다.
                FocusScope.of(context).requestFocus(tempFocus);
                // 입력상자 초기화.
                number.text = '';
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              // 반환할 오류
              return '누락';
            } else {
              // 중요! 추후 동일한 숫자가 입력되었는지 검증하는 모듈 추가 할것!!
            }
            return null;
          },
        ),
      ),
    );
  }
}

// firebase 에서 테이블 구조를 사전에 정의할 필요없이 class 에서 정의한 후 업로드 한다.
class LottoNo {
  String lottoDesc = '';
  String lottoNums = '';
  String lottoType = '';
  String lottoUser = '';

  LottoNo(
    this.lottoDesc,
    this.lottoNums,
    this.lottoType,
    this.lottoUser,
  );
}
