
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static Future<List<Map<String, dynamic>>> getPosts(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data != null ? List<Map<String, dynamic>>.from(json.decode(data)) : [];
  }

  static Future<void> savePosts(String key, List<Map<String, dynamic>> posts) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(posts));
  }

  static Future<Map<String, dynamic>> getTimers(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data != null ? Map<String, dynamic>.from(json.decode(data)) : {};
  }

  static Future<void> saveTimers(String key, Map<String, dynamic> timers) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(timers));
  }

  static Future<List<dynamic>> getReadPosts(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data != null ? List<dynamic>.from(json.decode(data)) : [];
  }

  static Future<void> saveReadPosts(String key, List<dynamic> readPosts) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(readPosts));
  }
}
