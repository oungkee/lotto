import 'package:flutter/material.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  // 할 일 목록을 저장할 리스트
  final _items = <Todo>[];
  // 할 일 문자열 조작을 위한 컨트롤러
  final _todoContoller = TextEditingController();

  @override
  void dispose() {
    // 사용이 끝나면 해제.
    _todoContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              // Expanded 영억으로 감싸는 경우 같은 행의 추가버튼 이외의 공간을 가득 채운다.
              Expanded(
                child: TextField(
                  controller: _todoContoller,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('추가'),
              ),
            ],
          ),
          //Expanded 로 묶어야 위의 Row 열 이외의 항목은 화면을 가득 채운다.
          Expanded(
            child: ListView(
              children: [],
            ),
          )
        ],
      ),
    );
  }

//   //할일 객체를 ListTile 형태로 변경하는 메서드(함수) (Todo todo) 와 같이 클래스를 상속받아 사용할 수 있다.
//   _buildItemWidget(Todo todo) {
//     return ListTile(
//       //클릭 시 완료/취소되도록 수정.
//       onTap: () {},
//       title: Text(
//         // 할 일
//         todo.title,
//         // 완료일 때는 스타일 적용
//         // style: todo.isDone?TextStyle(
//         //
//         // ),
//       ),
//     );
//   }
}

//할일 클래스
class Todo {
  bool isDone = false;
  String title = '';

  Todo(this.title);
}
