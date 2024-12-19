import 'package:hive/hive.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/answer_list.dart';
import 'package:learning_app/models/hive_models/assessment.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
import 'package:learning_app/models/hive_models/question_list.dart';
import 'package:learning_app/models/hive_models/quiz.dart';
import 'package:learning_app/models/hive_models/rules.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/services/db_service.dart';

class SubjectRepo implements IHiveService<Subject> {
  late Box<Subject> _box;

  @override
  Future<void> init() async {
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(ActivityAdapter());
    Hive.registerAdapter(RulesAdapter());
    Hive.registerAdapter(AssessmentAdapter());
    Hive.registerAdapter(QuizAdapter());
    Hive.registerAdapter(AnswerListAdapter());
    Hive.registerAdapter(QuestionListAdapter());
    _box = await Hive.openBox<Subject>("subjects");
  }

   @override
  Future<List<Subject>> getAllWithPredicate(bool Function(Subject) predicate) async {
    return _box.values.where(predicate).toList();
  }
 
  @override
  Future<List<Subject>> search(String searchValue) async {
    return _box.values.where((item) => item.title == searchValue).toList();
  } 

  @override
  Future<List<Subject>> searchAndPaginate(String searchValue, int pageNo, int pageSize) async {
    return _box.values.where((item) => item.title == searchValue).skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> add(Subject item) async {
    await _box.add(item);
  }

  @override
  Future<void> addOrUpdate(Subject item) async {
    if (_box.values.any((element) => item.courseId == element.courseId)) {
      var bar = await getFirst(item.courseId.toString());
      update(bar?.key, item);
    } else {
      await add(item);
    }
  }

  @override
  Future<void> addOrUpdateRange(List<Subject> items) async {
    for (var item in items) {
      if (_box.values.any((element) => item.courseId == element.courseId)) {
        var bar = await getFirst(item.courseId.toString());
        update(bar?.key, item);
      } else {
        await add(item);
      }
    }
  }

  @override
  Future<void> deleteAllAndAdd(Subject item) async {
    await _box.clear();
    await _box.add(item);
  }

  @override
  Future<void> deleteAllAndAddRange(List<Subject> items) async {
    await _box.clear();
    await _box.addAll(items);
  }

  @override
  Future<void> addRange(List<Subject> items) async {
    await _box.addAll(items);
  }

  @override
  Future<Subject> get(dynamic key) async {
    return _box.get(key)!; // Make sure to handle null according to your app's needs
  }

  @override
  Future<Subject?> getFirst(String id) async {
    for (var element in _box.values) {
      if (element.courseId==id) return element;
    }
    return null;
  }

  @override
  Future<Subject?> getFirstOrDefault() async {
    if (_box.values.isNotEmpty) {
      return _box.values.first;
    }
    return null;
  }

  @override
  Future<List<Subject>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<List<Subject>> getAllAndPaginate(int pageNo, int pageSize) async {
    return _box.values.skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> update(dynamic key, Subject updatedItem) async {
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
    _box = await Hive.openBox<Subject>("users");
  }
}