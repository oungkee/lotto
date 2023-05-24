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

  // 할 일 추가 메서드
  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoContoller.text = ''; //할 일 입력 필드를 비움.
    });
  }

  // 할 일 삭제 메서드
  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  // 할 일 완료/미완료 메서드
  void _toggleTodo(Todo todo) {
    setState(() {
      //isDone 프로퍼티값을 변경하고 setState() 함수로 UI를 다시 그리는 메서스들입니다.
      todo.isDone = !todo.isDone;
    });
  }

  @override
  // build 메서드
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
                onPressed: () {
                  _addTodo(Todo(_todoContoller.text));
                },
                child: const Text('추가'),
              ),
            ],
          ),
          //Expanded 로 묶어야 위의 Row 열 이외의 항목은 화면을 가득 채운다.
          Expanded(
            child: ListView(
              children: _items.map((todo) => _buildItemWidget(todo)).toList(),
            ),
          )
        ],
      ),
    );
  }

  //할일 객체를 ListTile 형태로 변경하는 메서드(함수) (Todo todo) 와 같이 클래스를 상속받아 사용할 수 있다.
  Widget _buildItemWidget(Todo todo) {
    return ListTile(
        //클릭 시 완료/취소되도록 수정.
        onTap: () {
          _toggleTodo(todo); // 완료/미완료 메서드 실행.
        },
        title: Text(
          // 할 일
          todo.title,
          // 완료일 때는 스타일 적용
          style: todo.isDone
              ? const TextStyle(
                  decoration: TextDecoration.lineThrough, //완료되면 취소선
                  fontStyle: FontStyle.italic, //이탤릭체
                )
              // 완료되지 않았다면 style 변경은 없다.
              : null,
        ),
        trailing: IconButton(
          // 리스트 타일의 아이콘 버튼
          //리스트타일에 사용
          icon: const Icon(Icons.delete_forever), //휴지통 아이콘
          onPressed: () {
            _deleteTodo(todo); // 삭제 메서드 실행.
          }, //쓰레기통 클릭 시 삭제되도록.
        ));
  }
}

//할일 클래스
class Todo {
  bool isDone = false;
  String title = '';

  Todo(this.title);
}
