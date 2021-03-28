import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/src/controllers/home_controller.dart';
import 'package:todo_list/src/models/todo_mode.dart';
import 'package:todo_list/src/repositories/todo_repository.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

main() {
  final todoRepository = TodoRepositoryMock();
  final todoController = HomeController(todoRepository);
  test("should fill todos variable", () async {
    when(todoRepository.fetchTodos())
        .thenAnswer((realInvocation) async => [TodoModel()]);
    expect(todoController.state.value, HomeState.starting);
    await todoController.start();
    expect(todoController.state.value, HomeState.success);
    expect(todoController.todos.isNotEmpty, true);
  });

  test("should thow error and change state", () async {
    when(todoRepository.fetchTodos()).thenThrow(Exception());
    expect(todoController.state.value, HomeState.starting);
    await todoController.start();
    expect(todoController.state.value, HomeState.error);
  });
}
