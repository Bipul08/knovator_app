import 'dart:async';
import 'dart:math';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> posts = [];
  Set<int> readPosts = {};  // Set to track read posts
  Map<int, int> timers = {};
  Map<int, Timer?> activeTimers = {};

  // Load posts and read state from local storage
  Future<void> loadPosts() async {
    // Load posts from local storage
    List<Map<String, dynamic>> localPosts = await StorageUtil.getPosts('posts');
    if (localPosts.isNotEmpty) {
      posts = localPosts.map((data) => Post.fromJson(data)).toList();
    } else {
      // If no posts in storage, fetch from API
      posts = await _apiService.fetchPosts();
      await StorageUtil.savePosts(
        'posts',
        posts.map((post) => post.toJson()).toList(),
      );
    }

    // Load timers from local storage
    Map<String, dynamic> savedTimers = await StorageUtil.getTimers('timers');
    for (var post in posts) {
      timers[post.id] = savedTimers[post.id.toString()] ?? 0;
    }

    // Load readPosts from storage
    List<dynamic> savedReadPosts = await StorageUtil.getReadPosts('readPosts');
    readPosts = savedReadPosts.map((id) => int.parse(id)).toSet();

    notifyListeners(); // Notify listeners when data is loaded
  }

  // Start a timer for a specific post
  void startTimer(int postId) {
    if (activeTimers[postId] == null) {
      activeTimers[postId] = Timer.periodic(const Duration(seconds: 1), (timer) {
        timers[postId] = timers[postId]! + 1;
        _saveTimersToStorage();
        notifyListeners();
      });
    }
  }

  void stopTimer(int postId) {
    activeTimers[postId]?.cancel();
    activeTimers[postId] = null;
    _saveTimersToStorage(); // Save timers to SharedPreferences
    notifyListeners();
  }

  // Mark a post as read and save it to SharedPreferences
  void markAsRead(int postId) async {
    readPosts.add(postId);
    await StorageUtil.saveReadPosts('readPosts', readPosts.map((id) => id.toString()).toList());
    notifyListeners();
  }

  // Save timers to SharedPreferences
  Future<void> _saveTimersToStorage() async {
    await StorageUtil.saveTimers(
      'timers',
      timers.map((key, value) => MapEntry(key.toString(), value)),
    );
  }

  // Fetch detailed post data
  Future<Post> getPostDetail(int postId) async {
    return await _apiService.fetchPostDetail(postId);
  }
}
