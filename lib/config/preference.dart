import 'dart:convert';

import 'package:morph/models/json_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This is a base class for preferences that can be stored in local storage.
/// Ensure call [init] before using the preference.
///
/// [serialize] is used to serialize the object to json string before saving it to local storage,
/// ensure that the object has a [toJson] method.
/// [fromJson] is used to deserialize the json string to object after loading it from local storage.
abstract class Preference<T> {
  Preference(this.key, {this.serialize = false, this.fromJson})
    : assert(
        serialize && fromJson != null,
        'fromJson must be provided if serialize is true',
      );

  final String key;
  final bool serialize;
  final T Function(JsonMap json)? fromJson;

  late final SharedPreferences _sharedPreferences;
  late T? _value;

  T? get value => _value;
  set value(T? newValue) {
    _value = newValue;
    save(newValue);
  }

  /// Saves the new value to local storage.
  Future<void> save(T? newValue) async {
    final value = await switch (newValue) {
      String() => _sharedPreferences.setString(key, newValue),
      int() => _sharedPreferences.setInt(key, newValue),
      double() => _sharedPreferences.setDouble(key, newValue),
      bool() => _sharedPreferences.setBool(key, newValue),
      List<String>() => _sharedPreferences.setStringList(key, newValue),
      null => _sharedPreferences.remove(key),
      _ => _sharedPreferences.setString(
        key,
        serialize
            ? jsonEncode((newValue as dynamic).toJson())
            : newValue.toString(),
      ),
    };
    if (!value) {
      throw Exception('Failed to save preference: $key');
    }
  }

  void init(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
    final rawValue = _sharedPreferences.get(key);
    _value = switch (rawValue) {
      T v => v,
      null => null,
      _ =>
        (serialize && fromJson != null)
            ? fromJson!(jsonDecode(rawValue as String))
            : throw Exception(
              'Failed to deserialize preference: $key, value: $rawValue',
            ),
    };
  }
}
