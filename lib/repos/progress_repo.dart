import 'package:hive/hive.dart';
import 'package:learning_app/models/hive_models/progress.dart';
import 'package:learning_app/models/hive_models/result.dart';
import 'package:learning_app/models/hive_models/score.dart';
import 'package:learning_app/models/hive_models/student_answer.dart';
import 'package:learning_app/services/db_service.dart';

class ProgressRepo implements IHiveService<Progress> {
  late Box<Progress> _box;

  @override
  Future<void> init() async {
    Hive.registerAdapter(ProgressAdapter());
    Hive.registerAdapter(ResultAdapter());
    Hive.registerAdapter(ScoreAdapter());
    Hive.registerAdapter(StudentAnswerAdapter());
    _box = await Hive.openBox<Progress>("progress");
  }

   @override
  Future<List<Progress>> getAllWithPredicate(bool Function(Progress) predicate) async {
    return _box.values.where(predicate).toList();
  }
 
  @override
  Future<List<Progress>> search(String searchValue) async {
    return _box.values.where((item) => item.id == searchValue).toList();
  } 

  @override
  Future<List<Progress>> searchAndPaginate(String searchValue, int pageNo, int pageSize) async {
    return _box.values.where((item) => item.id == searchValue).skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> add(Progress item) async {
    await _box.add(item);
  }

  @override
  Future<void> addOrUpdate(Progress item) async {
    if (_box.values.any((element) => item.id == element.id)) {
      var bar = await getFirst(item.id.toString());
      update(bar?.key, item);
    } else {
      await add(item);
    }
  }

  @override
  Future<void> addOrUpdateRange(List<Progress> items) async {
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
  Future<void> deleteAllAndAdd(Progress item) async {
    await _box.clear();
    await _box.add(item);
  }

  @override
  Future<void> deleteAllAndAddRange(List<Progress> items) async {
    await _box.clear();
    await _box.addAll(items);
  }

  @override
  Future<void> addRange(List<Progress> items) async {
    await _box.addAll(items);
  }

  @override
  Future<Progress> get(dynamic key) async {
    return _box.get(key)!; // Make sure to handle null according to your app's needs
  }

  @override
  Future<Progress?> getFirst(String id) async {
    for (var element in _box.values) {
      if (element.id==id) return element;
    }
    return null;
  }

  @override
  Future<Progress?> getFirstOrDefault() async {
    if (_box.values.isNotEmpty) {
      return _box.values.first;
    }
    return null;
  }

  @override
  Future<List<Progress>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<List<Progress>> getAllAndPaginate(int pageNo, int pageSize) async {
    return _box.values.skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> update(dynamic key, Progress updatedItem) async {
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
    _box = await Hive.openBox<Progress>("users");
  }
}