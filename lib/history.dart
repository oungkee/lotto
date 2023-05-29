import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  // 할 일 목록을 저장할 리스트
  // final _items = <Todo>[];   //불필요한 상수 삭제.
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
    //새로운 문서를 todo 컬렉션에 Map 형식 데이터로 저장.
    //문서가 저장될 때 자동으로 문서ID가 생성되므로, 문서ID의 정렬 순서에 따라 화면에 표시되는 순서가 달라질 수 있다.(문서명 직접관리 필요)
    FirebaseFirestore.instance
        .collection('todo')
        .add({'title': todo.title, 'isDone': todo.isDone});
    _todoContoller.text = '';
  }

  // 할 일 삭제 메서드
  void _deleteTodo(DocumentSnapshot doc) {
    //삭제할 때도 문서 ID가 필요함, DocumentSnapshot 을 인수로 받음.
    FirebaseFirestore.instance.collection('todo').doc(doc.id).delete();
  }

  // 할 일 완료/미완료 업데이트 메서드
  void _toggleTodo(DocumentSnapshot doc) {
    //특정 문서를 업데이트하기 위해서는 문서ID가 필요함.
    //DocumentSnapshot을 통해 문서ID를 업ㄷ은 후 doc() 메서드에 인수로 전달하고 update()
    FirebaseFirestore.instance.collection('todo').doc(doc.id).update({
      'isDone': !doc['isDone'],
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
          StreamBuilder<QuerySnapshot>(
              //StreamBuilder 를 사용하는 경우 Firestore 의 값이 변경될 때 마다 Builder 부분이 다시 호출되어 화면에 표시 됩니다.
              //4-1. todo 컬렉션에 있는 모든 문서를 스트림으로 얻고, 스트림은 자료가 변경되었을때 반응하여 화면에 다시 그려줌.
              stream: FirebaseFirestore.instance.collection('todo').snapshots(),
              //4-2. builder 프로퍼티를 통하여 BuildContext와 QuerySnapshot 객체가 각각 context와 snapshot으로 넘어옴.
              // 여기서 화면에 넘그려질 UI를 반환하도록 코드작성.
              builder: (context, snapshot) {
                //4-3. snapshot에는 데이터를 포함하여 다양한 정보가 들어있음. snapshot.hasData로 자료 유무를 검증한 한후
                //  자료가 없을때(!) 로딩 표시되도록 작성.
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                //4-4. snapshot.data.docs로 모든 문서를 얻는다.
                final documents = snapshot.data?.docs;
                return Expanded(
                  child: ListView(
                    children:
                        //4-5. docs를 반복하면서 doc을 통해 위젯을 그린다.
                        documents!.map((doc) => _buildItemWidget(doc)).toList(),
                  ),
                );
              })
        ],
      ),
    );
  }

  //할일 객체를 ListTile 형태로 변경하는 메서드(함수) (Todo todo) 와 같이 클래스를 상속받아 사용할 수 있다.
  //Firestore 문서는 DocumentSnapshot 클래스의 인스턴스이며, 이를 받아 Todo 객체를 생성하는 코드
  Widget _buildItemWidget(DocumentSnapshot doc) {
    // final atodo = aTodo(doc['title'], isDone: doc['isDone']);
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
        //클릭 시 완료/취소되도록 수정.
        onTap: () {
          _toggleTodo(doc); // 완료/미완료 메서드 실행.
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
            _deleteTodo(doc); // 삭제 메서드 실행.
          }, //쓰레기통 클릭 시 삭제되도록.
        ));
  }
}

//할일 클래스
class Todo {
  bool isDone = false;
  String title = '';
  //{}로 감싸면 Default 값으로 지정되며, 입력안해도 클래스 오출에 오류가 발생하지 않는다.
  Todo(this.title, {this.isDone = false});
}
