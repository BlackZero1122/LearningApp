import 'package:hive/hive.dart';
import 'package:learning_app/models/hive_models/version_info.dart';
import 'package:learning_app/services/db_service.dart';

class VersionInfoRepo implements IHiveService<VersionInfo> {
  late Box<VersionInfo> _box;

  @override
  Future<void> init() async {
    Hive.registerAdapter(VersionInfoAdapter());
    _box = await Hive.openBox<VersionInfo>("versionInfos");
  }

   @override
  Future<List<VersionInfo>> getAllWithPredicate(bool Function(VersionInfo) predicate) async {
    return _box.values.where(predicate).toList();
  }
 
  @override
  Future<List<VersionInfo>> search(String searchValue) async {
    return _box.values.where((item) => item.id == searchValue).toList();
  } 

  @override
  Future<List<VersionInfo>> searchAndPaginate(String searchValue, int pageNo, int pageSize) async {
    return _box.values.where((item) => item.id == searchValue).skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> add(VersionInfo item) async {
    await _box.add(item);
  }

  @override
  Future<void> addOrUpdate(VersionInfo item) async {
    if (_box.values.any((element) => item.dataItem == element.dataItem)) {
      var bar = await getFirst(item.dataItem.toString());
      update(bar?.key, item);
    } else {
      await add(item);
    }
  }

  @override
  Future<void> addOrUpdateRange(List<VersionInfo> items) async {
    for (var item in items) {
      if (_box.values.any((element) => item.dataItem == element.dataItem)) {
        var bar = await getFirst(item.dataItem.toString());
        update(bar?.key, item);
      } else {
        await add(item);
      }
    }
  }

  @override
  Future<void> deleteAllAndAdd(VersionInfo item) async {
    await _box.clear();
    await _box.add(item);
  }

  @override
  Future<void> deleteAllAndAddRange(List<VersionInfo> items) async {
    await _box.clear();
    await _box.addAll(items);
  }

  @override
  Future<void> addRange(List<VersionInfo> items) async {
    await _box.addAll(items);
  }

  @override
  Future<VersionInfo> get(dynamic key) async {
    return _box.get(key)!; // Make sure to handle null according to your app's needs
  }

  @override
  Future<VersionInfo?> getFirst(String id) async {
    for (var element in _box.values) {
      if (element.dataItem==double.parse(id)) return element;
    }
    return null;
  }

  @override
  Future<VersionInfo?> getFirstOrDefault() async {
    if (_box.values.isNotEmpty) {
      return _box.values.first;
    }
    return null;
  }

  @override
  Future<List<VersionInfo>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<List<VersionInfo>> getAllAndPaginate(int pageNo, int pageSize) async {
    return _box.values.skip(pageNo * pageSize).take(pageSize).toList();
  } 

  @override
  Future<void> update(dynamic key, VersionInfo updatedItem) async {
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
    _box = await Hive.openBox<VersionInfo>("versionInfos");
  }
}