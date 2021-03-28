import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/src/repositories/todo_repository.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final todoRepository = TodoRepository(dio);

  when(dio.get(any))
      .thenAnswer((_) async => Response(data: jsonDecode(jsonData)));

  test('should returna  list of TodoModel', () async {
    final list = await todoRepository.fetchTodos();
    expect(list[1].title, 'quis ut nam facilis et officia qui');
  });
}

String jsonData = '''
[
  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  },
  {
    "userId": 1,
    "id": 3,
    "title": "fugiat veniam minus",
    "completed": false
  }
]
 ''';
