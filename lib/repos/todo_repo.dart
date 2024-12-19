import 'package:hive/hive.dart';
import 'package:learning_app/models/hive_models/task_config.dart';
import 'package:learning_app/models/hive_models/todo.dart';
import 'package:learning_app/services/db_service.dart';

class TodoRepo implements IHiveService<Todo> {
  late Box<Todo> _box;

  @override
  Future<void> init() async {
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(TaskConfigAdapter());
    _box = await Hive.openBox<Todo>("todos");
  }
 
 @override
  Future<List<Todo>> getAllWithPredicate(bool Function(Todo) predicate) async {
    return _box.values.where(predicate).toList();
  }

  @override
  Future<List<Todo>> search(String searchValue) async {
    return _box.values.where((item) => item.task == searchValue || item.description == searchValue).toList();
  } 

  @override
  Future<List<Todo>> searchAndPaginate(String searchValue, int pageNo, int pageSize) async {
    return _box.values.where((item) => item.task == searchValue || item.description == searchValue).skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> add(Todo item) async {
    await _box.add(item);
  }

  @override
  Future<void> addOrUpdate(Todo item) async {
    if (_box.values.any((element) => item.id == element.id)) {
      var bar = await getFirst(item.id.toString());
      update(bar?.key, item);
    } else {
      await add(item);
    }
  }

  @override
  Future<void> addOrUpdateRange(List<Todo> items) async {
    for (var item in items) {
      if (_box.values.any((element) => item.id == element.id)) {
        var bar = await getFirst(item.id.toString());
        update(bar?.key, item);
      } else {
        await add(item);
      }
    }
  }

  @override
  Future<void> deleteAllAndAdd(Todo item) async {
    await _box.clear();
    await _box.add(item);
  }

  @override
  Future<void> deleteAllAndAddRange(List<Todo> items) async {
    await _box.clear();
    await _box.addAll(items);
  }

  @override
  Future<void> addRange(List<Todo> items) async {
    await _box.addAll(items);
  }

  @override
  Future<Todo> get(dynamic key) async {
    return _box.get(key)!; // Make sure to handle null according to your app's needs
  }

  @override
  Future<Todo?> getFirst(String id) async {
    for (var element in _box.values) {
      if (element.id==id) return element;
    }
    return null;
  }

  @override
  Future<Todo?> getFirstOrDefault() async {
    if (_box.values.isNotEmpty) {
      return _box.values.first;
    }
    return null;
  }

  @override
  Future<List<Todo>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<List<Todo>> getAllAndPaginate(int pageNo, int pageSize) async {
    return _box.values.skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> update(dynamic key, Todo updatedItem) async {
    await _box.put(key, updatedItem);
  }

  @override
  Future<void> delete(dynamic key) async {
    await _box.delete(key);
  }

  @override
  Future<void> deleteAll() async {
    await _box.clear();
  }

  @override
  int get length => _box.length;

  @override
  Future<void> close() async {
    if(_box.isOpen){
      await _box.close();
    }
  }

  @override
  Future<void> reOpenBox() async {
    if(_box.isOpen){
      await close();
    }
    _box = await Hive.openBox<Todo>("todos");
  }
}