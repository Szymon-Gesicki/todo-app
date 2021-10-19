import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  late Box _mainBox;

  StorageService() {}

  Future init() async {
    await Hive.initFlutter();
    _mainBox = await Hive.openBox("main_box");
  }

  void put(String key, dynamic value) {
    _mainBox.put(key, value);
  }

  dynamic get(String key, dynamic defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue);
  }

  int getInt(String key, int defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as int;
  }

  double getDouble(String key, double defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as double;
  }

  bool getBool(String key, bool defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as bool;
  }

  String? getString(String key, String? defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as String?;
  }

  List<String> getStringList(String key, List<String> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as List<String>;
  }

  List<int> getIntList(String key, List<int> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as List<int>;
  }

  List<dynamic> getDynamicList(String key, List<dynamic> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as List<dynamic>;
  }

  Map<dynamic, dynamic> getDynamicMap(
      String key, Map<dynamic, dynamic> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue)
        as Map<dynamic, dynamic>;
  }

  List<bool> getBoolList(String key, List<bool> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as List<bool>;
  }

  List<double> getDoubleList(String key, List<double> defaultValue) {
    return _mainBox.get(key, defaultValue: defaultValue) as List<double>;
  }
}
