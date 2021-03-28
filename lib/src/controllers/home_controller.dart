import 'package:flutter/foundation.dart';
import 'package:todo_list/src/models/todo_mode.dart';
import 'package:todo_list/src/repositories/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  final TodoRepository _todoRepository;
  final state = ValueNotifier<HomeState>(HomeState.starting);

  HomeController([TodoRepository todoRepository])
      : _todoRepository = todoRepository ?? TodoRepository();

  Future start() async {
    try {
      state.value = HomeState.loading;
      todos = await _todoRepository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { starting, loading, success, error }
